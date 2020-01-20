@isTest
public class AddPrimaryContactTest {
	 
    @isTest
    static void setup(){
        List<Account> accounts = new List<Account>();
        // add a parent account
      
        // add 100 child accounts
        for (Integer i = 0; i < 100; i++) {
            if(i<49)
            accounts.add(new Account(
                name='Test Account'+i,BillingState='NY'
            ));
            else
                 accounts.add(new Account(
                name='Test Account'+i,BillingState='CA'
            ));
        }
        insert accounts;
    
     	contact c = new contact(lastname='PJ');
    	AddPrimaryContact apcon = new AddPrimaryContact(c,'CA');
    	Test.startTest();
       
        System.enqueueJob(apcon);
        Test.stopTest();
    
    	List<contact> conlist = new List<contact>([select id from contact]);
        Integer size = conlist.size();
        system.assertEquals(50, size);
      }
}