import { LightningElement, api, track } from 'lwc';

import saveAllocations
from '@salesforce/apex/ResourceAllocationController.saveAllocations';

import { ShowToastEvent }
from 'lightning/platformShowToastEvent';

export default class ResourceAllocation extends LightningElement {

    @api recordId;

    @track rows = [
        {
            key: 1,
            resourceId: '',
            startDate: '',
            endDate: ''
        }
    ];

    addRow(){

        this.rows.push({
            key: Date.now(),
            resourceId: '',
            startDate: '',
            endDate: ''
        });
    }

    removeRow(event){

        const index = event.target.dataset.index;

        this.rows.splice(index,1);

        this.rows = [...this.rows];
    }

    handleResourceChange(event){

        const index = event.target.dataset.index;

        this.rows[index].resourceId =
            event.detail.value[0];
    }

    handleStartChange(event){

        const index = event.target.dataset.index;

        this.rows[index].startDate =
            event.detail.value;
    }

    handleEndChange(event){

        const index = event.target.dataset.index;

        this.rows[index].endDate =
            event.detail.value;
    }

    saveRecords(){

        // Frontend validation
        let isValid = true;

        this.rows.forEach(row => {

            if(
                !row.resourceId ||
                !row.startDate ||
                !row.endDate
            ){
                isValid = false;
            }
        });

        if(!isValid){

            this.showToast(
                'Error',
                'Please fill all required fields',
                'error'
            );

            return;
        }

        saveAllocations({
            rows : this.rows,
            projectId : this.recordId
        })

        .then(() => {

            this.showToast(
                'Success',
                'Records Created Successfully',
                'success'
            );
        })

        .catch(error => {

            this.showToast(
                'Error',
                error.body.message,
                'error'
            );
        });
    }

    showToast(title,message,variant){

        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}