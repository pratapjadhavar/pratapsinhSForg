trigger EmployeeTrigger on Employee__c (After insert) {
	MultiRollupSummaryCls.performOperation(Trigger.new);
}