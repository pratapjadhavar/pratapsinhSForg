global class DailyLeadProcessor implements Schedulable {
 global void execute(SchedulableContext ctx) {
        List<Lead> leadsList = [SELECT Id, Name,LeadSource
            FROM Lead 
            WHERE LeadSource  ='' limit 200];
       list<Lead> updateleads=new list<lead>();
         for(Lead l:leadsList){
             l.LeadSource='Dreamforce';
             updateleads.add(l);
         }
    }
}