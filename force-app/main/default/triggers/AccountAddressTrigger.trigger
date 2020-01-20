trigger AccountAddressTrigger on Account (before insert,before update) {
    for(Account a:Trigger.new){
        if(a.Match_Billing_Address__c && a.BillingPostalCode!=null)
            a.ShippingPostalCode=a.BillingPostalCode;
    }
    
    List<contact> conlist=[select id,the_val__c, from_val__c, to_val__c from contact];
    
    for(Account a:Trigger.new){
        for(contact vv:conlist){
            if(a.NumberofLocations__c>=vv.from_val__c && a.NumberofLocations__c<=vv.to_val__c){
                a.BillingCity=vv.the_val__c;
            }
            
        }
        
    }
    
}