public with sharing class passengerCntlr {

   
    String selected;
    String AgentId;
        
     
    public String getAgentId() {
        return selected;
    }
    public void  setAgentId(String val) {
        selected=val;
    }
   


     public List<Passenger__c> leadpassengerL{set;get;}
     public List<Guest_Passenger__c> guestpassengerL{set;get;}
          
     public passengerCntlr(){   
     }
         

    public  void searchPassenger() {
        String name='%'+input+'%';
        
        leadpassengerL=[select id,Age__c,Gender__c,ID_Proof_number__c,Name__c,No_of_Guest__c,(select Passenger__c,Name__c,Age__c,Gender__c from Guest_Passenger__r) from Passenger__c where Name__c like :name];
        
        System.debug(leadpassengerL);
        System.debug(guestpassengerL);
        
    }
    
    public PageReference sortpassenger() {   
        leadpassengerL=new  List<Passenger__c>();
        String sortname=ApexPages.currentPage().getParameters().get('searchOptions');
        System.debug('options : '+sortname);
        if(sortname=='Name'){
            leadpassengerL=[select id,Age__c,Gender__c,ID_Proof_number__c,Name__c,No_of_Guest__c, (select Name__c,Age__c,Gender__c from Guest_Passenger__r) from Passenger__c where Name__c=: input ORDER BY Name__c];          
         }
         else{
              leadpassengerL=[select id,Age__c,Gender__c,Name__c,ID_Proof_number__c,No_of_Guest__c, (select Name__c,Age__c,Gender__c from Guest_Passenger__r) from Passenger__c where Name__c=: input ORDER BY Age__c];          
         }   
         return null;       
    }
    
    public String input { get; set; }
    
     public string getInput (){
        return input ;
    }
    public void setInput (string s){
        input=s;            
    }    

   
    public List<SelectOption> getSelectedSearchby() {
        List<SelectOption> searchOptions = new List<SelectOption>();
        searchOptions .add(new SelectOption('Name','Name'));
        searchOptions .add(new SelectOption('Age','Age'));
        return searchOptions ;
       }


    
}