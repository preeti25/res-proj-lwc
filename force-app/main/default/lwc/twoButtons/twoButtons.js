import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class TwoButtons extends NavigationMixin(LightningElement) {

    handleClickPos() {
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'PositionCreate__c'
            }
        });
    }

    handleClickCand() {
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'CandidateCreate__c'
            }
        }); 
    }
}
