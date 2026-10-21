import { LightningElement } from 'lwc';

export default class CurrencyConverter extends LightningElement {
    eurAmount = 0;
    usdAmount = 0;

    handleEurChange(event) {
        this.eurAmount = parseFloat(event.target.value);
        this.convertToUsd();
    }

    convertToUsd() {
        const conversionRate = 1.15; // Example conversion rate from EUR to USD
        this.usdAmount = (this.eurAmount * conversionRate).toFixed(2);
    }
}