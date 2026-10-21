public class ProjectHandler {
    
    public static void calculateRevenueCost(list<Project__c> projlist){
        
        for(Project__c proj : projlist){
            proj.Estimate_Revenue__c = proj.Billing_Per_Hour__c * proj.Estimate_Hours__c;
            proj.Actual_Revenue__c = proj.Billing_Per_Hour__c * proj.Actual_Hours__c ;
            proj.Estimate_Cost__c = proj.Cost_Per_Hour__c * proj.Estimate_Hours__c ;
            proj.Actual_Cost__c = proj.Cost_Per_Hour__c * proj.Actual_Hours__c;
        }
    }
    
    public static void calculateRevenueandCost(list<Timesheet__c> timelist){
        
        set<Id> projIds = new set<Id>();
        set<Id> resIds = new set<Id>();
        
        for(Timesheet__c tm : timelist){
            projIds.add(tm.Project__c);
            resIds.add(tm.Resource__c);
        }
        
        map<Id, Project__c> projmap = new map<Id, Project__c>(
        [select Id, Actual_Revenue__c, Actual_Cost__c, Total_Billable_Hours__c from Project__c where Id IN : projIds]
        );
        
        map<Id, Resource__c> resmap = new map<Id, Resource__c>(
        [select Id, Cost_Per_Hour__c from Resource__c where Id IN : resIds]
        );
        
        list<Project__c> projtoUpdate = new list<Project__c>();
        
        for(Timesheet__c tm : timelist){
            
            // ✅ CONDITION ADDED
        if(tm.Status__c != 'Approved'){
            continue;
        }
            
            Project__c projData = projmap.get(tm.Project__c);
            Resource__c resData = resmap.get(tm.Resource__c);
            
            decimal billable_hours = projData.Total_Billable_Hours__c != null ? projData.Total_Billable_Hours__c : 0;
            decimal costper_hour = resData.Cost_Per_Hour__c != null ? resData.Cost_Per_Hour__c : 0;
            
            projData.Actual_Revenue__c = billable_hours * costper_hour;
            projData.Actual_Cost__c = billable_hours * costper_hour;
            
            projtoUpdate.add(projData);
        }
        
        //system.debug(projtoUpdate);
        
        update projtoUpdate;
    }

}