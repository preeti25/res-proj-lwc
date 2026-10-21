import { LightningElement, api, wire } from 'lwc';
import getRecords from '@salesforce/apex/HandlerLWC.FetchPositions';

export default class OpenPositionDT extends LightningElement {
    @api recordId;
    PositionList;

    columns = [
        { label: 'Position Name', fieldName: 'Name' },
        { label: 'Min Pay', fieldName: 'Min_Pay__c' },
        { label: 'Max Pay', fieldName: 'Max_Pay__c' },
        { label: 'Location', fieldName: 'Location__c' },
        { label: 'Status', fieldName: 'Status__c' }
    ];

    @wire(getRecords)
    wiredPositions({ data, error }) {
        if (data) {
            this.PositionList = data;
        } else if (error) {
            console.error('Error fetching positions:', error);
        }
    }
}