import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {
    name = 'Preetish';
    
    handleChange(event) {
        console.log('Input value changed to: ', event.target.value);
        console.log(this.name);
        debugger;
        this.name = this.template.querySelector('lightning-input').value;
    }

    billingAddress = '';
    mailingAddress = '';

    handleBillingAddressChange(event) {
        this.billingAddress = event.target.value;
    }


    handleCopyAddress() {
        this.mailingAddress = this.billingAddress;
    }

    numberValue = 0;
    inchesValue = 0;

    handleNumberChange(event) {
        this.numberValue = event.target.value;
        this.inchesValue = this.numberValue * 12;
    }

}