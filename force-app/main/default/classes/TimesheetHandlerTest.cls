@isTest
public class TimesheetHandlerTest {
    
         @testSetup
    static void setupData(){
        Opportunity op = new Opportunity(
            Name = 'Test op',
            StageName = 'Closed Won',
            CloseDate = Date.newInstance(2024, 1, 1)
        );
        
        insert op;
        
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
        
        Project__c proj = new Project__c(
            Name = 'Test Project',
            Start_Date__c = Date.today(),
            End_Date__c = Date.today().addDays(4), // 5 days
            Billing_Per_Hour__c = 90,
            Opportunity__c = op.Id
        );
        insert proj;
    }
    
    @isTest
    static void testTSScheduler(){
        
        Resource__c res = [SELECT Id, Active__c FROM Resource__c LIMIT 1];
        Project__c proj = [SELECT Id FROM Project__c LIMIT 1];
        
        Test.startTest();
        
        String cronExp = '0 0 0 ? * 1';
        System.schedule('Test Job', cronExp, new TimesheetScheduler());
        
        Test.stopTest(); // runs scheduler + queueable
        
        Timesheet__c tsList = [SELECT Id, Resource__c FROM Timesheet__c];
        
        System.assertEquals(res.Id, tsList.Resource__c);
    } 
        
    
}