@isTest
public class TestRecalculateAccounts {

    @testSetup
    static void setup() {
        Account acc = TestFactory.createAccount('Test Account');

        // Crée un Order avec OrderItem pour générer un TotalAmount
        TestFactory.createOrderWithOrderItems(acc.Id, 100, 2, 'Activated', 5);
        TestFactory.createOrderWithOrderItems(acc.Id, 200, 3, 'Activated', 10);
        TestFactory.createOrderWithOrderItems(acc.Id, 300, 1, 'Draft', 0);
    }

    @isTest
    static void testRecalculateAccountRevenue() {
        List<Account> accounts = [SELECT Id FROM Account];
        Set<Id> accountIds = new Map<Id, Account>(accounts).keySet();

        Test.startTest();
        RecalculateAccounts.recalculateAccountRevenue(accountIds);
        Test.stopTest();

        Account updatedAcc = [SELECT Chiffre_d_affaire__c FROM Account LIMIT 1];
        System.assert(updatedAcc.Chiffre_d_affaire__c > 0, 'Revenue should be calculated');
    }
}