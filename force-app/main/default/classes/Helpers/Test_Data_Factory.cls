@isTest
global with sharing class Test_Data_Factory {
    
    global static void InitializeDataFactory()
    {
        Account a = new Account();
        a.Name = 'Test Account';
        a.Status__c = 'Active';
        insert a;  

        Opportunity o = new Opportunity();
        o.Name = 'Test Opportunity';
        o.AccountId = a.Id;
        o.StageName = 'Proposal/Price Quote';
        o.CloseDate = Date.Today().addDays(7);
        insert o;
    }
}
