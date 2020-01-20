@RestResource(urlMapping='/Project/*')
global class restWebserviceDemo {
    
     global class RquestWraper{
        Project__c proj;
        Employee__c[] emplist;
    }    
    
	@HttpPost
    global static void createProjectRec(){
        
         RestRequest req1=RestContext.request;   
        if(req1.requestBody!=null)  {      
         String jsonInput= req1.requestBody.toString();
        
         Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(jsonInput);
            String opptyId = String.valueOf(jsonMap.get('proj')) ; 
        
        system.debug('data=='+opptyId);
        }
    }
}