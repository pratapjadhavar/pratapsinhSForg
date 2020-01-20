global class LeadProcessor implements Database.Batchable<sObject>{
    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT ID,LeadSource FROM Lead');
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope){
        // proce ss each batch of records
       List<Lead> lList=new List<Lead>(); 
        for (Lead l : scope) {
           
                recordsProcessed = recordsProcessed + 1;
           		l.LeadSource='Dreamforce';
           		lList.add(l);
        }
        update lList;
    }    

    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
    }    

}