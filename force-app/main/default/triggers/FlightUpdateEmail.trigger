Trigger FlightUpdateEmail on Scheduled_Flights__c (after update) {
   
    
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
     List<String> reciever=new List<String>();
    List<Book_Ticket__c> tickets=new List<Book_Ticket__c>();
   //String flightAttendentemail{get;set;}
    boolean flag=false;
    integer counter=0;
    for(Scheduled_Flights__c  flight1: Trigger.new )
  {
        Scheduled_Flights__c oldflight=Trigger.oldMap.get(flight1.id);
      
        if( (oldflight.To__c!= flight1.To__c) || (oldflight.From__c!= flight1.From__c) ||(oldflight.Departure__c!= flight1.Departure__c) ||(oldflight.Departure__c!= flight1.Departure__c) )
      {
             Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
      
         tickets=[SELECT Id,Passenger__r.Email__c FROM Book_Ticket__c WHERE Flight__c=:flight1.Id];        
       
          //flightAttendentemail=flights.Flield_Attendent__r.Email;
            for(Book_Ticket__c ticket:tickets)
               reciever.add(ticket.Passenger__r.Email__c);
            //reciever.add(flightAttendentemail);
              mail.setToAddresses(reciever);
              mail.setReplyTo('pratapsinh_jadhavar@persistent.com');
            mail.setSenderDisplayName('Flight Update');
        
            mail.setSubject('IMPORTANT:Flight Updates ');
        
              String body='Dear  Traveller/Chief attendant,';
            body+='Your Flight have been changed<br/>';
              body+='Please find the details below-<br/>';
              body+=flight1.From__c+'   To ' +flight1.To__c+'<br/>';
              body+=('Dates of departure '+flight1.Departure__c+'<br/>');
              
              body+='Thank you,<br/>';
            body+='System admin';
            mail.setHtmlBody(body);
        
            mails.add(mail);
            flag=true;
            
       }
        else
        {
            flag=false;
        }
        
  }
    if(flag)
    {
         Messaging.sendEmail(mails);
    }
}