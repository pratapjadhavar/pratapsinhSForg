public class AccountProcessor {
    
	@future
    public static void countContacts(List<Id> accIds){
        List<Account> updates=new List<Account>();
        for(AggregateResult ar:[select AccountId ac, count(id) c from Contact where AccountId in:accIds group by AccountId]){
           
            updates.add(new Account(
                    Id = (Id) ar.get('ac'),
                    Number_of_Contacts__c = (Decimal) ar.get('c')
                    ));
        }
    }
}