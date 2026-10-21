public class ResourceAllocationHandler {
    
    public static void calculaterevenueandcostonProject(list<Resource_Allocation__c> resalolist){
        
        set<Id> projIds = new set<Id>();
        Set<Id> resourceIds = new Set<Id>();
        
        for(Resource_Allocation__c resal : resalolist){
            projIds.add(resal.Project__c );
            resourceIds.add(resal.Resource__c);
        }
        
        //create a project map
        map<id, Project__c> projmap = new map<Id, Project__c>(
        [Select Id, Estimate_Revenue__c, Estimate_Cost__c, Start_Date__c, End_Date__c From Project__c Where Id IN : projIds]
        );
        
        //create a resource map
        map<Id, Resource__c> resmap = new map<Id, Resource__c>(
        [Select Id, Cost_Per_Hour__c From Resource__c Where Id IN : resourceIds]
        );
        
        list<Project__c> projecttoUpdate = new list<Project__c>();
        
        for(Resource_Allocation__c resal : resalolist){
            Project__c projData = projmap.get(resal.Project__c);
            Resource__c resData = resmap.get(resal.Resource__c);
            
            Integer workingDays = calculateWorkingDays(projData.Start_Date__c, projData.End_Date__c);
            
            Decimal hours = 8 * workingDays;
            
            decimal bill_rate = resal.Cost_Per_Hour__c != null ? resal.Cost_Per_Hour__c : 0;
            decimal cost_per_hour = resData.Cost_Per_Hour__c != null ? resData.Cost_Per_Hour__c : 0;
            
            projData.Estimate_Revenue__c = bill_rate * hours;
            projData.Estimate_Cost__c = cost_per_hour * hours;
            
            projecttoUpdate.add(projData);
            
        }
        
        if(!projecttoUpdate.isEmpty()){
            update projecttoUpdate;
        }
        
        
    }
    
    // Working days logic (same)
    public static Integer calculateWorkingDays(Date startDate, Date endDate) {
    
    Integer count = 0;
    
    for (Date d = startDate; d <= endDate; d = d.addDays(1)) {
        
        DateTime dt = DateTime.newInstance(d.year(), d.month(), d.day());
        String dayName = dt.format('E');
        
        if (dayName != 'Sat' && dayName != 'Sun') {
            count++;
        }
    }
    
    return count;
}
    
    
    //before creating resource allocation check some points
    public static void checkpointsbeforecreate(list<Resource_Allocation__c> rsallolist){
        
        set<Id> resId = new set<Id>();
        
        for(Resource_Allocation__c ra : rsallolist){
            resId.add(ra.Resource__c);
        }
        
        list<Project__c> relproj = [select Id, Project_Manager__c from Project__c where Project_Manager__c IN : resId];
        
        map<Id, Resource__c> resData = new map<Id, Resource__c>([select Id, Active__c, Cost_Per_Hour__c from Resource__c where Id IN : resId]);
        
        for(Resource_Allocation__c ra : rsallolist){
            Resource__c res = resData.get(ra.Resource__c);
            
            if(relproj != null && !relproj.isEmpty()){ 
                ra.addError('Resource is tagged in other project');
            }
            else if(res.Active__c == false){
                ra.addError('Resource should be active');
            } 
            else if(res.Cost_Per_Hour__c == null){
                ra.addError('Resource cost per hour should not be null');
            }
        }
    }

}