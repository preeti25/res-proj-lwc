public class ResourceHandler {
    
    public static void createappraisalandv2momRecord(list<Resource__c> reslist){
        
        list<V2MOM__c> insertv2 = new list<V2MOM__c>();
        list<Appraisal__c > insertApp = new list<Appraisal__c >();
        
        for(Resource__c res : reslist){
            V2MOM__c v2 = new V2MOM__c(
            	Resource__c = res.Id,
                Year__c = '2027',
                Status__c = 'New',
                Manager_Email__c = 'v2mom@mail.com'
            );
            
            Appraisal__c ap = new Appraisal__c(
            	Resource__c = res.Id,
                Status__c = 'Draft'
            );
            
            insertv2.add(v2);
            insertApp.add(ap);
        }
        
        insert insertv2;
        insert insertApp;
        
    }

}