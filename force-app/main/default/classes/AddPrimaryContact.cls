public class AddPrimaryContact implements Queueable{
    
    contact c;
    String stateab;   
    public AddPrimaryContact(Contact ct,String stateAbr){
        this.c=ct;
        this.stateab=stateAbr;
    }
    public void execute(QueueableContext context) {
        List<Account> accList=[select id from Account where BillingState =:stateab];
        List<Contact> conList=new List<Contact>();
        for(Account a:accList){
            Contact c1=c.clone(false,false,false,false);
            c.AccountId = a.Id;
            
            conList.add(c1);
        }
        if(conList.size()>0)
            insert conList;
    }

}