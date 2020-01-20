@isTest 
public class TestRestrictContactByName {
    @isTest static void test(){
	Contact c=new Contact();
    c.LastName ='INVALIDNAME';
    insert c;
   }
}