@IsTest public with sharing class askQuestionControllerTest{
     @IsTest(SeeAllData=true) public static void testMet() {
          Topic newTopic = new Topic(Name='newArticleTopic'); 
          insert newTopic;
          askQuestionController.saveQuestion(newTopic.id,'test q');
          askQuestionController.getPickListValues();  
          
            ChatterQuestion__e  ff = new ChatterQuestion__e ();
           
            ff.Title__c='dadas';
            ff.currentUserId__c=UserInfo.getUserId();
            ff.Body__c='ff';
         
            ff.topicId__c=newTopic.id;
            
            Test.startTest();
            
            // Publish test event
            Database.SaveResult sr = EventBus.publish(ff);
                
            Test.stopTest();                
    }    
}