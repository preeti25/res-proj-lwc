public class FeedbackHandler {
    
    public static void createFeedbackRecord(list<V2MOM__c> vmomlist){
        
        list<Feedback__c> insertnewfeed = new list<Feedback__c>();
        for(V2MOM__c v2 : vmomlist){
            system.debug(v2.Resource__c);
            
            Feedback__c fb1 = new Feedback__c(
            	V2MOM__c = v2.Id,
                Reviewer__c = v2.Resource__c,
                Rating__c = 4,
                Year__c = '2026'
            );

			Feedback__c fb2 = new Feedback__c(
            	V2MOM__c = v2.Id,
                Reviewer__c = v2.Resource__c,
                Rating__c = 5,
                Year__c = '2027'
            );
            
            insertnewfeed.add(fb1);
            insertnewfeed.add(fb2);
            
        }
        
        insert insertnewfeed;
        
    }

}