global class BatchRecalculateAccountRevenue implements Database.Batchable<sObject> {
  global Database.QueryLocator start(Database.BatchableContext info) {
    //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Activated' ==> ok
    return Database.getQueryLocator(
      'SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = \'Activated\')'
    );
  }

  global void execute(Database.BatchableContext info, List<Account> scope) {
    Set<Id> setAccountIds = (new Map<Id, SObject>(scope)).keySet();
    RecalculateAccounts.recalculateAccountRevenue(setAccountIds);
    // Appeler une class qui va faire la logique du code ==> ok
  }

  global void finish(Database.BatchableContext info) {
    // ...Optionnel
  }
}
