public class SchemaClassDemo {
    
    public static void getFieldDataTypes(){
        
        
        // sObject types to describe
        String[] types = new String[]{'Account','Employee__c'};
            
            // Make the describe call
            Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
        
        System.debug('Got describe information for ' + results.size() + ' sObjects.');
        
        // For each returned result, get some info
        for(Schema.DescribeSobjectResult res : results) {
            System.debug('sObject Label: ' + res.getLabel());
            System.debug('Number of fields: ' + res.fields.getMap().keyset());
            System.debug(res.isCustom() ? 'This is a custom object.' : 'This is a standard object.');
            // Get child relationships
            Schema.ChildRelationship[] rels = res.getChildRelationships();
            if (rels.size() > 0) {
                System.debug(res.getName() + ' has ' + rels.size() + ' child relationships.');
            }
        }
        
        /*List<Schema.DescribeFieldResult> listDescribeSObjectResult = new List<Schema.DescribeFieldResult>();
        SObjectType objType = Schema.getGlobalDescribe().get('Account');
        Map<String,Schema.SObjectField> fieldMap = objType.getDescribe().fields.getMap();
        
        for(String  fieldName : fieldMap.keySet()){ 
            Schema.DisplayType fielddataType = fieldMap.get(fieldName).getDescribe().getType();
            if(fielddataType.name().toUpperCase() == 'STRING' || fielddataType.name().toUpperCase() == 'TEXTAREA'){
                listDescribeSObjectResult.add(fieldMap.get(fieldName).getDescribe()) ; 
            }
        }
        
        system.debug('listDescribeSObjectResult='+listDescribeSObjectResult);*/
    }
}