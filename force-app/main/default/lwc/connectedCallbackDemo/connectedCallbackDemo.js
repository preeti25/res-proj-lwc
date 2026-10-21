import { LightningElement } from 'lwc';

export default class ConnectedCallbackDemo extends LightningElement {
    name = 'car';
    price = '$27000';
    ready = false;

    connectedCallback() {
        setTimeout(() =>{
            this.ready = true;
        },3000);
    }
}