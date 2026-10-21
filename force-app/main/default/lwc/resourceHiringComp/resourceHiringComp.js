import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import hiringSiteStatic from '@salesforce/resourceUrl/hiring_site_static';

export default class ResourceHiringComp extends NavigationMixin(LightningElement) {
    Pos1 = hiringSiteStatic; // or `${hiringSiteStatic}/image.png` if zipped

    positionFirstLink = '#';
    positionSecondLink = '#';
    positionThirdLink = '#';

    connectedCallback() {
        // Generates dynamic Experience Cloud relative links based on record API
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: 'a042w00000xIV3PAAU',
                actionName: 'view'
            }
        }).then(url => {
            this.positionFirstLink = url;
        });
    }
}
