public without sharing class MyTeamOrdersController {
  @AuraEnabled(cacheable=true)
  public static Decimal getSumOrdersByAccount(Id accountId) {
    AggregateResult groupedResults = [
      SELECT SUM(NetAmount__c) total
      FROM Order
      WHERE AccountId = :accountId AND Status = 'Activated'
      WITH SECURITY_ENFORCED
    ];

    Decimal total = (Decimal) groupedResults.get('total');
    if (total == null) {
      total = 0;
    }
    return total;
  }
}
