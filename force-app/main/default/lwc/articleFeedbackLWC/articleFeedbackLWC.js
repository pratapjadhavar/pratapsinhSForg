import { LightningElement,api , track} from 'lwc';
import saveVote from '@salesforce/apex/articleFeedbackController.saveVote';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class ArticleFeedbackLWC extends LightningElement {
    @track disLikeState = false;
    @track likeState=false;
    @track disableBtn=false;
    @track feebacktext;
    @track showfeedbackInput=false;
    @track formSubmitted=false;
    @api recordId;
  
    handleLikeButtonClick() {
        this.likeState=!this.likeState;

        if(this.likeState){
            this.disLikeState = false;
            this.showfeedbackInput=true;
        }
    }

    handleDisLikeButtonClick() {
        this.disLikeState = !this.disLikeState;

        if(this.disLikeState){
            this.likeState=false;
            this.showfeedbackInput=true;
        }
        
    }

    handleSave(){
        saveVote({upvote:this.likeState,downvote:this.disLikeState,feedBackText:this.feebacktext,articleRecId:this.recordId})
            .then(result => {
                window.console.log('result ===> '+result);
                this.formSubmitted=true;
               
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error while submitting feedback',
                        message: error.message,
                        variant: 'error'
                    })
                );
               
            });
    }

    feedbackTextChangeHandler(event){
        this.feebacktext=event.target.value;
    }
    
}