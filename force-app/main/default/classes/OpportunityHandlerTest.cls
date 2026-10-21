@isTest
public class OpportunityHandlerTest {
    
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
    static void testProjectCreation() {
        
        // Step 1: Create required Resource (VERY IMPORTANT)
        Resource__c res = [SELECT Id FROM Resource__c LIMIT 1];
        
        // Step 2: Create Opportunity
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            Amount = 5000
        );
        insert opp;
        
        // Step 3: Update Opportunity → Trigger fires
        Test.startTest();
        opp.StageName = 'Closed Won';
        update opp;
        Test.stopTest();
        
        // Step 4: Verify Project created
        List<Project__c> projList = [
            SELECT Id, Name, Opportunity__c, Project_Manager__c
            FROM Project__c
            WHERE Opportunity__c = :opp.Id
        ];
        
        System.assertEquals(1, projList.size(), 'Project should be created');
        System.assertEquals('Test Opportunity', projList[0].Name);
        
    }

}