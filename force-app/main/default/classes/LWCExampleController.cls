public without sharing class LWCExampleController {

    @AuraEnabled
    public static void saveAccountRecord(Account objAcc,string topicIId){
        try{
            insert objAcc;
           
system.debug('topicIId===>'+topicIId);
           ChatterQuestion__e  ff = new ChatterQuestion__e ();
            ff.NetworkScope__c='0DB0I000000APQoWAO';
            ff.ParentId__c='0050I000009WBME';
            ff.CreatedById__c ='0050I000009WBME';
            ff.Type__c='QuestionPost';
            ff.Status__c='Published';
            ff.Title__c='Howww to insert q from guest';
            ff.Body__c='hello body data';
            ff.Visibility__c='AllUsers';
            ff.topicId__c='0TO0I000000InQbWAK';
            Database.SaveResult sr = EventBus.publish(ff);
            // Inspect publishing result 
            if (sr.isSuccess()) {
                System.debug('Successfully published event.');
            } else {
                for(Database.Error err : sr.getErrors()) {
                    System.debug('Error returned: ' +
                                err.getStatusCode() +
                                ' - ' +
                                err.getMessage());
                }
            }


        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        } 
    }
}