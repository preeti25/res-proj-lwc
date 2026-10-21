import { LightningElement } from 'lwc';

export default class Calculator extends LightningElement {
    calval1 = 0;
    calval2 = 0;
    result = '';

    handleValue1Change(event) {
        this.calval1 = event.target.value;
    }

    handleValue2Change(event) {
        this.calval2 = event.target.value;
    }

    handleAdd() {
        const num1 = parseFloat(this.calval1);
        const num2 = parseFloat(this.calval2);
        if (!isNaN(num1) && !isNaN(num2)) {
            this.result = (num1 + num2).toString();
        } else {
            this.result = 'Invalid input';
        }
    }

    handleSubtract() {
        const num1 = parseFloat(this.calval1);
        const num2 = parseFloat(this.calval2);
        if (!isNaN(num1) && !isNaN(num2)) {
            this.result = (num1 - num2).toString();
        } else {
            this.result = 'Invalid input';
        }
    }

    handleMultiply() {
        const num1 = parseFloat(this.calval1);
        const num2 = parseFloat(this.calval2);
        if (!isNaN(num1) && !isNaN(num2)) {
            this.result = (num1 * num2).toString();
        } else {
            this.result = 'Invalid input';
        }
    }

    handleDivide() {
        const num1 = parseFloat(this.calval1);
        const num2 = parseFloat(this.calval2);
        if (!isNaN(num1) && !isNaN(num2) && num2 !== 0) {
            this.result = (num1 / num2).toString();
        } else {
            this.result = 'Invalid input';
        }
    }

    handleClear() {
        this.calval1 = '';
        this.calval2 = '';
        this.result = '';
    }
}