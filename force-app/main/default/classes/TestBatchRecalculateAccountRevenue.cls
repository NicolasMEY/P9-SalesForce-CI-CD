@isTest
public class TestBatchRecalculateAccountRevenue {

    @testSetup
    static void setup() {
        Account acc = TestFactory.createAccount('Batch Test Account');
        // Ajout du shipmentCost (par exemple 10)
        TestFactory.createOrderWithOrderItems(acc.Id, 250, 1, 'Activated', 10);
        TestFactory.createOrderWithOrderItems(acc.Id, 300, 2, 'Activated', 15);
    }

    @isTest
    static void testBatch() {
        Test.startTest();
        Database.executeBatch(new BatchRecalculateAccountRevenue());
        Test.stopTest();

        Account updatedAcc = [SELECT Chiffre_d_affaire__c FROM Account LIMIT 1];
        System.assert(updatedAcc.Chiffre_d_affaire__c > 0, 'Batch should update account revenue');
    }
}