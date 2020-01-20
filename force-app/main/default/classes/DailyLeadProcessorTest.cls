@istest
public class DailyLeadProcessorTest {
	 public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    static testmethod void testScheduledJob() {

        // Create some out of date Opportunity records
        List<Lead> opptys = new List<Lead>();
        Date closeDate = Date.today().addDays(-7);
        for (Integer i=0; i<200; i++) {
            Lead o = new Lead(
              
                LastName='Doe'+i,FirstName='John',Company='Test',Status='Inquiry'
            );
            opptys.add(o);
        }
        insert opptys;
        
        
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor());         
        // Verify the scheduled job has not run yet.
       
        Test.stopTest();
        
    }
}