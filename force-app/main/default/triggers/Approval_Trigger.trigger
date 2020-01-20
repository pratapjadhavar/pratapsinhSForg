trigger Approval_Trigger on Scheduled_Flights__c (after insert) {
    
           for (Scheduled_Flights__c fli : Trigger.New) {
        if (fli.Status__c=='pending') {
             // Create an approval request for the account
            Approval.ProcessSubmitRequest req =new Approval.ProcessSubmitRequest();
            req.setComments('Automatic Submit');
            req.setObjectId(fli.id);
            
            // Submit the approval request for the account
            Approval.ProcessResult result = Approval.process(req);
           
    }
  }
}