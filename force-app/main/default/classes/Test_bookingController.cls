@isTest
public class Test_bookingController {

    @isTest
    public static void TestBookingMethods(){
        Test.startTest();
        ApexPages.StandardController controller;
        BookTicketController btc=new BookTicketController(controller);
        btc.addGuest();
        btc.bookflight();
        btc.getGlist();
        btc.savelp();
        btc.newregister();
        btc.mailcheck();
        Test.stopTest();
    }
    
    @isTest
    public static void TestBookingData(){
        Test.startTest();
        ApexPages.StandardController controller;
        BookTicketController btc=new BookTicketController(controller);
       	btc.checkmail='psjadhavar@gmail.com';
        btc.gage=20;
        btc.gen2='Male';
        btc.gen3='Female';
        btc.gname='tram';
        System.assert(btc.glimit<5);
        btc.lmail='rohit@mourya.com';
        btc.lage=25;
        btc.lname='Rohit';
        
        Test.stopTest();
    }
        
}