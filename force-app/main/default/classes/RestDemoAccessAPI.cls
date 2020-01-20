public class RestDemoAccessAPI {
    public string prjNamevalvf{set;get;}
   public Object reposneid{set;get;}
   private final String clientId = '3MVG9YDQS5WtC11oIhN8teiTkBbBJSxKCsR.B3vEsnHUDer3toEbDz1DwL93HLO5CgSiH_NfRGqh_e2TWI5cU';
   private final String clientSecret = '5096140471052011846';
   private final String username = 'jadhavar@sf.com';
   private final String password = 'Vision#2019jRXbx0BG4LourLCgsX1M3GXwLH';
  public class deserializeResponse
   {
      public String id1;
      public String access_token;
   }
  public String ReturnAccessToken ( )
   {
      String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password+'&scope=' + encodingUtil.URLEncode('full refresh_token','UTF-8');
       system.debug('v==>'+reqbody);
      Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setBody(reqbody);
      req.setMethod('POST');
      req.setEndpoint('https://login.salesforce.com/services/oauth2/token?');
      HttpResponse res = h.send(req);
       system.debug('res.getbody===>'+res.getbody());
      deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
      system.debug('@@@@access_token@@'+resp1 );
      return resp1.access_token;
   }
    
    public pagereference callRestNowGetData(){
        string reBody='{"proj":"'+prjNamevalvf+'"}';
        string token=ReturnAccessToken();
        
      Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setMethod('POST');
      req.setEndpoint('https://jadhavar-dev-ed.my.salesforce.com/services/apexrest/jdvr/Project');
      req.setBody(reBody);  
      req.setHeader('Content-Type','application/json');
      req.setHeader('Authorization','Bearer '+token);
          
      HttpResponse res = h.send(req);
        reposneid=JSON.deserializeUntyped(res.getbody());
        //projectWrap ds=(projectWrap)JSON.deserialize(res.getbody(),projectWrap.class);
       // reposneid=ds.Name;
       system.debug('res.getbody===>'+res.getbody());
        return null;
    }
     
public class projectWrap{
 public String id{get;set;}
 public String Name{get;set;}
   
}   
}