@isTest
public class AppraisalSchedulerTest {
    
    @testSetup
    static void setupData(){
        
        Resource__c res = new Resource__c(
            First_Name__c = 'Resource',
            Last_Name__c = 'Resource',
            Email__c = 'test@gmail.com',
            Phone__c = '123456',
            Address__c = 'wreew',
            Date_of_Birth__c = Date.newInstance(2024, 1, 1),
            Cost_Per_Hour__c = 1000,
            Role__c = 'Developer',
            Technology__c = 'Mulesoft',
            Sub_Technology__c = 'SOAP Integration',
            Day_Start_Time__c = Time.newInstance(10, 30, 0, 0),
            Day_End_Time__c = Time.newInstance(10, 30, 0, 0),
            Working_Days__c = 'Monday',
            Timezone__c = 'IST',
            Work_Location__c = 'Office',
            Active__c = true
        );
        insert res;
       
    }
    
    @isTest
    static void testScheduler(){
        Resource__c res = [SELECT Id FROM Resource__c LIMIT 1];
        
        Test.startTest();
        
        String cronExp = '0 0 0 1 7 ?';
        System.schedule('Test Job', cronExp, new AppraisalScheduler());
        
        Test.stopTest(); // executes scheduled job
        
        Appraisal__c appList = [SELECT Id, Resource__c FROM Appraisal__c];
        
        System.assertEquals(res.Id, appList.Resource__c);
    }

}