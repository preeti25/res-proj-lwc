import { api, LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class LightningRecordFormOpp extends LightningElement {
    @api recordId;
    objectApiName = 'Opportunity';
    myFields = ['Name', 'Amount', 'CloseDate', 'StageName', 'LeadSource'];

    handleAccountCreated(event) {
        const evt = new ShowToastEvent({
            title: "Opportunity created successfully",
            message: 'Opportunity record processed successfully with ID: ' + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
    }
}
