@isTest
public with sharing class Opportunity_Query_Layer_Tests 
{
    @TestSetup
    static void makeData()
    {
        Test.startTest();
        Test_Data_Factory.InitializeDataFactory();
        Test.stopTest();
    }

    @isTest static void test_Positive_GetChildOpportunities()
    {
        List<Id> accountIds = new List<Id>();
        List<Opportunity> childOpportunities = new List<Opportunity>();
        for (Account acc : [SELECT ID FROM Account WHERE Name = 'Test Account'])
        {
            accountIds.add(acc.Id);
        }
        
        Test.startTest();
        childOpportunities = Opportunity_Query_Layer.GetChildOpportunities(accountIds);
        Test.stopTest();

        List<Opportunity> results = [SELECT ID, IsClosed, Name, StageName FROM Opportunity WHERE AccountId IN :accountIds];
        System.assertEquals(childOpportunities, results);
    }

    @isTest static void test_Negative_GetChildOpportunities()
    {
        List<Opportunity> childOpportunities = new List<Opportunity>();

        Account acc = new Account();
        acc.Name = 'Negative Test Account';
        acc.Status__c = 'Active';
        insert acc;
        
        Test.startTest();
        childOpportunities = Opportunity_Query_Layer.GetChildOpportunities(new List<Id>{acc.Id});
        Test.stopTest();
        
        System.assert(childOpportunities.isEmpty());
    }
}
