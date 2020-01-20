trigger OrderEventTrigger on Order_Event__e (after insert) {
	list<Task> tasks=new List<Task>();
    
    User myUser = [SELECT Id FROM User WHERE Name='Pratapsinh Jadhavar' LIMIT 1];
    
    for(Order_Event__e oe:Trigger.new){
        if(oe.Has_Shipped__c==true){
            Task t=new Task();
            t.Priority='Medium';
            t.Subject='Follow up on shipped order ' + oe.Order_Number__c;
            t.OwnerId=myUser.id;
            tasks.add(t);
        }
    }
    insert tasks;
}