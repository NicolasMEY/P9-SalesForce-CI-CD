@isTest
public class TestUpdateAccounts {

    @testSetup
    static void setup() {
        Account acc = TestFactory.createAccount('Test Account');
        TestFactory.createOrderWithOrderItems(acc.Id, 150, 2, 'Activated', 5);
        TestFactory.createOrderWithOrderItems(acc.Id, 100, 1, 'Draft', 0);
    }

    @isTest
    static void testUpdateAccountRevenue() {
        // Ajout de TotalAmount dans la requête SOQL
        List<Order> orders = [SELECT Id, Status, AccountId, TotalAmount FROM Order WHERE Status = 'Activated'];
        
        Test.startTest();
        UpdateAccounts.UpdateAccountRevenue(orders);
        Test.stopTest();

        Account updatedAcc = [SELECT Chiffre_d_affaire__c FROM Account LIMIT 1];
        System.assert(updatedAcc.Chiffre_d_affaire__c > 0, 'Revenue should be updated');
    }
}