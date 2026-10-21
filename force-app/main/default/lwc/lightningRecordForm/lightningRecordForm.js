import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';

export default class LightningRecordForm extends LightningElement {
    objectApiName = ACCOUNT_OBJECT;
    myFields = [NAME_FIELD, WEBSITE_FIELD];

    handleAccountCreated(event) {
        const evt = new ShowToastEvent({
            title: "Account created successfully",
            message: 'Account created: ' + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
    }
}