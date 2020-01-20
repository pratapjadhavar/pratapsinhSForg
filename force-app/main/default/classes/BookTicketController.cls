public with sharing class BookTicketController {

    public Boolean flag1{set;get;}
    public Boolean flag2{set;get;}
    public Boolean flag3{set;get;}
    public String checkmail{set;get;}
    public String id22,id11;
    public List<Scheduled_Flights__c> bookedlist{get;set;}
    public List<Passenger__c> plist{set;get;}
    public List<Guest_Passenger__c> glist=new List<Guest_Passenger__c>();
   public  List<Guest_Passenger__c> toDel = new List<Guest_Passenger__c>();
   
    public  List<Guest_Passenger__c> getGlist(){
        return glist; 
    }
    
    
    public Passenger__c psg{set;get;}
    public string lname{set;get;}
    public string gname{set;get;}
    public string lmail{set;get;}
    public string gmail{set;get;}
    public Integer lage{set;get;}
    public string lidnumber{set;get;}
    public Integer gage{set;get;}
    public ID lid{set;get;}
    public Integer glimit{get;set;}
    public string gen2{set;get;}
    public string gen3{set;get;}
 
 
 //patapsinh jadhavar owner of ths
    
    public BookTicketController(ApexPages.StandardController controller) { 
            
              id11=ApexPages.currentPage().getParameters().get('param1');
              id22= ApexPages.currentPage().getParameters().get('param2');
              if(id22==null){
                  bookedlist=[SELECT Departure__c, Time_of_Departure__c, Flight__c,From__c,Id,Remaining_Seats__c,Total_Seats__c,To__c FROM Scheduled_Flights__c where id=:id11];                   
                  }else{
                       bookedlist=[SELECT Departure__c,Time_of_Departure__c,Flight__c,From__c,Id,Remaining_Seats__c,Total_Seats__c,To__c FROM Scheduled_Flights__c where id=:id11 OR id=:id22];                   
                  }
                 
            
    }
    
    public void mailcheck(){
         
             plist=[select id,Name__c,Age__c,Email__c,ID_Proof_number__c, Gender__c,No_of_Guest__c from Passenger__c where Email__c=:checkmail];
              
              if(plist.size()==0){
              system.debug('hi.pj.'+plist.size());
               
                  plist=null;    
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Invalid User Please Register')); 
                   
                  
          }
          else{
               flag3=true;
               glimit=1;
               lid=plist[0].id;
               toDel = [select id,Passenger__c from Guest_Passenger__c where Passenger__c=:lid];
               delete toDel;

          }
          
    }
    public void newregister(){
    flag1=true;
    }
    
      public void savelp()
    {
        if(lname==null||lmail==null||lidnumber==null||lage==0||gen2==null){
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please fill reuired value'));
                    
        }else{
        
           
            psg=new Passenger__c(Name__c=lname,Email__c=lmail,ID_Proof_number__c=lidnumber,Age__c=lage,Gender__c=gen2);
            insert psg;   
            lid=psg.id; 
            flag1=false;
            plist=[select id,Name__c,Age__c,Email__c,ID_Proof_number__c, Gender__c,No_of_Guest__c from Passenger__c where Email__c=:lmail];
            glimit=1;
            flag3=true;
        }
    }
    
     public void addGuest()
    {   
         if(gname==null||gage==0||gen3==null){
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'<font color="red">Please fill reuired value'));
                    
        }else{
            glist.add(new Guest_Passenger__c(Name__c=gname, Age__c=(Integer)gage,Gender__c=gen3,Passenger__c=lid));     
            gname='';
            gen3='';
            gage=null;
            glimit++;
        }
    }

       public PageReference bookflight()
    {
   
            insert glist;
             String body;
             System.debug('kkkkkkkkkkkkkkkk'+bookedlist.size());
            Book_Ticket__c bt= new Book_Ticket__c(Flight__c=bookedlist[0].id,Passenger__c=lid,booked_Ticket__c=glimit);
          
            
            
            if(bookedlist.size()>1)
            {
                   
                    Book_Ticket__c bt2= new Book_Ticket__c(Flight__c=bookedlist[1].id,Passenger__c=lid,booked_Ticket__c=glimit);
                    insert bt2;
                     body='<html><Header><br><h1><b><Center>Sinha Flights</center></b></h1></Header><h3><b>Ticket Details</b></h3><h3><h3><br><Br/><h4>Ticket ID='+bt2.id+'<br>Source City  : '+bookedlist[0].From__c+ '  <br> Destination city :' + bookedlist[0].To__c + '<br> Departure Date :'+bookedlist[0].Departure__c+'<br> Departure Time :'+bookedlist[0].Time_of_Departure__c+'<h3><br>Your Return Details is Here<h3><h4>Ticket ID='+bt2.id+'<br>Source City  : '+bookedlist[1].From__c+ '  <br> Destination city :' + bookedlist[1].To__c + '<br> Departure Date :'+bookedlist[1].Departure__c;
                   
            }
            else{
                     insert bt;
                     body='<html><Header><br><h1><b><Center>Sinha Flights</center></b></h1></Header><h3><b>Ticket Details</b></h3><h3><h3><br><Br/><h4>Ticket ID='+bt.id+'<br>Source City  : '+bookedlist[0].From__c+ '  <br> Destination city :' + bookedlist[0].To__c + '<br> Departure Date :'+bookedlist[0].Departure__c+'<br> Departure Time :'+bookedlist[0].Time_of_Departure__c;
            }
            
             for(Scheduled_Flights__c a: bookedlist){
                  a.Remaining_Seats__c =  a.Remaining_Seats__c-glimit;
            }
            update bookedlist;
           
           
          
            
          
           
          Attachment attachment = new Attachment();
          attachment.Body = Blob.toPDF(body);
          attachment.Name = String.valueOf(bt.id+'.pdf');
          attachment.ParentId = lid;
          insert attachment;
           
            PageReference pageRef = new PageReference('/servlet/servlet.FileDownload?file='+attachment.id);
           
            
            return pageRef ;
   
    }
}