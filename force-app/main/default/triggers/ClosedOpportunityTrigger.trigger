trigger ClosedOpportunityTrigger on Opportunity (After insert, After Update) {
	
    List<task> tasklist=new List<task>();
    for(Opportunity op:Trigger.new){
        if(op.StageName.equals('Closed Won')){
     	      task t=new task();
        	  t.Subject='Follow Up Test Task';
              t.WhatId=op.id;
        	tasklist.add(t);
        }
    }
    if(tasklist.size()>0)
        insert tasklist;
 }