trigger ChatterQuestionTrigger on ChatterQuestion__e (after insert) {
            
          
            map<FeedItem,string> topicToFIMap=new map<FeedItem,string>();
            
            for(ChatterQuestion__e rec:Trigger.New){
                FeedItem ff=new FeedItem();
                ff.NetworkScope=rec.NetworkScope__c;
                ff.ParentId=rec.currentUserId__c;
                ff.Type='QuestionPost';
                ff.Status='Published';
                ff.Title=rec.Title__c;
                ff.Body=rec.Body__c;
                ff.Visibility='AllUsers';
                ff.CreatedById =rec.currentUserId__c;
                ff.id=null;
               
                topicToFIMap.put(ff,rec.TopicId__c);
                
               
            }
            System.debug('topicToFIMap==>'+topicToFIMap);
            if(topicToFIMap.size()>0){
                List<FeedItem> tobeInsertList=new List<FeedItem>();
                tobeInsertList.addAll(topicToFIMap.keyset());
                insert tobeInsertList;
            }
            
            List<TopicAssignment> tobeInsert=new List<TopicAssignment>();
            for(FeedItem dd:topicToFIMap.keyset()){
               
                TopicAssignment ta=new TopicAssignment();
                ta.NetworkId =dd.NetworkScope;
                ta.EntityId=dd.id;
                dd.id=null;
                string sf=topicToFIMap.get(dd);
                system.debug('topicId__c==>'+sf);
                ta.TopicId=sf;
               
               
                tobeInsert.add(ta);
            }
            
            if(tobeInsert.size()>0){
                insert tobeInsert;
            }
            
}