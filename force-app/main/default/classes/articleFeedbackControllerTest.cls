@IsTest public with sharing class articleFeedbackControllerTest{
     @IsTest(SeeAllData=true) public static void testMet() {
          Topic newTopic = new Topic(Name='newArticleTopic'); 
          insert newTopic;
          knowledge__kav newArticle = new knowledge__kav(Title='test',summary='xyz',urlname='xyz');
          insert newArticle ;
          articleFeedbackController.saveVote(true,false,'testss',newArticle.id);
                 
    }    
}