public with sharing class Trigger_Recursion_Utility 
{
    public static Boolean firstAccountTrigger_After = true;
    public static Boolean firstAccountTrigger_Before = true;

	public static Boolean FirstAccountTrigger_Before() 
    {
		if(firstAccountTrigger_Before) 
        {
			firstAccountTrigger_Before = false;
			return true;
		} 
        else 
        {
			return firstAccountTrigger_Before;
		}
    }
    
    public static Boolean FirstAccountTrigger_After() 
    {
        if(firstAccountTrigger_After) 
        {
			firstAccountTrigger_After = false;
            return true;
        } 
        else 
        {
            return firstAccountTrigger_After;
        }
    }
}
