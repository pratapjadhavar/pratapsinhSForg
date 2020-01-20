import { LightningElement, track } from 'lwc';
    import { createRecord } from 'lightning/uiRecordApi';
    import { ShowToastEvent } from 'lightning/platformShowToastEvent';
    import LEAD_OBJECT from '@salesforce/schema/Lead';
    
    export default class WetoLeadLWC extends LightningElement {
        @track leadRecord = {};
        @track showInputForm=true;
        @track showConfirmForm=false;
        @track showThanksMsg=false;
        @track confirmBtnDisabled=true;
        @track navigateTo;

        connectedCallback(){
            window.addEventListener("message",this.handleResponseFromIframe.bind(this));
        }

        handleResponseFromIframe(event){
        
             if(event.data!=null && event.data!==undefined && event.data=='captcha success'){
                     this.confirmBtnDisabled=false;
             }else{
                 this.dispatchEvent(
                     new ShowToastEvent({
                         title: 'Success',
                         message: 'Something wrong with recaptcha feature. Please contact admin',
                         variant: 'error'
                     })
                 );
             }
         }
        
        navBack(){
            this.showInputForm=true;
            this.showConfirmForm=false;
        }
       
        handleFieldChange(e) {
            this.leadRecord[e.currentTarget.fieldName] = e.target.value;
        }

        saveTempForm() {  

            if(!this.validateEmail(this.leadRecord.Email)){
                return;
            }
            if(this.leadRecord.LastName!=null && this.leadRecord.LastName!=='' &&
            this.leadRecord.Company!=null && this.leadRecord.Company!=='' &&
            this.leadRecord.Email!=null && this.leadRecord.Email!==''){
                this.showInputForm=false;
                this.showConfirmForm=true;
                this.confirmBtnDisabled=true;
            } 
        
        }
   
        saveForm() {
            createRecord({ apiName: LEAD_OBJECT.objectApiName, fields: this.leadRecord })
                .then(lead => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Your details submitted successfully!',
                            variant: 'success'
                        })
                    );
                    this.showConfirmForm=false;
                    this.showThanksMsg=true;
                })
                .catch((error) => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error creating record',
                            message: error.body.message,
                            variant: 'error'
                        })
                    );
                });
        }

        //validate email address
        validateEmail(email) {
            var re =/^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/;
            return re.test(String(email).toLowerCase());
        }

    }