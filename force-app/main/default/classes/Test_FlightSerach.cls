@isTest
public class Test_FlightSerach {
	 @isTest
    public static void TestFlightDetails()
        {
            
            Test.startTest();
            ApexPages.StandardController controller;
            Flight_details_Controller fdc=new Flight_details_Controller(controller);
            fdc.bookflight();
          
            fdc.getFrom_city();
   	        fdc.getTo();
            fdc.searchFlights();

            fdc.selectF2();
            fdc.to_data='Pune';
            fdc.from_data='Bangalore';
            System.assert(fdc.flight_list==null);
            System.assert(fdc.flight_list2==null);
            System.assert(fdc.myDate==System.today());
  			fdc.selflightid='a0528000002NsOv';
            fdc.selflightid2='a0528000002NYlV';
            Test.stopTest();
        }
}