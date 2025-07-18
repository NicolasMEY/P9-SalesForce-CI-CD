trigger CalculMontant on Order (before insert, before update) {
	for (Order o : trigger.new) {
		o.NetAmount__c = o.TotalAmount - o.ShipmentCost__c;
	}
}

// Traitement bulkifié pour tous les orders par seulement 1
// Ajout du before insert pour le calcul dès la création