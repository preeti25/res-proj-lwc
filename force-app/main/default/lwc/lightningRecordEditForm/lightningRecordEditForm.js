import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';

export default class LightningRecordEditForm extends LightningElement {
    @api recordId;
    @api objectApiName;

    Name = NAME_FIELD;
    Type = TYPE_FIELD;
    Industry = INDUSTRY_FIELD;
    AnnualRevenue = ANNUAL_REVENUE_FIELD;
}