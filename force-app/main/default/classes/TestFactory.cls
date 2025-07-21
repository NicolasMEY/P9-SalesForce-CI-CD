@isTest
public class TestFactory {
    public static Account createAccount(String name) {
        Account acc = new Account(Name = name);
        insert acc;
        return acc;
    }

    public static PricebookEntry createProductWithPricebookEntry(String productName, Decimal unitPrice) {
        Product2 prod = new Product2(Name = productName, isActive = true);
        insert prod;
        PricebookEntry pbe = new PricebookEntry(
            Product2Id = prod.Id,
            Pricebook2Id = Test.getStandardPricebookId(),
            UnitPrice = unitPrice,
            isActive = true
        );
        insert pbe;
        return pbe;
    }

    public static Order createOrderWithOrderItems(Id accountId, Decimal unitPrice, Integer quantity, String status, Decimal shipmentCost) {
        Id standardPricebookId = Test.getStandardPricebookId();

        // Création de l'Order en Draft
        Order ord = new Order(
    AccountId = accountId,
    Status = 'Draft',
    EffectiveDate = Date.today(),
    ShipmentCost__c = shipmentCost,
    Pricebook2Id = standardPricebookId
);
insert ord;

PricebookEntry pbe = createProductWithPricebookEntry('Test Product', unitPrice);
OrderItem oi = new OrderItem(
    OrderId = ord.Id,
    PricebookEntryId = pbe.Id,
    Quantity = quantity,
    UnitPrice = unitPrice
);
insert oi;

// Maj du status à 'Activated'
ord.Status = 'Activated';
update ord;

return ord;
    }
}