public class InputLookup {
    @AuraEnabled
    public static SObject loadDefault(String s, String sObjectType) {
        try {
            String query = 'SELECT Id, Name FROM {1} WHERE Id={0}';
            return Database.query(String.format(query, new List<String> { '\''+s+'\'', sObjectType }));
        } catch (Exception e) {        
        }  
        return null;
    }

    @AuraEnabled
    public static List<SObject> searchLookup(String s, String sObjectType) {
        try {
            String query = 'FIND {0} IN Name FIELDS RETURNING {1}(Id,Name) LIMIT 50';
            List<List <SObject>> results = Search.query(String.format(query, new List<String> { '\''+s+'\'', sObjectType }));
            return results[0];
        } catch (Exception e){
        }
        return null;
    }
}