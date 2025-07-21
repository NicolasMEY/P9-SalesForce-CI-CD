public with sharing class RecalculateAccounts {

public static void recalculateAccountRevenue(Set<Id> accountIds) {
    List<Account> accountsToUpdate = new List<Account>();

    for (Id accId : accountIds) {
        AggregateResult[] agg = [
            SELECT SUM(TotalAmount) total FROM Order WHERE AccountId = :accId AND Status = 'Activated'
        ];
        Decimal totalCA = (Decimal)agg[0].get('total');
        accountsToUpdate.add(new Account(Id = accId, Chiffre_d_affaire__c = totalCA));
    }
    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }
}
}