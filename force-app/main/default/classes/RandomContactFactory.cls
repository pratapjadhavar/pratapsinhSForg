public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer noOfCon, String lastName){
          List<Contact> accts = new List<Contact>();
        
        for(Integer i=0;i<noOfCon;i++) {
            Contact a = new Contact(FirstName='Test' + i,LastName='lastName');
            
            accts.add(a);
        }
        insert accts;

        return accts;
    }
}