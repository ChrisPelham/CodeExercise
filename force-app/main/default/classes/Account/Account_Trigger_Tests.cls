@isTest
public with sharing class Account_Trigger_Tests 
{
    @TestSetup
    static void makeData()
    {
        Test.startTest();
        Test_Data_Factory.InitializeDataFactory();
        Test.stopTest();
    }

    @isTest static void test_Positive_AfterUpdate() {
        Account acc = [SELECT ID FROM Account WHERE Name = 'Test Account'];
        acc.Status__c = 'Closed';

        Test.startTest();
        update acc;
        Test.stopTest();

        Opportunity result = [SELECT ID, StageName FROM Opportunity WHERE AccountId = :acc.Id];
        System.assertEquals('Closed Lost', result.StageName);
    }

    @isTest static void test_Negative_AfterUpdate() 
    {
        Account acc = [SELECT ID FROM Account WHERE Name = 'Test Account'];
        acc.Status__c = 'Suspended';

        Test.startTest();
        update acc;
        Test.stopTest();

        Opportunity result = [SELECT ID, StageName FROM Opportunity WHERE AccountId = :acc.Id];
        System.assertNotEquals('Closed Lost', result.StageName);
    }

    @isTest static void test_Exception_CloseChildOpportunities() 
    {
        Account acc = [SELECT ID FROM Account WHERE Name = 'Test Account'];
        Opportunity o = [SELECT ID FROM Opportunity WHERE AccountId = :acc.Id];
        o.Name = 'Exception Handling Test';
        update o;

        Test.startTest();
        Account_Trigger_Helper.CloseChildOpportunities(New List<Id>{acc.Id});
        Test.stopTest();

        List<Incident__c> results = [SELECT Id FROM Incident__c WHERE ClassName__c = 'Account_Trigger_Helper' AND Method__c = 'CloseChildOpportunties()' AND TimeOfIncident__c > :System.now().addMinutes(-1)]; System.assert(!results.isEmpty()); 
        System.assert(!results.isEmpty());
    }
}
