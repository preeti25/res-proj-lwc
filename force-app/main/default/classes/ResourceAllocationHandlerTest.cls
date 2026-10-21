@isTest
public class ResourceAllocationHandlerTest {
    
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
    static void testCalculation() {
        
        Resource__c res = [SELECT Id FROM Resource__c LIMIT 1];
        Project__c proj = [SELECT Id FROM Project__c LIMIT 1];
        
        Resource_Allocation__c ra = new Resource_Allocation__c(
            Project__c = proj.Id,
            Resource__c = res.Id
        );
        
        Test.startTest();
        insert ra;
        system.debug(ra);
        Test.stopTest();
        
        Project__c updatedProj = [
            SELECT Estimate_Revenue__c, Estimate_Cost__c, Start_Date__c, End_Date__c
            FROM Project__c
            WHERE Id = :proj.Id
        ];
        
        //System.debug('Estimate_Revenue__c: ' + updatedProj.Estimate_Revenue__c);
		//System.debug('Estimate_Cost__c: ' + updatedProj.Estimate_Cost__c);
        
        // 👉 HERE (after data is ready)
    Integer hours = ResourceAllocationHandler.calculateWorkingDays(
        updatedProj.Start_Date__c,
        updatedProj.End_Date__c
    );
        
        //system.debug(hours);
    
      System.assertEquals(3, hours);
        
        // 5 working days → 40 hours
        System.assertEquals(24000, updatedProj.Estimate_Revenue__c);
        System.assertEquals(24000, updatedProj.Estimate_Cost__c);
    }

}