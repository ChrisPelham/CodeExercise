@isTest
public with sharing class Incident_Log_Tests 
{
    @isTest static void test_Positive_LogIncident()
    {
        Incident incident = new Incident();
        incident.className = 'Test_Class';
        incident.method = 'TestMethod()';
        incident.message = 'Attempt to insert Test Object threw the following exception: Test Exception';
        incident.relatedObject = 'Test Object';

        Test.startTest();
        Incident_Log.LogIncident(incident);
        Test.stopTest();

        List<Incident__c> results = [SELECT Id FROM Incident__c WHERE ClassName__c = :incident.className AND Method__c = :incident.method AND TimeOfIncident__c > :System.now().addMinutes(-1)]; System.assert(!results.isEmpty()); 
        System.assert(!results.isEmpty());
    } 
    
    @isTest static void test_Exception_LogIncident()
    {
        Incident incident = new Incident();
        incident.className = 'Test_Class';
        incident.method = 'TestMethod()';
        incident.message = 'TEST DML EXCEPTION';
        incident.relatedObject = 'Test Object';

        Test.startTest();
        Incident_Log.LogIncident(incident);
        Test.stopTest();

        List<Incident__c> results = [SELECT Id FROM Incident__c WHERE ClassName__c = 'Incident_Log' AND Method__c = 'LogIncident()' AND TimeOfIncident__c > :System.now().addMinutes(-1)];
        System.assert(!results.isEmpty()); 
    }      
}
