@isTest
public with sharing class Trigger_Recursion_Utility_Tests 
{
    @TestSetup
    static void makeData()
    {
        Test.startTest();
        Test_Data_Factory.InitializeDataFactory();
        Test.stopTest();
    }

    @isTest static void test_Positive_FirstAccountTrigger_After() {
        Account acc = [SELECT ID FROM Account WHERE Name = 'Test Account'];
        acc.Status__c = 'Closed';

        Test.startTest();
        update acc;
        Test.stopTest();

        Opportunity result = [SELECT ID, StageName FROM Opportunity WHERE AccountId = :acc.Id];
        System.assertEquals('Closed Lost', result.StageName);
    }

    @isTest static void test_Negative_FirstAccountTrigger_After() 
    {
        Trigger_Recursion_Utility.firstAccountTrigger_After = false;

        Account acc = [SELECT ID FROM Account WHERE Name = 'Test Account'];
        acc.Status__c = 'Closed';

        Test.startTest();
        update acc;
        Test.stopTest();

        Opportunity result = [SELECT ID, StageName FROM Opportunity WHERE AccountId = :acc.Id];
        System.assertNotEquals('Closed Lost', result.StageName);
    }

    @isTest static void test_Positive_FirstAccountTrigger_Before()
    {
        Boolean result = Trigger_Recursion_Utility.FirstAccountTrigger_Before();
        System.assert(result);
    }

    @isTest static void test_Negative_FirstAccountTrigger_Before()
    {
        Trigger_Recursion_Utility.firstAccountTrigger_Before = false;

        Boolean result = Trigger_Recursion_Utility.FirstAccountTrigger_Before();
        System.assertEquals(false, result);
    }
}
