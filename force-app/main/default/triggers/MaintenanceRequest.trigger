trigger MaintenanceRequest on Case (before update, after update) {
 
    Map<Id,Case> applicableCases = new Map<Id,Case>();
    
    if(Trigger.isUpdate){
        if(Trigger.isAfter){
            for(Case a: Trigger.new){
                if (a.IsClosed && (a.Type.equals('Repair') || a.Type.equals('Routine Maintenance'))){
                    applicableCases.put(a.Id, a);
                }
            }
        	MaintenanceRequestHelper.insertUpdateWorkOrders(applicableCases);    
        }
    } 
      
}