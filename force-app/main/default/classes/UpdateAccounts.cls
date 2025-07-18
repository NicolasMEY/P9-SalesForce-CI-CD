// Utilisée par le trigger OrderAfterUpdate.
//Ne recalcule pas depuis zéro mais ajoute uniquement le montant des nouvelles commandes activées.

public with sharing class UpdateAccounts {
  
    // Met à jour le chiffre d’affaires des comptes.
    public static void UpdateAccountRevenue(List<Order> orders) {
        Map<Id, Decimal> accountAmountMap = new Map<Id, Decimal>();

// On agrège le CA des commandes activées par compte
for (Order o : orders) {
    if(o.Status == 'Activated' && o.AccountId != null) {
        if(accountAmountMap.containsKey(o.AccountId)) {
            accountAmountMap.put(o.AccountId, accountAmountMap.get(o.AccountId) + o.TotalAmount);
        } else {
                accountAmountMap.put(o.AccountId, o.TotalAmount);
        }
    }
}
if (!accountAmountMap.isEmpty()) {
    List<Account> existingAccounts = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN : accountAmountMap.keySet()];
    for(Account acc : existingAccounts) {
        Decimal currentCA = acc.Chiffre_d_affaire__c != null ? acc.Chiffre_d_affaire__c : 0;
        
        acc.Chiffre_d_affaire__c = currentCA + accountAmountMap.get(acc.Id);
    }
    update existingAccounts;
}

    }
}