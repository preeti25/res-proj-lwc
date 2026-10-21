import { LightningElement } from 'lwc';

export default class QuerySelectorComp extends LightningElement {
    greeting = 'World';

    handleClick(event){
        this.greeting = this.template.querySelector('lightning-input').value;
    }
}