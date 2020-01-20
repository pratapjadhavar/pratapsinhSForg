trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
List<BatchLeadConvertErrors__c> errorList = new List<BatchLeadConvertErrors__c>();
    for(BatchApexErrorEvent rec:Trigger.new){
        BatchLeadConvertErrors__c errec = new BatchLeadConvertErrors__c();
        errec.AsyncApexJobId__c=rec.AsyncApexJobId;
        errec.Records__c = rec.JobScope;
        errec.StackTrace__c = rec.StackTrace;
        errorList.add(errec);
    }
    insert errorList;
}