import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import TYPE_FIELD from '@salesforce/schema/Account.Type';

export default class CreateAccountComp extends NavigationMixin(LightningElement) {
    objectApiName = ACCOUNT_OBJECT;
    myFields = [NAME_FIELD, WEBSITE_FIELD, PHONE_FIELD, INDUSTRY_FIELD, RATING_FIELD, TYPE_FIELD];

    handleAccountCreated(event) {
        const id = event.detail.id;s

        this.dispatchEvent(new ShowToastEvent({
            title: 'Account created successfully',
            message: `Account created: ${id}`,
            variant: 'success'
        }));

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: id,
                objectApiName: 'Account',
                actionName: 'view'
            }
        });
    }
}