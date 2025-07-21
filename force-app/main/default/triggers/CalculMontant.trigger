trigger CalculMontant on Order (before insert, before update) {
	for (Order o : trigger.new) {
		o.NetAmount__c = 
		(o.TotalAmount != null ? o.TotalAmount : 0) - 
		(o.ShipmentCost__c != null ? o.ShipmentCost__c : 0);	}
		// Évite un NullPointerException si TotalAmount ou ShipmentCost__c est null.
}

// Traitement bulkifié pour tous les orders et pas seulement 1
// Ajout du before insert pour le calcul dès la création


