import { LightningElement, api, wire } from 'lwc';
import getLatestScore from '@salesforce/apex/EnrollmentScoreController.getLatestScore';

export default class EnrollmentScoreCard extends LightningElement {
    @api recordId;
    scoreData;
    error;

    @wire(getLatestScore, { contactId: '$recordId' })
    wiredScore({ error, data }) {
        if (data) {
            this.scoreData = data;
        } else if (error) {
            this.error = error;
        }
    }

    get badgeClass() {
        if (!this.scoreData) return '';

        let score = this.scoreData.Score__c;

        if (score >= 75) return 'red';
        if (score >= 40) return 'orange';
        return 'blue';
    }
}
