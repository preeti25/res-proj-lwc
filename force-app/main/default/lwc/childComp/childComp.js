import { LightningElement, api } from 'lwc';

export default class ChildComp extends LightningElement {
    
    lowerCaseLastName = 'default value';
    lowerCaseFirstName = 'default';

    @api
    get firstName() {
        return this.lowerCaseFirstName.toUpperCase();
    }

    set firstName(value) {
        this.lowerCaseFirstName = value.toLowerCase();
    }
@api
    get lastName() {
        return this.lowerCaseLastName.toUpperCase();
    }

    set lastName(value) {
        this.lowerCaseLastName = value.toLowerCase();
    }

}