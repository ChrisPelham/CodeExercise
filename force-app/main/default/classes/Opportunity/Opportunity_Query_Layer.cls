public with sharing class Opportunity_Query_Layer 
{
    public static List<Opportunity> GetChildOpportunities(List<Id> accountIds)
    {
        List<Opportunity> childOpps = [SELECT ID, IsClosed, Name, StageName FROM Opportunity WHERE AccountId IN :accountIds];
        
        return childOpps;
    }
}
