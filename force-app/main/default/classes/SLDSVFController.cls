global with sharing class SLDSVFController extends VF_Messages_Abstract {
    public Boolean overideEmailMethod{set;get;}
    public Boolean overideTextMethod{set;get;}
    public String textVal{get;set;}
    public String emailVal{get;set;}
   

     //user this propertyId for your logic.
    public SLDSVFController(){
       // overideEmailMethod=true;
    }
    
     //read propertyid value from page.
     public void setProperty()
{
     String propertyid = ApexPages.currentPage().getParameters().get('id');
}
     //user this propertyId for your logic.
   /* //Private variables
    private static IntegrationWrapperClass_CF objIntegration = new IntegrationWrapperClass_CF();
    private static PasswordResetWrapper_ACE objPasswordResetWrapper_ACE;

    public PasswordResetController_ACE(LightningContinuationHelperController_CF stdController) {  
    }
    
    /**
*Method to fetch the data from Mulesoft using Continuation Callout.
*
*@return Continuation object.
*/
  /*  @RemoteAction
    global static Object getPasswordReset(String strPasswordResetWrapper_ACE){
        objIntegration = IntegrationClass_CF.continuationCallout(StaticVariablesClass_ACE.STRING_PASSWORD_RESET_ENDPOINT, 
                                                                 StaticVariablesClass_ACE.STRING_CONTINUATION_RESPONSE_METHOD);
        Continuation objContinuation = new Continuation(120);        
        if(strPasswordResetWrapper_ACE != null){
            objPasswordResetWrapper_ACE = (PasswordResetWrapper_ACE)JSON.deserialize(strPasswordResetWrapper_ACE, PasswordResetWrapper_ACE.class);        
            
            //Http Request.
            HttpRequest objHttpRequest = new HttpRequest();
            objHttpRequest.setMethod(objIntegration.strRequestMethod);
            objHttpRequest.setEndpoint(objIntegration.strRequestEndpoint);
            objHttpRequest.setHeader('latency', String.valueOf(objPasswordResetWrapper_ACE.strPolicyId));
            
            // Create a Continuation for the HTTPRequest.                    
            objContinuation.continuationMethod = objIntegration.strCallbackMethodName;
            objContinuation.state = objContinuation.addHttpRequest(objHttpRequest);                        
        }
        return objContinuation;
    }
    
/**
* Method to fetch Results from external System.
* 
* @return Object.
*/
   /* global static Object continuationResponse(Object objState) {
        IntegrationWrapperClass_CF objResponse = IntegrationClass_CF.getContinuationResponse((IntegrationWrapperClass_CF)objState);      
        if(objResponse.strResponseStatusCode == '200'){
            objPasswordResetWrapper_ACE = new PasswordResetWrapper_ACE();
            objPasswordResetWrapper_ACE.boolText = true;
            objPasswordResetWrapper_ACE.boolEmail = true;
            objPasswordResetWrapper_ACE.strPolicyId = '123456789';
            return objPasswordResetWrapper_ACE;
        }else{
            return objResponse.strResponseStatusCode;
        }
    }*/
}