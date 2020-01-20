import { LightningElement, api, track} from 'lwc';
import saveQuestion from '@salesforce/apex/askQuestionController.saveQuestion';
import getPickListValues from '@salesforce/apex/askQuestionController.getPickListValues';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';


export default class AskQuestionLWC extends NavigationMixin(LightningElement){
    @track error;
    @api recordId;

    @track options;
    @track selectedTopicId;
    @track questionData;
    @track disableAskBtn=true;
    @track loaded=true;

    handleSave() {
        this.loaded=false;
        if(this.selectedTopicId!=null && this.selectedTopicId!='' && this.selectedTopicId!='Choose...' &&
            this.questionData!=null && this.questionData!=''){
        
                saveQuestion({topicIId:this.selectedTopicId, questionDataStr:this.questionData})
                .then(result => {

                this.isOpenModal = false;
                this.navigateToTopic();
                this.loaded=true;
            
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!!',
                    message: 'Question Submitted Successfully!!',
                    variant: 'success'
                }),);
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.message,
                        variant: 'error'
                    })
                );
                this.loaded=true;
            });
        }else{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: 'Please Fill required fields',
                    variant: 'error'
                })
            );
            this.loaded=true;
        }
    }


    connectedCallback() {
		getPickListValues()
			.then(data => {
				this.options = data;
			})
			.catch(error => {
				this.displayError(error);
            });
        }

        selectionChangeHandler(event) {
            this.selectedTopicId=event.target.value;
            if(this.selectedTopicId!='' && this.selectedTopicId!=null && this.selectedTopicId!='Choose...' && this.questionData!='' && this.questionData!=null){
                this.disableAskBtn=false;
            }else{
                this.disableAskBtn=true;
            }
        }

        questionChangehandler(event){
            this.questionData=event.target.value;
            if(this.selectedTopicId!=''  && this.selectedTopicId!=null && this.selectedTopicId!='Choose...' && this.questionData!=null && this.questionData!=''){
                this.disableAskBtn=false;
            }else{
                this.disableAskBtn=true;
            }
        }

        navigateToTopic(){
             this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url: '/DCdemo/s/topic/'+this.selectedTopicId
                }
            },
            true // Replaces the current page in your browser history with the URL
            );
        }
      

        @track isOpenModal = false;
 
    handleOpenModal() {
        this.isOpenModal = true;
    }
   
    handleCloseModal() {
        this.isOpenModal = false;
    }
}