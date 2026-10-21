import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class CandidateCreate extends NavigationMixin(LightningElement) {

handleSuccess(event){
    const recordId = event.detail.id;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                actionName: 'view'
            }
        });
    }
}