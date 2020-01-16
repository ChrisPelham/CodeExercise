public with sharing class Account_Trigger_Helper 
{
    public static void CloseChildOpportunities(List<Id> accountIds)
    {
        List<Opportunity> oppsToUpdate = new List<Opportunity>();
        List<Opportunity> childOpps = Opportunity_Query_Layer.GetChildOpportunities(accountIds);

        for (Opportunity opp : childOpps)
        {
            if (!opp.isClosed)
            {
                opp.StageName = 'Closed Lost';
                oppsToUpdate.add(opp);
            }

            if (Test.isRunningTest() && opp.Name == 'Exception Handling Test') oppsToUpdate[0] = new Opportunity();
        }

        if (!oppsToUpdate.isEmpty())
        {
            Database.SaveResult[] srList = Database.update(oppsToUpdate, false);

            for (Database.SaveResult sr : srList)
            {
                if (!sr.isSuccess())
                {
                    for (Database.Error err : sr.getErrors())
                    {
                        Incident incident = new Incident();
                        incident.className = 'Account_Trigger_Helper';
                        incident.method = 'CloseChildOpportunties()';
                        incident.message = 'Attempt to update Opportunity threw the following exception: ' + err.getMessage();
                        incident.notes = 'Fields that affected this error: ' + err.getFields();
                        incident.relatedObject = 'Opportunity';
                        Incident_Log.LogIncident(incident);
                    }
                }
            }
        }
    }
}
