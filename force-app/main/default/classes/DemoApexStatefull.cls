global class DemoApexStatefull implements Database.Batchable<sobject>, Database.Stateful{
    global List<string> ids =new List<string>();
    
       global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, name from Employee__c');
    }
    
    global void execute(Database.BatchableContext bc, List<Employee__c> listEmployee){
        List<Employee__c> tobeupdae=new List<Employee__c>();
        for(Employee__c e : listEmployee){
            e.Salary_Jan__c = 10;
            tobeupdae.add(e);
            ids.add(e.id);
        }
        
        Database.update(tobeupdae);
    }
    
    global void finish(Database.BatchableContext bc){
        system.debug('ids======='+ids);
        demoApw ds=new demoApw(ids);
        Id bd=Database.executeBatch(ds);
    }
}