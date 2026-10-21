public class OpportunityHandler {
    
    //create project record if opportunity is closed
    public static void createprojectonOpportunityClose(list<Opportunity> opplist){
        
        Resource__c res = [SELECT Id FROM Resource__c LIMIT 1];
        
        Id resID;
        resID = res.Id;
        
        list<Project__c> projectToInsert = new list<Project__c>();
        
        for(Opportunity op : opplist){
            if(op.IsClosed == true){
                Project__c proj = new Project__c();
                
                proj.Name = op.Name;
                proj.Project_Amount__c  = op.Amount;
                proj.Status__c = 'New';
                proj.Start_Date__c = op.CloseDate;
                proj.Opportunity__c = op.Id;
                proj.End_Date__c = Date.today();
                proj.Billing_Per_Hour__c = 1000;
                proj.Project_Manager__c = resID;
                
                projectToInsert.add(proj);
            }
        }
        
        if(!projectToInsert.isEmpty()){
        	insert projectToInsert;
        }
    }

}