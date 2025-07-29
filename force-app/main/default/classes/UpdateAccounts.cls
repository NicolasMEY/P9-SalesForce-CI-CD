// Utilisée par le trigger OrderAfterUpdate.
//Ne recalcule pas depuis zéro mais ajoute uniquement le montant des nouvelles commandes activées.

public with sharing class UpdateAccounts {
  
    // Met à jour le chiffre d’affaires des comptes.
    public static void UpdateAccountRevenue(List<Order> orders) {
        if (orders == null || orders.isEmpty()) {
            return;
        }
        
        Map<Id, Decimal> accountAmountMap = new Map<Id, Decimal>();
        
        for (Order o : orders) {
            if (o != null && o.Status == 'Activated' && o.AccountId != null) {
                // Protéger TotalAmount : parfois null, utiliser 0 si null
                Decimal orderAmount = (o.TotalAmount != null) ? o.TotalAmount : 0;
                
                if (accountAmountMap.containsKey(o.AccountId)) {
                    accountAmountMap.put(o.AccountId, accountAmountMap.get(o.AccountId) + orderAmount);
                } else {
                    accountAmountMap.put(o.AccountId, orderAmount);
                }
            }
        }
        
        if (!accountAmountMap.isEmpty()) {
            List<Account> existingAccounts = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :accountAmountMap.keySet()];
            
            for (Account acc : existingAccounts) {
                Decimal currentCA = (acc.Chiffre_d_affaire__c != null) ? acc.Chiffre_d_affaire__c : 0;
                Decimal addition = (accountAmountMap.get(acc.Id) != null) ? accountAmountMap.get(acc.Id) : 0;
                acc.Chiffre_d_affaire__c = currentCA + addition;
            }
            
            update existingAccounts;
        }
    }
}