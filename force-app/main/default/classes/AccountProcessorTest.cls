@isTest
public class AccountProcessorTest {
    @isTest
    public static void pass(){
	Test.startTest();
    List<Id> idsl=new List<Id>(); 
         Account a=new Account();
          a.Name='Disney';      
          a.BillingPostalCode='411004';
        insert a;
        
         Contact ct = new Contact(AccountId=a.Id,lastname='testing',firstname='Disney');
        insert ct;

    
    idsl.add(a.id);
    AccountProcessor.countContacts(idsl);
    Test.stopTest();
    }
}