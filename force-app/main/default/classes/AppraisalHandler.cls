public class AppraisalHandler {
    
    //create appraisal record if resource is Active
    public static void createAppraisel(){
        list<Resource__c> reslist = [Select Id, Active__c From Resource__c Where Active__c = true];
        
        list<Appraisal__c> aplist = new list<Appraisal__c>();
        
        for(Resource__c rs : reslist){
            Appraisal__c ap = new Appraisal__c(
            	Resource__c = rs.Id,
                Status__c = 'Draft'
            );
            aplist.add(ap);
        }
        
        if(!aplist.isEmpty()){
            insert aplist;
        }
    }

}