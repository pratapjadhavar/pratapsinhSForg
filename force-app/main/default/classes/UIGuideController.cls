/**
 * Manages Custom Framework example page actions..
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public with sharing class UIGuideController extends StaticVariablesClass_CF {

    //Public variables.
    public String strInputText {get; set;}
    public String strLeadIdForAttachments {get; set;}
    public String strIntegrationServiceRecordId {get; set;}
    public Case objCase {get; set;}
    public Lead objLead {get; set;}
    public Attachment objAttachment {
        get {
            if (objAttachment == null) {
                objAttachment = new Attachment();
            }
            return objAttachment;
        }
        set;
    }
    public List<Wrapper> lstRecords {get; set;}
    public List<Wrapper> lstRecordsOrder {get; set;}

    //Private variables.
    private Wrapper objRecord;
    private Wrapper objRecordOrder;

    /**
     * Constructor of the class.
     */
    public UIGuideController() {

        //Creating example records.
        lstRecords = new List<Wrapper>();
        objRecord = new Wrapper();
        objRecord.strName = CUSTOM_FRAMEWORK_EXAMPLE_1_NAME;
        objRecord.strPosition = CUSTOM_FRAMEWORK_EXAMPLE_1_POSITION;
        objRecord.strOffice = CUSTOM_FRAMEWORK_EXAMPLE_1_OFFICE;
        objRecord.strSalary = CUSTOM_FRAMEWORK_EXAMPLE_1_SALARY;
        lstRecords.add(objRecord);
        objRecord = new Wrapper();
        objRecord.strName = CUSTOM_FRAMEWORK_EXAMPLE_2_NAME;
        objRecord.strPosition = CUSTOM_FRAMEWORK_EXAMPLE_2_POSITION;
        objRecord.strOffice = CUSTOM_FRAMEWORK_EXAMPLE_2_OFFICE;
        objRecord.strSalary = CUSTOM_FRAMEWORK_EXAMPLE_2_SALARY;
        lstRecords.add(objRecord);
        objRecord = new Wrapper();
        objRecord.strName = CUSTOM_FRAMEWORK_EXAMPLE_3_NAME;
        objRecord.strPosition = CUSTOM_FRAMEWORK_EXAMPLE_3_POSITION;
        objRecord.strOffice = CUSTOM_FRAMEWORK_EXAMPLE_3_OFFICE;
        objRecord.strSalary = CUSTOM_FRAMEWORK_EXAMPLE_3_SALARY;
        lstRecords.add(objRecord);
        lstRecordsOrder = new List<Wrapper>();
        objRecordOrder = new Wrapper();
        objRecordOrder.strAlphaCode = CUSTOM_FRAMEWORK_EXAMPLE_4_ALPHA_CODE;
        objRecordOrder.strPosition = CUSTOM_FRAMEWORK_EXAMPLE_4_POSITION;
        lstRecordsOrder.add(objRecordOrder);
        objRecordOrder = new Wrapper();
        objRecordOrder.strAlphaCode = CUSTOM_FRAMEWORK_EXAMPLE_5_ALPHA_CODE;
        objRecordOrder.strPosition = CUSTOM_FRAMEWORK_EXAMPLE_5_POSITION;
        lstRecordsOrder.add(objRecordOrder);
        objRecordOrder = new Wrapper();
        objRecordOrder.strAlphaCode = CUSTOM_FRAMEWORK_EXAMPLE_6_ALPHA_CODE;
        objRecordOrder.strPosition = CUSTOM_FRAMEWORK_EXAMPLE_6_POSITION;
        lstRecordsOrder.add(objRecordOrder);
        objRecordOrder = new Wrapper();
        objRecordOrder.strAlphaCode = CUSTOM_FRAMEWORK_EXAMPLE_7_ALPHA_CODE;
        objRecordOrder.strPosition = CUSTOM_FRAMEWORK_EXAMPLE_7_POSITION;
        lstRecordsOrder.add(objRecordOrder);
        objRecordOrder = new Wrapper();
        objRecordOrder.strAlphaCode = CUSTOM_FRAMEWORK_EXAMPLE_8_ALPHA_CODE;
        objRecordOrder.strPosition = CUSTOM_FRAMEWORK_EXAMPLE_8_POSITION;
        lstRecordsOrder.add(objRecordOrder);
        objRecordOrder = new Wrapper();
        objRecordOrder.strAlphaCode = CUSTOM_FRAMEWORK_EXAMPLE_9_ALPHA_CODE;
        objRecordOrder.strPosition = CUSTOM_FRAMEWORK_EXAMPLE_9_POSITION;
        lstRecordsOrder.add(objRecordOrder);
        objRecordOrder = new Wrapper();
        objRecordOrder.strAlphaCode = CUSTOM_FRAMEWORK_EXAMPLE_10_ALPHA_CODE;
        objRecordOrder.strPosition = CUSTOM_FRAMEWORK_EXAMPLE_10_POSITION;
        lstRecordsOrder.add(objRecordOrder);
        objRecordOrder = new Wrapper();
        objRecordOrder.strAlphaCode = CUSTOM_FRAMEWORK_EXAMPLE_11_ALPHA_CODE;
        objRecordOrder.strPosition = CUSTOM_FRAMEWORK_EXAMPLE_11_POSITION;
        lstRecordsOrder.add(objRecordOrder);
        strIntegrationServiceRecordId = '';
    }

    /**
     * Action method example.
     */
    public void actionMethod() {
    }

    /**
     * Fatal page message.
     */
    public void fatal() {
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, CUSTOM_FRAMEWORK_FATAL_MESSAGE);
        ApexPages.addMessage(myMsg);
    }

    /**
     * Success page message.
     */
    public void success() {
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM, CUSTOM_FRAMEWORK_SUCCESS_MESSAGE);
        ApexPages.addMessage(myMsg);
    }

    /**
     * Remote action example.
     * @param  strQuery Query example.
     * @return List of wrapper classes.
     */
    @RemoteAction
    public static List<Wrapper> remoteAction(String strQuery) {
        List<Wrapper> lstList = new List<Wrapper>();
        Wrapper objWrapper = new Wrapper();

        //Adding record 1.
        objWrapper = new Wrapper();
        objWrapper.strName = StaticVariablesClass_CF.CUSTOM_FRAMEWORK_EXAMPLE_12_NAME;
        objWrapper.strPosition = StaticVariablesClass_CF.CUSTOM_FRAMEWORK_EXAMPLE_12_POSITION;
        objWrapper.strOffice = StaticVariablesClass_CF.CUSTOM_FRAMEWORK_EXAMPLE_12_OFFICE;
        objWrapper.strSalary = StaticVariablesClass_CF.CUSTOM_FRAMEWORK_EXAMPLE_12_SALARY;
        lstList.add(objWrapper);

        //Adding record 2.
        objWrapper = new Wrapper();
        objWrapper.strName = StaticVariablesClass_CF.CUSTOM_FRAMEWORK_EXAMPLE_13_NAME;
        objWrapper.strPosition = StaticVariablesClass_CF.CUSTOM_FRAMEWORK_EXAMPLE_13_POSITION;
        objWrapper.strOffice = StaticVariablesClass_CF.CUSTOM_FRAMEWORK_EXAMPLE_13_OFFICE;
        objWrapper.strSalary = StaticVariablesClass_CF.CUSTOM_FRAMEWORK_EXAMPLE_13_SALARY;
        lstList.add(objWrapper);

        //Returning result.
        return lstList;
    }

    /**
     * Action method to create Lead example records.
     */
    public void customFrameworkExamplesAction() {
        createLead();
    }
    
    /**
     * Creates a demo Lead for input file examples.
     */
    public void createLead() {
        Id objId;
        for(Lead objLead : [SELECT Id FROM Lead Where Name = :CUSTOM_FRAMEWORK_MEMBER_ID LIMIT 1]) {
            objId = objLead.Id;
        }
        if(objId != null) {
            strLeadIdForAttachments = objId;
        } else {
            Lead objLead = new Lead (LastName = CUSTOM_FRAMEWORK_MEMBER_ID, City = CUSTOM_FRAMEWORK_BILING_CITY, Company = CUSTOM_FRAMEWORK_MEMBER_ID);
            insert objLead;
            strLeadIdForAttachments = objLead.Id;
        }
    }
    
    /**
     * Method that triggers the Integration Functionality with a GIT service.
     */
   /* public void createIntegrationDetail() {
        IntegrationWrapperClass_CF objIntegrationExample = IntegrationClass_CF.synchronousCallout('Test');
        for(IntegrationDetail_CF__c objIntegration : [SELECT Id, CreatedDate FROM IntegrationDetail_CF__c ORDER BY CreatedDate DESC LIMIT 1]) {
            strIntegrationServiceRecordId = objIntegration.Id;
        }
    }*/

    /**
     * Wrapper: Wrapper class for example records.
     */
    public class Wrapper {

        //Public variables.
        public String strAlphaCode {get; set;}
        public String strName {get; set;}
        public String strPosition {get; set;}
        public String strOffice {get; set;}
        public String strSalary {get; set;}
    }
}