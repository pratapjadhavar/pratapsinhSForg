public class AnimalLocator {
    
    public static String getAnimalNameById(Integer animalID){
        Http http=new Http();
        HttpRequest req=new HttpRequest();
        req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+animalID);
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
      

        
        system.debug('req=='+req);
        HttpResponse response = http.send(req);
        // Parse the JSON response
        
     
              Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                Map<String, Object> animal = (Map<String, Object>) results.get('animal');
                system.debug('res=='+(String)animal.get('name'));
                return (String)animal.get('name');
       
    
    }

}