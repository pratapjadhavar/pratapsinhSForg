public class ParentInputLookup {
    @AuraEnabled
    public static User searchUser(String userId){
       
       User u=[SELECT id,isActive From User where id=: UserInfo.getUserId()];
      return u;
    }
   /* @AuraEnabled
    public static List<Contact> searchContacts(String contact){
        List<Contact> contactid=new List<Contact>();
        contactid=[SELECT id,Name From Contact ];
        return contactid;
    
    }*/
}