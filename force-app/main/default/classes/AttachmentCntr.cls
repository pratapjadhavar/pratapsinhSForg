public with sharing class AttachmentCntr {

   
    public List<Attachment> attach=new List<Attachment>();
  
    public Map<Id,boolean> attchmentMap{get;set;}
    public String FlightId{get;set;}
    List<Contact> reciever{get;set;}
    
    public Scheduled_Flights__c flight1{get;set;}
    
    public List<Book_Ticket__c> tickets{get;set;}
    
    public AttachmentCntr(ApexPages.StandardController controller) {
    
    
    FlightId=ApexPages.currentPage().getParameters().get('id');
    
   
   flight1=[SELECT Departure__c,Flight__r.Name,From__c,Id,Remaining_Seats__c,Total_Seats__c,To__c,Flight_Attendant__c FROM Scheduled_Flights__c WHERE Id = :FlightId];
  system.debug(flight1);
  
   tickets=[SELECT Passenger__r.Name__c,Passenger__r.Age__c,Passenger__r.Gender__c,Flight__c,Id,Passenger__c,booked_Ticket__c FROM Book_Ticket__c where Flight__c=:FlightId];
    
    attach=getAttach();
    attchmentMap=new Map<id,boolean>();
       for(Attachment i:attach)
          {
  
             attchmentMap.put(i.id,false);
          }


    
    }
    
    
    
   public List<Attachment> getAttach(){
    
           attach=[SELECT Id,body,Name FROM Attachment where parentId=:FlightId ]; 
           system.debug(attach);
          return attach;
    }
    
    
    
    
    
    public PageReference attchfile()
{
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
        
             reciever=new List<Contact>();
             
           reciever=[select Email from Contact where Id=:flight1.Flight_Attendant__c];  
             
        system.debug(reciever.size());
        List<string> str=new List<string>();
      
        for(Contact c:reciever)
        {

            str.add(c.Email); 
   
        }


          for(attachment a:attach)
      {
            Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
               efa.setFileName(a.Name);
              efa.setBody(a.Body);
              if(attchmentMap.get(a.id)==true)
               fileAttachments.add(efa);  
      }
  
  
          String body='The details of your flight has been attched to your email.<br/>';
          body+='Thank you,<br/>';
          body+='System admin';
  
          mail.setFileAttachments(fileAttachments);
          mail.setToAddresses(str);
          mail.setReplyTo('pratapsinh_jadhavar@persistent.com');
          mail.setSenderDisplayName('Flight Information');
          mail.setSubject('IMPORTANT:Flight Information ');
          mail.setBccSender(false);
          mail.setUseSignature(true);
          mail.setHtmlBody(body);
          Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
          
          pagereference pg=new Pagereference('/'+FlightId);
          generatepdf();
          return pg;
  
   
}

public void generatepdf()
{
      
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
       
          reciever=new List<Contact>();
           
           reciever=[select Email from Contact where Id=:flight1.Flight_Attendant__c];  
           
          system.debug(reciever.size());
        List<string> str=new List<string>();
     for(Contact c:reciever)
        {

            str.add(c.Email); 
   
        }


        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName('Passenger_Details.pdf');
        
        string body='<html><h2>Passengers Information For Flight ='+flight1.Flight__r.Name+' </h2><br><table style="width:100%" border="1"><tr><td><h4> Name OF The Passenger </h4></td><td><h4>Age</h4></td><td><h4>Gender</h4></td><td><h4>No Of Passengers</h4></td></tr>';


        
    for(Book_Ticket__c acc:tickets)
    {
 
    
                   body =body+'<tr><td>'+acc.Passenger__r.Name__c+'</td><td>'+acc.Passenger__r.Age__c+'</td><td>'+acc.Passenger__r.Gender__c+'</td><td>'+acc.booked_Ticket__c+'</td></tr>';
 
 
     }             
      
                        body =body+'</table></html>';
                        
        attach.Body = Blob.toPDF(body);
       
         Messaging.SingleEmailMessage mailpdf = new Messaging.SingleEmailMessage();
        mailpdf.setToAddresses(str);
        mailpdf.setSubject('PDF Generation');
        mailpdf.setHtmlBody('PFA');
        mailpdf.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });     
        
        mails.add(mailpdf);   

    if(!mails.isEmpty()) {
       Messaging.SendEmail(mails);
    }
    


}
 

}