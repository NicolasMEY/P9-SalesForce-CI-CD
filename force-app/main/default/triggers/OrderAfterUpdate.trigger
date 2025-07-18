trigger OrderAfterUpdate on Order (after update) {
UpdateAccounts.UpdateAccountRevenue(Trigger.new);
}