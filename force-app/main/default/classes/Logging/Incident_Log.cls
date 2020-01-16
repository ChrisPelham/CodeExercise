public with sharing class Incident_Log 
{
    public static void LogIncident(Incident log)
    {
        Incident__c logEntry= new Incident__c();
        logEntry.ClassName__c = log.className;
        logEntry.Method__c = log.method;
        logEntry.Message__c = log.message;
        logEntry.Notes__c = log.notes;
        logEntry.RelatedObject__c = log.relatedObject;
        logEntry.TimeOfIncident__c = System.now();
        
        try
        {
            if (Test.isRunningTest() && logEntry.Message__c == 'TEST DML EXCEPTION') 
            {
                throw new DMLException();
            }
            
            Database.SaveResult sr = Database.insert(logEntry);
        }
        catch (Exception ex)
        {
            Incident incident = new Incident();
            incident.className = 'Incident_Log';
            incident.method = 'LogIncident()';
            incident.message = 'Attempt to insert Incident Log Entry threw the following exception: ' + ex.getMessage();
            incident.relatedObject = 'Incident__c';
            Incident_Log.LogIncident(incident);
        }
    }
}
