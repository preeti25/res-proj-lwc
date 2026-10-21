import { LightningElement } from 'lwc';

export default class ConditionalRenderingComp extends LightningElement {
    isContentVisible = false;

    handleCheckboxChange() {
        this.isContentVisible = !this.isContentVisible;
    }
}