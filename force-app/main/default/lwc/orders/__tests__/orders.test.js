// Import de l'API LWC pour créer un composant
import { createElement } from 'lwc'; 
// Import de mon composant Orders
import Orders from 'c/orders';       

// Groupe de tests pour c-orders
describe('c-orders', () => {   
    // Fonction exécutée après chaque test      
    afterEach(() => {                
        // Reset DOM after each test
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild); 
            // Vide le DOM pour éviter interférences entre tests
        }
    });

    // Premier test : création du composant
    it('component is created successfully', () => { 
        const element = createElement('c-orders', {
            is: Orders
        });
        document.body.appendChild(element); // Ajoute au DOM

        expect(element).toBeTruthy(); // Vérifie que l'élément existe
    });

    // Deuxième test : message erreur
    it('displays error message when sumOrdersOfCurrentAccount is null or 0', () => { 
        const element = createElement('c-orders', {
            is: Orders
        });
        element.sumOrdersOfCurrentAccount = 0; // Force la valeur à 0
        document.body.appendChild(element);

        return Promise.resolve().then(() => { // Attend le rendu complet
            const errorDiv = element.shadowRoot.querySelector('.slds-theme_error'); // Cherche div rouge
            expect(errorDiv).not.toBeNull(); // Vérifie qu'elle existe
            expect(errorDiv.textContent).toContain('Erreur, pas de commandes rattachées'); // Vérifie son texte
        });
    });

    // Troisième test : message succès
    it('displays success message when sumOrdersOfCurrentAccount is greater than 0', () => { 
        const element = createElement('c-orders', {
            is: Orders
        });
        element.sumOrdersOfCurrentAccount = 1500; // Force la valeur à 1500
        document.body.appendChild(element);

        return Promise.resolve().then(() => { // Attend le rendu complet
            const successDiv = element.shadowRoot.querySelector('.slds-theme_success'); // Cherche div verte
            expect(successDiv).not.toBeNull(); // Vérifie qu'elle existe
            expect(successDiv.textContent).toContain('Total des Commandes : 1500'); // Vérifie son texte
        });
    });
});