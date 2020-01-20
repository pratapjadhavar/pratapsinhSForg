import { LightningElement, track, wire  } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import updateSetting from '@salesforce/apex/TimerSetterBatchController.updateSetting';
import getSetting from '@salesforce/apex/TimerSetterBatchController.getTheSetting';
import { NavigationMixin } from 'lightning/navigation';
//import { refreshApex } from '@salesforce/apex';

export default class HelloWorld extends NavigationMixin(LightningElement){

    @track settingRec;
    @track referenceField;
    @track fromVal;
    @track toval;
    @track nameval;
    @track idss;

    @wire(getSetting, {})
    wiredSetting({ error, data }) {
        if (error) {
            this.error = error;
        } else if (data) {
            this.settingRec = data;
            this.referenceField =this.settingRec.Reference_Field__c;
            this.fromVal = this.settingRec.From__c;
            this.toval = this.settingRec.To__c;
            this.nameval = this.settingRec.Name;
            this.idss=  this.settingRec.Id;
            
        }
    }


     handleNameChange(event) {
        this.accountId = undefined;
        if (event.target.label === 'Reference Field') {
            this.referenceField = event.target.value;
        }
        if (event.target.label === 'From') {
            this.fromVal = event.target.value;
        }
        if (event.target.label === 'To') {
            this.toval = event.target.value;
        }
    }

    updateRec() {
        updateSetting({ referVal:this.referenceField, toDataval:this.toval, fromdataVal: this.fromVal, idval:this.idss})
            .then(settingRecResult => {
                this.settingRec=settingRecResult;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Setting Updated',
                        variant: 'success',
                    }), 
                );
              
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
           
            self.close();
            this.navigateToListView();
          
    }

    navigateToListView() {
        this[NavigationMixin.Navigate]({
            "type": "standard__objectPage",
            "attributes": {
                "objectApiName": "Project__c",
                "actionName": "list"
            },
            "state": {
                "filterName": "All"
            }
        });
    }
}