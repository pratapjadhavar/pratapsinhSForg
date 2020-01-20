public class oAuth_Controller{
    
    private auth_response rt;
    private final String clientId = '3MVG9YDQS5WtC11oIhN8teiTkBbBJSxKCsR.B3vEsnHUDer3toEbDz1DwL93HLO5CgSiH_NfRGqh_e2TWI5cU';
    private final String clientSecret = '5096140471052011846';
    public pagereference auth_Step_1(){
        
        
        String auth_url = 'https://login.salesforce.com/services/oauth2/authorize';
        String params =   '?response_type=code&client_id=' + encodingUtil.urlencode(clientId,'UTF-8') +
            			  '&redirect_uri=https://pratapsinh-dev-ed--c.ap7.visual.force.com/apex/tokenVF'+
            			  '&prompt=consent'+
            			  '&scope=' + encodingUtil.URLEncode('full refresh_token','UTF-8')+
            			  '&state=step2';
        pageReference pr = New PageReference(auth_url + params);
        return pr;
    }
    
    public pagereference auth_Step_2(){
        
        if(apexPages.currentPage().getParameters().get('state') != 'step2')
            return null;
        
        
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        
        String auth_url = 'https://login.salesforce.com/services/oauth2/token';
        String params =  
            '?code=' + apexPages.currentPage().getParameters().get('code') +
            '&grant_type=authorization_code' + 
            '&client_id=' + encodingUtil.urlencode(clientId,'UTF-8') +
            '&client_secret='+clientSecret+
            '&redirect_uri=https://pratapsinh-dev-ed--c.ap7.visual.force.com/apex/tokenVF';
        
        req.setMethod('POST');
        req.setEndpoint(auth_url + params);
        
        HTTPResponse resp = http.send(req);
        
        rt = (auth_response)json.deserialize(resp.getBody(),auth_response.class);
        system.debug('refresh token=='+rt);
        return null;
        
    }
    
    public void getnewtoken(){
        
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        
        String auth_url = 'https://login.salesforce.com/services/oauth2/token';
        String params =     '?grant_type=refresh_token' +'&client_id=' + encodingUtil.urlencode(clientId,'UTF-8') +
            				'&client_secret='+clientSecret+
            				'&refresh_token=' + encodingUtil.URLEncode(rt.refresh_token,'UTF-8');
        
        req.setMethod('POST');
        req.setEndpoint(auth_url + params);
        
        HTTPResponse resp = http.send(req);
        system.debug('resp.getBody===='+resp.getBody());
        
    }
    
    
    
    private class auth_response{
        
        public string refresh_token;
        public string access_token;
        
    }
}