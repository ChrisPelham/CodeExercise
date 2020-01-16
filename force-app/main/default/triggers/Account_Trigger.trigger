trigger Account_Trigger on Account (before update, before insert, before delete, after update, after insert, after delete) 
{
    if (Trigger.isBefore)
    {
        if (Trigger_Recursion_Utility.FirstAccountTrigger_Before())
        {
            if (Trigger.isInsert){}
            if (Trigger.isUpdate){}
            if (Trigger.isDelete){}
        }
    }
    else 
    {
        if (Trigger_Recursion_Utility.FirstAccountTrigger_After())
        {
            if (Trigger.isUpdate) 
            {
                Account_Trigger_Utility.afterUpdate(Trigger.oldMap, Trigger.newMap);
            }
            
            if (Trigger.isInsert){}
            if (Trigger.isDelete){}
        }    
    }

}