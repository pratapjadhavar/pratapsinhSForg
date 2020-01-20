global class demoApw implements Database.Batchable<sobject>, Database.Stateful{
    global List<string> ids =new List<string>();
    private List<string> paramId;
      
      global demoApw(List<string> param1){
          paramId=param1;
      }
      
       global Database.QueryLocator start(Database.BatchableContext bc) {
          return Database.getQueryLocator('SELECT Id, name from Employee__c where Id IN:paramId'); 
    }
    
    global void execute(Database.BatchableContext bc, List<Employee__c> listEmployee){
        List<Employee__c> tobeupdae=new List<Employee__c>();
        for(Employee__c e : listEmployee){
            e.Salary_Jan__c = 15;
            tobeupdae.add(e);
            ids.add(e.id);
        }
        
        Database.update(tobeupdae);
    }
    
    global void finish(Database.BatchableContext bc){
        system.debug('ids==2nd atch====='+ids);
    }
}