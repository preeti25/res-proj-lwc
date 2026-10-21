import { LightningElement } from 'lwc';

export default class MarksCalculator extends LightningElement {
    subject1 = 0;
    subject2 = 0;
    subject3 = 0;
    totalMarks = '';
    percentage = '';

    handleSubjectValue1(event) {
        this.subject1 = event.target.value;
        console.log(this.subject1);
    }

    handleSubjectValue2(event) {
        this.subject2 = event.target.value;
        console.log(this.subject2);
    }

    handleSubjectValue3(event) {
        this.subject3 = event.target.value;
        console.log(this.subject3);
    }

    handleCalculateTotal() {
        const num1 = parseFloat(this.subject1);
        const num2 = parseFloat(this.subject2);
        const num3 = parseFloat(this.subject3);
        console.log(this.subject1);
        if (!isNaN(num1) && !isNaN(num2) && !isNaN(num3)) {
            const total = num1 + num2 + num3;
            this.totalMarks = total.toString();
            
        } else {
            this.totalMarks = 'Invalid input';
            
        }
    }

    handleCalculatePercentage(){
        const num1 = parseFloat(this.subject1);
        const num2 = parseFloat(this.subject2);
        const num3 = parseFloat(this.subject3);
        if (!isNaN(num1) && !isNaN(num2) && !isNaN(num3)) {
            const total = num1 + num2 + num3;
            this.percentage = ((total / 300) * 100).toFixed(2) + '%';
        } else {
            this.percentage = 'Invalid input';
        }
    }

    handleClear() {
        this.subject1 = '';
        this.subject2 = '';
        this.subject3 = '';
        this.totalMarks = '';
        this.percentage = '';
    }
}