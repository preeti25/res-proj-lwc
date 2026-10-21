@isTest
public class ProjectHandlerTest {

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
            Work_Location__c = 'Office'
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
    static void calculation_test(){
        Resource__c res = [SELECT Id, Cost_Per_Hour__c FROM Resource__c LIMIT 1];
        //Project__c proj = [SELECT Id, Total_Billable_Hours__c FROM Project__c LIMIT 1];
        Project__c proj = [SELECT Id FROM Project__c LIMIT 1];
        
        Timesheet__c tm = new Timesheet__c(
            Project__c = proj.Id,
            Resource__c = res.Id,
            Timesheet_Name__c = 'test timesheet',
            Week_Start_Date__c = Date.today(),
            Total_Hours__c = 10,
            Total_Billable_Hours__c = 10,
            Manager_s_Email__c = 'test@mail.com',
            Status__c = 'New'
        );
        
        insert tm;
        
        Test.startTest();
        tm.Status__c = 'Approved';
        update tm;
        Test.stopTest();
        
        // Fetch updated Project
        Project__c updatedProj = [
            SELECT Actual_Revenue__c, Actual_Cost__c, Total_Billable_Hours__c
            FROM Project__c
            WHERE Id = :proj.Id
        ];
        
        // Expected calculations
        Decimal expectedRevenue = tm.Total_Billable_Hours__c * res.Cost_Per_Hour__c;
        Decimal expectedCost = tm.Total_Billable_Hours__c * res.Cost_Per_Hour__c;
        
        //system.debug(updatedProj);
        
        // Assertions
        System.assertEquals(expectedRevenue, updatedProj.Actual_Revenue__c, 'Revenue calculation failed');
        System.assertEquals(expectedCost, updatedProj.Actual_Cost__c, 'Cost calculation failed');
    }
}