public class UploadImageFromMobile {
    @AuraEnabled
    public static void createAttachment(String strAttachJSON, Id accountId){
        AttachClass objAttach = (AttachClass) JSON.deserialize(strAttachJSON, AttachClass.Class);
        Attachment a = new Attachment(parentid=accountId, Name = objAttach.fileName, 
                                      Body = EncodingUtil.base64Decode(objAttach.Body), 
                                      contentType= objAttach.contentType);
        insert a;
    }
    public class AttachClass{
        @AuraEnabled public String fileName;
        @AuraEnabled public String contentType;
        @AuraEnabled public String Body;
    }
}