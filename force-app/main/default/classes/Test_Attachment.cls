@istest
public class Test_Attachment
{
    Static testMethod void mytest()
    {
        test.startTest();
         Scheduled_Flights__c f=new  Scheduled_Flights__c();
         
          ApexPages.StandardController con=new ApexPages.StandardController(f);
          system.currentPageReference().getParameters().put('id','a0528000002NYlV');
          AttachmentCntr at=new AttachmentCntr(con);
          at.attach=at.getAttach();
         
          
          at.attchfile();
          at.generatepdf();
          at.getAttach();
      
          test.stopTest();
          
    }
}