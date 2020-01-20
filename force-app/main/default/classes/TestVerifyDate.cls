@isTest
private class TestVerifyDate {
    @isTest static void test() {
        Date dt=VerifyDate.CheckDates(system.today(),system.today());
        Date dt2=VerifyDate.CheckDates(system.today()-40,system.today());
        Date dt3=VerifyDate.SetEndOfMonthDate(system.today());
    }
}