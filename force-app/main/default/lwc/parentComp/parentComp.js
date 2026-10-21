import { LightningElement } from 'lwc';

export default class ParentComp extends LightningElement {
age = '';
handleChange(event) {
    this.age = event.target.value;
  }

  get eligibleforVote() {
    return this.age >= 18;
  }

  get notEligibleforVote() {
    return this.age < 18 && this.age > 0;
  }

  get seniorCitizen() {
    return this.age >= 60;
  }
}