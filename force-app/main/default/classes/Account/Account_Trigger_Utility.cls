public with sharing class Account_Trigger_Utility 
{

    public static void AfterUpdate(Map<Id, Account> oldMap, Map<Id, Account> newMap)
    {
        List<Id> updatedAccountIds = new List<Id>();

        for (Account acc : newMap.values())
        {
            if (acc.Status__c != oldMap.get(acc.Id).Status__c)
            {
                switch on acc.Status__c
                {
                    when 'Closed'
                    {
                        updatedAccountIds.add(acc.Id);
                    }
                }
            }
        }

        if (!updatedAccountIds.isEmpty()) Account_Trigger_Helper.CloseChildOpportunities(updatedAccountIds);
    }
}
