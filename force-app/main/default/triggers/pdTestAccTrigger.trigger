trigger pdTestAccTrigger on Account (before update) {
    Boolean processOpportunity = false;
    List<opportunity> opptysClosedLost = new List<opportunity>();
    List<opportunity> lstAllOpp = [select StageName from Opportunity where accountId IN :Trigger.newMap.keySet()];
    if(!lstAllOpp.isEmpty()) processOpportunity = true;
    while(processOpportunity){
        for(opportunity o : lstAllOpp) 
            if(o.StageName == 'Closed - Lost')
            opptysClosedLost.add(o); 
        processOpportunity = false; 
        if(!opptysClosedLost.isEmpty()) 
            delete opptysClosedLost; 
    } }