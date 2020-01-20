public class SymbolGridEmailController {
    public String emailBodyTxt{set;get;}
     public String emailSubject{set;get;}
    public Contact con{set;get;}
    public string conId {set;get;}   
    public SymbolGridEmailController(ApexPages.StandardController controller){
        
        
		 conId = (id)controller.getRecord().id;
            
        
        if(conid!=null){
            con=[select id, email from Contact where id=:conId];
        }
    }
    
    public pagereference sendMail(){
        
      	
        system.debug('con.email==>'+con.email);
        String endpoint ='https://api.sendgrid.com/v3/mail/send';
		String authorizationHeader='Bearer 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';
		HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http h = new Http();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
		req.setHeader('Authorization', authorizationHeader);   
		req.setHeader('Content-Type', 'application/json');
		req.setBody('{"personalizations": [{"to": [{"email": "'+con.email+'"}],"subject": "'+emailSubject+'"}],"from": {"email": "techila@services.com"},"content": [{"type": "text/plain","value": "'+emailBodyTxt+'"}]}');	
		res = h.send(req);
		
		system.debug('response--->>'+res);
        if(res.getStatusCode()==202){
             ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Email Sent Successfully..!'));
        }else{
               ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Something went wrong..!'));
        }
        return null; 
        
    }
}