public without sharing class MyTeamOrdersController {
    
    @AuraEnabled(cacheable=true)
    public static Decimal getSumOrdersByAccount(Id accountId) {
        AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE AccountId = :accountId AND Status = 'Activated' WITH SECURITY_ENFORCED];
        return (Decimal)groupedResults.get('total');
    }
}