public without sharing class askQuestionController {

    @AuraEnabled
    public static void saveQuestion(string topicIId, string questionDataStr){
        try{
            
          String commId=[SELECT Name, Id FROM network where name='DCdemo'].id;
          system.debug('topicIId===>'+topicIId+'==commId==>'+commId+'==questionDataStr==>'+questionDataStr);

           ChatterQuestion__e  ff = new ChatterQuestion__e ();
            ff.NetworkScope__c=commId;
            ff.Title__c=questionDataStr;
            ff.currentUserId__c=UserInfo.getUserId();
            ff.Body__c='';
         
            ff.topicId__c=topicIId;
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

     @AuraEnabled
    public static List < Map < String, String >> getPickListValues() {
        List < Map < String, String >> options = new List < Map < String, String >> ();
       
         String commId=[SELECT Name, Id FROM network where name='DCdemo'].id;
        for (Topic tp: [SELECT ManagedTopicType,NetworkId, Name, Id FROM Topic where NetworkId=:commId]) {
            Map < String, String > values = new Map < String, String > {
                'label' => tp.name,
                'value' => tp.id
            };
            options.add(values);
        }
        return options;
    }
    
}