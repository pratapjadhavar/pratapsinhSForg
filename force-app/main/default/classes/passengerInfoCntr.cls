public with sharing class passengerInfoCntr {

 
    public String AgentId{get;set;}
     public List<Passenger__c> leadpassengerL{set;get;}
     public List<Guest_Passenger__c> guestpassengerL{set;get;}
     
      public List<SelectOption> getSelectedSearchby() {
        List<SelectOption> searchOptions = new List<SelectOption>();
        searchOptions.add(new SelectOption('Name','Name'));
        searchOptions.add(new SelectOption('Age','Age'));
       searchOptions.add(new SelectOption('Email','Email'));
        return searchOptions ;
       }
          
     public passengerInfoCntr (){   
     }
         

    public  void searchPassenger() {
    
    system.debug(AgentId);
     system.debug(input);
      
       if(AgentId=='Name')
       {
       system.debug(input);
        leadpassengerL=[select id,Email__c,Age__c,Gender__c,Name__c,No_of_Guest__c,(select Passenger__c,Name__c,Age__c,Gender__c from Guest_Passenger__r) from Passenger__c where Name__c =:input];
        System.debug(leadpassengerL);
        System.debug(guestpassengerL);
        }
       else if(AgentId=='Age')
        {
          leadpassengerL=[select id,Email__c,Age__c,Gender__c,Name__c,No_of_Guest__c,(select Passenger__c,Name__c,Age__c,Gender__c from Guest_Passenger__r) from Passenger__c where Age__c=:Integer.valueOf(input)];
        System.debug(leadpassengerL);
        System.debug(guestpassengerL);
        
        }
        else 
        {
          leadpassengerL=[select id,Email__c,Age__c,Gender__c,Name__c,No_of_Guest__c,(select Passenger__c,Name__c,Age__c,Gender__c from Guest_Passenger__r) from Passenger__c where Email__c=:input];
        //System.debug(leadpassengerL);
       // System.debug(guestpassengerL);
        }
    }
    
  /*  public PageReference sortpassenger() {   
        leadpassengerL=new  List<Account>();
        String sortname=ApexPages.currentPage().getParameters().get('searchOptions');
        System.debug('options : '+sortname);
        if(sortname=='Name'){
            leadpassengerL=[select id,Email__c,Age__c,Gender__c,Name,Guest_Count__c,(select Lead_Passenger__c,Name__c,Age__c,Gender__c from Guest_Passengers__r) from Account where Name like :input];
         }
         else{
              leadpassengerL=[select id,Email__c,Age__c,Gender__c,Name,Guest_Count__c,(select Lead_Passenger__c,Name__c,Age__c,Gender__c from Guest_Passengers__r) from Account where Name like :input];
         }   
         return null;       
    }*/
    
    public String input { get; set; }
    
     public string getInput (){
        return input ;
    }
    public void setInput (string s){
        input=s;            
    }    

   
   


    
}