public class lookUpController {
 
 // calling on search of contacts 
 @AuraEnabled
 public static List < Contact > fetchContact(String searchKeyWord) {
 String searchKey = searchKeyWord + '%';
 List <Contact > returnList = new List < Contact > ();
 List < Contact > lstOfContact = [SELECT Id, Name, MailingStreet, MailingCity,
 MailingPostalCode, AccountId, Account.Name, Phone, Email FROM Contact where Name LIKE: searchKey];
 
 for (Contact con: lstOfContact) {
 returnList.add(con);
 }
 return returnList;
 }
 
// initial list of recent items
 @AuraEnabled
 public static List < Contact > getContacts1() {
     List < Contact > lstOfContact1 = [SELECT Id, Name, MailingStreet, MailingCity, MailingPostalCode, AccountId, Account.Name, Phone, Email FROM Contact WHERE LastModifiedDate != NULL ORDER BY LastModifiedDate DESC LIMIT 5];
     system.debug('contacts'+lstOfContact1 );
     return lstOfContact1;
  } 
}