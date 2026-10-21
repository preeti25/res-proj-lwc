import { LightningElement } from 'lwc';

export default class DataBindingThruGetters extends LightningElement {

    firstName = '';
    lastName = '';

    handleChange(event) {
        const fieldName = event.target.name;
        if (fieldName === 'firstName') {
            this.firstName = event.target.value;
        } else if (fieldName === 'lastName') {
            this.lastName = event.target.value;
        }
    }

    get uppercasedfullname() {
        return `${this.firstName} ${this.lastName}`.toUpperCase();
    }
;}