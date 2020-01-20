public with sharing class ExportcsvDemo {
    
    public static void exportNow(){
        
        List<csvReportData__mdt> metaList= getCustomMetadata();
        map<string,list<string>> objtoFieldsMap = getObjectToItsFieldMap(metaList);
        Map<string,string> objectTolookupApiFieldMap=getLookupFieldAPI();
        string finalQueryString = getDynamicQueryFromMeatadata(objtoFieldsMap,objectTolookupApiFieldMap);
        
        
        String generatedCSVFile ='';
        for(csvReportData__mdt dd:metaList){
            if(generatedCSVFile!=''){
                generatedCSVFile+=','+dd.Field_Label__c;
            }else{
                generatedCSVFile+=dd.Field_Label__c;
            } 
        }
        generatedCSVFile+='\n';
        system.debug('headings csv===>'+generatedCSVFile);
        
        String finalSeededData=seedExcelRowsData(finalQueryString,objtoFieldsMap,objectTolookupApiFieldMap);
        
        system.debug('finalSeededData==>'+finalSeededData);  
        sendEmailAction(generatedCSVFile+finalSeededData);  
        
    }
    
    private static string seedExcelRowsData(string finalQueryString, map<string,list<string>> objtoFieldsMap,Map<string,string> objectTolookupApiFieldMap){
        string dataCSV='';
        for(sObject prg:Database.query(finalQueryString)){
            for(string ob:objtoFieldsMap.keySet()){
                for(string fieldStr:objtoFieldsMap.get(ob)){
                    if(objectTolookupApiFieldMap.containsKey(ob)){
                        string refObjField=objectTolookupApiFieldMap.get(ob);
                        
                        if(refObjField!=null && refObjField.contains('__c')){
                            string reletedObjname= refObjField.substring(0,refObjField.length()-3)+'__r';
                            if(prg.getSobject(reletedObjname)!=null){
                                String conName = (string)prg.getSobject(reletedObjname).get(fieldStr.split('-')[0]);
                                dataCSV+=conName+',';
                                System.debug(fieldStr.split('-')[1]+'=='+conName);
                            }else{
                                dataCSV+=',';
                            }
                        }else{
                            string reletedObjname=objectTolookupApiFieldMap.get(ob)+'__r';
                            if(prg.getSobject(reletedObjname)!=null){
                                String conName = (string)prg.getSobject(reletedObjname).get(fieldStr.split('-')[0]);
                                dataCSV+=conName+',';
                                System.debug(fieldStr.split('-')[1]+'=='+conName);
                            }else{
                                dataCSV+=',';
                            }
                        }
                    }else if(ob=='Project__c'){
                        String conName=(string)prg.get(fieldStr.split('-')[0]);
                        dataCSV+=conName+',';
                    }
                }
            }   
            dataCSV+='\n';
        }
        return dataCSV;
    }
    
    private static List<csvReportData__mdt> getCustomMetadata(){
        return [SELECT developername,Field_api_name__c,Field_Label__c,sequence__c,Object_api_name__c 
                FROM csvReportData__mdt  ORDER BY sequence__c ASC];
    }
    
    private static string getDynamicQueryFromMeatadata(map<string,list<string>> objtoFieldsMap,Map<string,string> objectTolookupApiFieldMap){
        
        string queryString='';
        for(string ob:objtoFieldsMap.keySet()){
            for(string fieldStr:objtoFieldsMap.get(ob)){
                if(objectTolookupApiFieldMap.containsKey(ob)){
                    string refObjField=objectTolookupApiFieldMap.get(ob);
                    if(queryString!=''){
                        queryString+=',';
                    }
                    if(refObjField!=null && refObjField.contains('__c')){
                        queryString+= refObjField.substring(0,refObjField.length()-3)+'__r.'+fieldStr.split('-')[0];
                    }else{
                        queryString+=objectTolookupApiFieldMap.get(ob)+'__r'+fieldStr.split('-')[0];
                    }
                }else if(ob=='Project__c'){
                    if(queryString!=''){
                        queryString+=',';
                    }
                    queryString+=fieldStr.split('-')[0];
                }
            }
        }
        String finalQueryString='SELECT '+queryString+' FROM Project__c';
        system.debug('queryString==>'+finalQueryString);
        return finalQueryString;
        
    }
    
    private static map<string,list<string>> getObjectToItsFieldMap(list<csvReportData__mdt> metaList){
        map<string,list<string>> objtoFieldsMap=new map<string,list<string>>();
        for(csvReportData__mdt dd:metaList){
            if(objtoFieldsMap.get(dd.Object_api_name__c)!=null){
                list<string> exList=objtoFieldsMap.get(dd.Object_api_name__c);
                exList.add(dd.Field_api_name__c+'-'+dd.Field_Label__c);
                objtoFieldsMap.put(dd.Object_api_name__c,exList);
            }else{
                objtoFieldsMap.put(dd.Object_api_name__c,new List<string>{dd.Field_api_name__c+'-'+dd.Field_Label__c});
            }
        }
        return objtoFieldsMap;
    }
    
    
    private static Map<string,string> getLookupFieldAPI(){
        Map<string,string> objNameToFieldmap =new Map<string,string> ();
        
        string objName = 'project__c'; // Object name you wish to extract lookup fields for
        map<string, Map<String, Schema.SObjectField>> objectFieldsMap = new map<string, Map<String, Schema.SObjectField>>(); //Object field schema map
        Map<String, Schema.SObjectField> objectFields
            = Schema.getGlobalDescribe()
            .get(objName)
            .getDescribe()
            .fields
            .getMap();
        
        for(Schema.SObjectField fld :objectFields.values()){
            schema.describeFieldResult dfield = fld.getDescribe();
            string fldType = string.valueOf(dfield.getType());   
            if (fldType == 'REFERENCE'){ 
                string resultVar=getObjNameFromLookupField(string.valueOf(dfield.Name));
                if(resultVar!=null && resultVar!='User'){
                    objNameToFieldmap.put(resultVar,string.valueOf(dfield.Name));
                }
            }
        }
        
        System.debug('objNameToFieldmap===>'+objNameToFieldmap);   
        return objNameToFieldmap;
        
    }
    
    
    public static string getObjNameFromLookupField(String fieldName){
        string retResult='';
        Schema.DescribeFieldResult f = Schema.getGlobalDescribe()
            .get('project__c')
            .getDescribe()
            .fields
            .getMap()
            .get(fieldName)
            .getDescribe();
        
        for(Schema.SObjectType reference : f.getReferenceTo()) {
            retResult=reference.getDescribe().getName();
        }
        System.debug('Result --->'+retResult);
        return retResult;
    }
    
    public static void sendEmailAction(string fileRow){
        Messaging.EmailFileAttachment csvAttachment = new Messaging.EmailFileAttachment();
        Blob csvBlob = blob.valueOf(fileRow);
        String csvName = 'contactList details.csv';
        csvAttachment.setFileName(csvName);
        csvAttachment.setBody(csvBlob);
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{'pratap@techilaservices.com'};
            String subject = 'Contact details CSV';
        email.setSubject(subject);
        email.setToAddresses(toAddresses);
        email.setPlainTextBody('Contact details as below : ');
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttachment});
        Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
    }
}