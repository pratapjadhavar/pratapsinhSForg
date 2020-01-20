public class myControllerExtension {

    private final Account acct;
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public myControllerExtension(ApexPages.StandardController stdController) {
        String nAgt = ApexPages.currentPage().getHeaders().get('USER-AGENT');
        
            String browserName  ='';
        
            Integer nameOffset,verOffset,ix;
            
            // In Opera 15+, the true version is after "OPR/" 
            if ((verOffset=nAgt.indexOf('OPR/'))!=-1) {
             browserName = 'Opera';
         
            }
            // In older Opera, the true version is after "Opera" or after "Version"
            else if ((verOffset=nAgt.indexOf('Opera'))!=-1) {
             browserName = 'Opera';
          
            }
            // In MSIE, the true version is after "MSIE" in userAgent
            else if ((verOffset=nAgt.indexOf('MSIE'))!=-1) {
             browserName = 'Microsoft Internet Explorer';
           
            } 
            // In Chrome, the true version is after "Chrome" 
            else if ((verOffset=nAgt.indexOf('Chrome'))!=-1) {
             browserName = 'Chrome';
         
            }
            // In Safari, the true version is after "Safari" or after "Version" 
            else if ((verOffset=nAgt.indexOf('Safari'))!=-1) {
             browserName = 'Safari';
         
            }
            // In Firefox, the true version is after "Firefox" 
            else if ((verOffset=nAgt.indexOf('Firefox'))!=-1) {
             browserName = 'Firefox';
           
            }
            // In most other browsers, "name/version" is at the end of userAgent 
            else if ( (nameOffset=nAgt.lastIndexOf(' ')+1) < 
                      (verOffset=nAgt.lastIndexOf('/')) ) 
            {
             browserName = nAgt.substring(nameOffset,verOffset);
           
            }
        
        
     
        this.acct = (Account)stdController.getRecord();
        acct.NaicsDesc=browserName;
    }

    public String getGreeting() {
        return 'Hello ' + acct.name + ' (' + acct.id + ')';
    }
    
}