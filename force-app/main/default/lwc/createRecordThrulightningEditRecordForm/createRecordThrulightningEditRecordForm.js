import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';

export default class LightningRecordEditForm extends LightningElement {
    accountObject = ACCOUNT_OBJECT;

    Name = NAME_FIELD;
    Type = TYPE_FIELD;
    Industry = INDUSTRY_FIELD;
    AnnualRevenue = ANNUAL_REVENUE_FIELD;
    

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Account created successfully",
            message: 'Account created: ' + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
    }
}

