import { LightningElement, wire } from 'lwc';
import getAllAccounts from '@salesforce/apex/AccountController.getAllAccounts';

const COLUMNS = [
    { label: 'Account Name', fieldName: 'Name' },
    { label: 'Phone', fieldName: 'Phone' },
];

export default class RecordIteration extends LightningElement {
    records;
    columns = COLUMNS;

    @wire(getAllAccounts)
    wiredAccounts({ data }) {
        if (data) {
            this.records = data;
        }
    }
}