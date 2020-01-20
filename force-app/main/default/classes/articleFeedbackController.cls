public without sharing class articleFeedbackController {
    
    @AuraEnabled
    public static void saveVote(boolean upvote,boolean downvote,string feedBackText,string articleRecId){
        system.debug('inside===='+upvote+'downvote=='+downvote);
       
        String voteType;
        if(upvote){
            voteType='Upvote';
        }else if(downvote){
            voteType='Downvote';
        }

        Article_Rating__c arRec = new Article_Rating__c();
        arRec.Knowledge_article__c  = articleRecId;
        arRec.Vote_Type__c = voteType;
        arRec.Feedback_Comment__c=feedBackText;
        insert arRec;
    }
}