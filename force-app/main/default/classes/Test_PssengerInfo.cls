@isTest
public class Test_PssengerInfo {
    
     @isTest
    public static void Testdetails()
        {
            Test.startTest();
             passengerInfoCntr pc=new passengerInfoCntr();
         	 List<Passenger__c> leadpassengerL=[select id,Email__c,Age__c,Gender__c,Name__c,No_of_Guest__c,(select Passenger__c,Name__c,Age__c,Gender__c from Guest_Passenger__r) from Passenger__c where Name__c =:pc.input]; 
           
			if(pc.AgentId=='Name')
       		{
                for(Passenger__c a : leadpassengerL)
                    System.assertEquals(a.Name__c,pc.input);
            }
            else if(pc.AgentId=='Email'){
                for(Passenger__c a : leadpassengerL)
                    System.assertEquals(a.Email__c,pc.input);
            }
            else{
                 for(Passenger__c a : leadpassengerL)
                    System.assertEquals(a.Age__c,(Integer.valueOf(pc.input)));
            }
            
            pc.getSelectedSearchby();
   			 pc.searchPassenger();
            pc.setInput('pratapsinh');
            Test.stopTest();
        }  
    
     
}