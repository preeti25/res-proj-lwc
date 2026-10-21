@isTest
public class FeedbackHandlerTest {
    
    @testSetup
    static void setupData() {
        Resource__c res = new Resource__c(
            First_Name__c = 'Resource',
            Last_Name__c = 'Resource',
            Email__c = 'test@gmail.com',
            Phone__c = '123456',
            Address__c = 'wreew',
            Date_of_Birth__c = Date.newInstance(2024, 1, 1),
            Cost_Per_Hour__c = 20,
            Role__c = 'Developer',
            Technology__c = 'Mulesoft',
            Sub_Technology__c = 'SOAP Integration',
            Day_Start_Time__c = Time.newInstance(10, 30, 0, 0),
            Day_End_Time__c = Time.newInstance(10, 30, 0, 0),
            Working_Days__c = 'Monday',
            Timezone__c = 'IST',
            Work_Location__c = 'Office'
        );
        insert res;
    }
    
    @isTest
    static void testfeedbackcreation(){
          Resource__c res = [select Id from Resource__c limit 1];
        
        V2MOM__c v2 = new V2MOM__c(
            Resource__c = res.Id,
            Year__c = '2026',
            Manager_Email__c = 'test@mail.com'
        );
        
        Test.startTest();
        insert v2;
        Test.stopTest();
        
        list<Feedback__c> fb = [select Id, Reviewer__c, V2MOM__c, Rating__c, Year__c from Feedback__c where V2MOM__c = :v2.Id ];
        
        system.debug(fb);
    }

}