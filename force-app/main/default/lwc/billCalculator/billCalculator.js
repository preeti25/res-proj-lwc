import { LightningElement } from 'lwc';

export default class BillCalculator extends LightningElement {
    amount = 0;
    quantity = 0;
    subTotalAmount = 0;
    gstAmount = 0;
    totalAmount = 0;

    handleAmountChange(event) {
        this.amount = parseFloat(event.target.value);
        this.calculateBill();
    }

    handleQuantityChange(event) {
        this.quantity = parseFloat(event.target.value);
        this.calculateBill(); 
    }

    calculateBill() {
        if (!isNaN(this.amount) && !isNaN(this.quantity)) {
            this.subTotalAmount = this.amount * this.quantity;
            this.gstAmount = (this.subTotalAmount * 18) / 100;
            this.totalAmount = this.subTotalAmount + this.gstAmount;
        } else {
            this.subTotalAmount = 0;
            this.gstAmount = 0;
            this.totalAmount = 0;
        }
    }
}