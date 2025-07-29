public with sharing class RecalculateAccounts {
  public static void recalculateAccountRevenue(Set<Id> accountIds) {
    List<Account> accountsToUpdate = new List<Account>();

    // Ma requête sélectionne la somme des montants totaux des commandes (TotalAmount) pour un compte spécifique (accId), mais uniquement celles dont le statut est "Activated".
    for (Id accId : accountIds) {
      AggregateResult[] agg = [
        SELECT SUM(TotalAmount) total
        FROM Order
        WHERE AccountId = :accId AND Status = 'Activated'
      ];
      Decimal totalCA = (Decimal) agg[0].get('total');
      accountsToUpdate.add(
        new Account(Id = accId, Chiffre_d_affaire__c = totalCA)
      );
    }
    if (!accountsToUpdate.isEmpty()) {
      update accountsToUpdate;
    }
  }
}
