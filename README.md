# Chris Pelham Code Exercise Submission

Build out a trigger on account updates to make a change to all of their child opportunities.

## Solution

When the Status of an account is changed to 'Closed' update the Stage of all open child Opportunities to 'Closed Lost'.

## Classes Created

### Account Trigger Classes
The Account trigger itself has no logic, other than ensuring that the trigger is not recursive. It simply passes the record to the applicable utility method based on the trigger type. 

The utility method then iterates through the Account records, compiling a list of Account ids that meet the specified criteria (Account status changed to 'Closed'). The utility method then calls the helper method, passing the list of Account ids.

The helper method takes the list of Account ids and queries for all child Opportunities, updating the Stage Name of all open Opportunities to 'Closed Lost'.  

* [triggers/Account_Trigger.trigger](/force-app/main/default/triggers/Account_Trigger.trigger)
* [classes/Account/Account_Trigger_Utility.cls](/force-app/main/default/classes/Account/Account_Trigger_Utility.cls)
* [classes/Account/Account_Trigger_Helper.cls](/force-app/main/default/classes/Account/Account_Trigger_Helper.cls) 

### Helper Classes
The Trigger Recursion Utility provides a static variable that can be checked from each object's before and after triggers preventing recursive triggers.

* [classes/Helpers/Trigger_Recursion_Utility.cls](/force-app/main/default/classes/Helpers/Trigger_Recursion_Utility.cls)

### Logging Classes

Creating a custom logging object allows the tracking of all exceptions that occur in the Apex code. It provides a means for reporting, dashboards, metrics and the ability to link to an external incident response solution.

* [classes/Logging/Incident_Log.cls](/force-app/main/default/classes/Logging/Incident_Log.cls)
* [classes/Logging/Incident.cls](/force-app/main/default/classes/Logging/Incident.cls)

### Opportunity Classes
The Opportunity Query Layer class contains all common Opportunity specific SOQL queries, allowing for the reuse of the code by multiple methods.

* [classes/Opportunity/Opportunity_Query_Layer.cls](/force-app/main/default/classes/Opportunity/Opportunity_Query_Layer.cls)

### Test Classes
The following test classes ensure 100% code coverage across all classes. The Test Data Factory contains all common test setup data, allowing for the reuse of test setup data by all test classes.

* [classes/Account/Account_Trigger_Tests.cls](/force-app/main/default/classes/Account/Account_Trigger_Tests.cls) 
* [classes/Helpers/Test_Data_Factory.cls](/force-app/main/default/classes/Helpers/Test_Data_Factory.cls)
* [classes/Helpers/Trigger_Recursion_Utility_Tests.cls](/force-app/main/default/classes/Helpers/Trigger_Recursion_Utility_Tests.cls)
* [classes/Logging/Incident_Log_Tests.cls](/force-app/main/default/classes/Logging/Incident_Log_Tests.cls)
* [classes/Opportunity/Opportunity_Query_Layer_Tests.cls](/force-app/main/default/classes/Opportunity/Opportunity_Query_Layer_Tests.cls)

## Metadata Changes

* Added Status__c picklist field on Account object (Active, Suspended, Closed)
* Created Incident__c Custom Object used to store a log of exceptions encountered in the Apex code.
  * ClassName__c - Text
  * Message__c - Text Area
  * Method__c - Text
  * Notes__c - Text Area
  * RelatedObject__c - Text
  * TimeOfIncident__c - Date/Time

[Back to Top](#top-menu)
