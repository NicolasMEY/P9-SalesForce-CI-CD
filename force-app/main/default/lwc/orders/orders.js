import { LightningElement, api, wire } from 'lwc';
import getSumOrderByAccount from '@salesforce/apex/MyTeamOrdersController.getSumOrdersByAccount';
// TODO - récupérer la méthode apex permettant de faire ce calcul

export default class Orders extends LightningElement {
    @api recordId;
    sumOrdersOfCurrentAccount;

    // liaison automatique et réactive aux changements
    @wire(getSumOrderByAccount, {accountId: '$recordId'})
    wireSumOrders({error, data}) {
        if (data !== undefined) {
            this.sumOrdersOfCurrentAccount = data;
        } else if (error) {
            this.sumOrdersOfCurrentAccount = null;
            console.error('Error fetching sum of orders: ', error);
        }
    }
    
    
    /*
    // contrôler manuellement quand appeler l’Apex (par exemple uniquement au chargement avec connectedCallback),
    connectedCallback() {
        this.fetchSumOrders();
    }

    // TODO - récupérer le montant total des Orders sur le compte avec la méthode apex
    async fetchSumOrders() {
        if (!this.recordId) {
            return;
        }
        try {
            const result = await getSumOrderByAccount({ accountId: this.recordId });
            this.sumOrdersOfCurrentAccount = result;
        } catch (error) {
            this.sumOrdersOfCurrentAccount = null;
            console.error('Error fetching sum of orders: ', error);
        }
    }
    */
}