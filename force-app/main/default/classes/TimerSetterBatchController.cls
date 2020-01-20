public with sharing class TimerSetterBatchController {
   @AuraEnabled
   public static BatchScheduleInfo1__c  updateSetting(string referVal, Datetime toDataval, Datetime fromdataVal,string idval){
       try{
          System.debug('referVal='+referVal);
            System.debug('todataval='+toDataval);
              System.debug('fromdataVal='+fromdataVal);
                System.debug('idval='+idval);
          BatchScheduleInfo1__c dd=new BatchScheduleInfo1__c(id=idval);
          dd.From__c = fromdataVal;
          dd.to__c = toDataval;
          dd.Reference_Field__c = referVal;
          update dd;
          return dd;
       }
       catch(Exception ee){
           System.debug('error=='+ee.getMessage());
           return null;
            // System.debug('error=='+ee.getMessage());
       }
   }
   
   @AuraEnabled(cacheable=true)
   public static BatchScheduleInfo1__c  getTheSetting(){
       BatchScheduleInfo1__c obj=BatchScheduleInfo1__c.getvalues('timeSetting'); 
       return obj;
   }

   @AuraEnabled(cacheable=true)
   public static Project__c  getproject(){
      Project__c pp=[select id,name from Project__c limit 1];
       return pp;
   }
}