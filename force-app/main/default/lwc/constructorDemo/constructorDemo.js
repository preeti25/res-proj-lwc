import { LightningElement } from 'lwc';

export default class ConstructorDemo extends LightningElement {
    test;

    constructor(){
        super();
        this.test = 'Component instance is created';
    }
}