public class TimesheetHandler {
    
    //create timesheet record for active resource
    public static void createTimesheet(){
        list<Resource__c> rslist = [select Id, Active__c from Resource__c where Active__c = true];
        Project__c pr = [select Id from Project__c limit 1];
        
        list<Timesheet__c> insertTS = new list<Timesheet__c>();
        
        for(Resource__c rs : rslist){ 
            Timesheet__c ts = new Timesheet__c(
            	Timesheet_Name__c = 'Scheduler timesheet',
                Resource__c = rs.Id,
                Status__c = 'New',
                Week_Start_Date__c = Date.today(),
                Total_Hours__c = 50,
                Total_Billable_Hours__c = 40,
                Manager_s_Email__c = 'scheduler@mail.com',
                Project__c = pr.Id
            );
            
            insertTS.add(ts);
        }
        
        if(!insertTS.isEmpty()){
            insert insertTS;
        }
    }

}