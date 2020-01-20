public with sharing class Flight_details_Controller {
    public String selflightid2 ;
    public boolean dsp{set;get;}
    public void selectF2() {
         selflightid2 = ApexPages.currentPage().getParameters().get('flid2');
            System.debug('hi'+selflightid);
    }
public Date myDate = system.today();
    public String selflightid ;
    public void selectF() {
            selflightid = ApexPages.currentPage().getParameters().get('flid');
            dsp=true;
            System.debug('hi'+selflightid);
        
    }

    public List<Scheduled_Flights__c> flight_list{set;get;}
    public List<Scheduled_Flights__c> flight_list2{set;get;}
    public Date dateValue {get;set;}
    public Date dateValue2 {get;set;}
    public String from_data {get;set;}
    public String to_data {get;set;}
    public Boolean retjer{get;set;}
    public ID id{get;set;}
    public ID selectF{set;get;}
    public ID selectF2{set;get;}
    public boolean flag{set;get;}
    
    public Flight_details_Controller(ApexPages.StandardController controller) {
    
    }
  
     

    public List<SelectOption> getTo() {
        List<SelectOption> to_option= new List<SelectOption>();
        to_option.add(new SelectOption('None','--None--'));
        to_option.add(new SelectOption('Bangalore','Bangalore'));
        to_option.add(new SelectOption('Chennai','Chennai'));
        to_option.add(new SelectOption('Delhi','Delhi'));
        to_option.add(new SelectOption('Mumbai','Mumbai'));
        to_option.add(new SelectOption('Pune','Pune'));
        return to_option;
       }
       
    public List<SelectOption> getFrom_city() {
        List<SelectOption> from_option= new List<SelectOption>();
        from_option.add(new SelectOption('None','--None--'));
        from_option.add(new SelectOption('Bangalore','Bangalore'));
        from_option.add(new SelectOption('Chennai','Chennai'));
        from_option.add(new SelectOption('Delhi','Delhi'));
        from_option.add(new SelectOption('Mumbai','Mumbai'));
        from_option.add(new SelectOption('Pune','Pune'));
        return from_option;
       }
   
   public PageReference searchFlights(){
   if(to_data==null||from_data==null||dateValue==null){
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please fill reuired value'));
                    
        }else if(dateValue2<dateValue||dateValue<system.today()){
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Incorrect Date'));
        }
        else{
       flight_list=[SELECT Departure__c,Flight__c,Time_of_Departure__c,From__c,Id,Remaining_Seats__c,Total_Seats__c,Status__c,To__c FROM Scheduled_Flights__c where From__c=:from_data AND To__c=:to_data AND Departure__c=:dateValue AND Status__c=:'Approved' order By Time_of_Departure__c];
       flight_list2=[SELECT Departure__c,Flight__c,From__c,Time_of_Departure__c ,Id,Remaining_Seats__c,Status__c,Total_Seats__c,To__c FROM Scheduled_Flights__c where From__c=:to_data AND To__c=:from_data AND Departure__c=:dateValue2 AND Status__c=:'Approved' order by Time_of_Departure__c];
       flag=true;
       if(flight_list2.size()==0){
           flight_list2=null;
       }
      } return null;
   }
   
   public PageReference bookflight(){
        PageReference pageRef;
        if(selectF!=null||selectF2!=null){
        string url;
        url = '/apex/Confirmbooking?param1='+selectF+'&param2='+selectF2; 

       pageRef = new PageReference(url);
        pageRef.setRedirect(true);}
        else{
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Select flight first'));
        }
        return pageRef;
   }
   
   
   

}