global class MyBatchClass implements Database.Batchable<SObject>{
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        
        // 1 year ago (DateTime)
        DateTime oneYearAgo = System.now().addYears(-1);
        
        return Database.getQueryLocator([
            SELECT Id, Manager_s_Email__c, Project__c, Resource__c, Status__c, Timesheet_Name__c, Total_Billable_Hours__c,
            Total_Hours__c, Week_Start_Date__c, Work_Description__c
            FROM Timesheet__c
            WHERE CreatedDate < :oneYearAgo LIMIT 200
        ]);
    }
    
    
     global void execute(Database.BatchableContext bc, List<Timesheet__c> scope) {
        
        List<Timesheet_Backup__c> backupList = new List<Timesheet_Backup__c>();
        
        for(Timesheet__c ts : scope){
            
            Timesheet_Backup__c backup = new Timesheet_Backup__c();
            
            backup.Timesheet_Name__c = ts.Timesheet_Name__c ;
            backup.Resource__c = ts.Resource__c;
            backup.Week_Start_Date__c = ts.Week_Start_Date__c;
            backup.Status__c = ts.Status__c;
            backup.Project__c = ts.Project__c;
            backup.Manager_s_Email__c = ts.Manager_s_Email__c;
            backup.Total_Billable_Hours__c = ts.Total_Billable_Hours__c;
            backup.Total_Hours__c = ts.Total_Hours__c;
            backup.Work_Description__c = ts.Work_Description__c;
            
            backupList.add(backup);
        }
        
        // Step 1: Backup
        if(!backupList.isEmpty()){
            insert backupList;
        }
        
        // Step 2: Delete original records
        if(!scope.isEmpty()){
            delete scope;
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        System.debug('Old timesheets backed up and deleted successfully');
    }

}