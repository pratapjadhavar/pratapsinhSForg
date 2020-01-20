public class attachmentsample {

    public attachmentsample(ApexPages.StandardController controller) {

    }
    Public Attachment myfile;
    Public Attachment getmyfile()
    {
        myfile = new Attachment();
        return myfile;
    }
   
    Public Pagereference Savedoc()
    {
        String accid = System.currentPagereference().getParameters().get('id');

        Attachment a = new Attachment(parentId = 'a0D0I00000y5sJi', name=myfile.name, body = myfile.body);
         
         /* insert the attachment */
         insert a;
        return NULL;
    }   

}