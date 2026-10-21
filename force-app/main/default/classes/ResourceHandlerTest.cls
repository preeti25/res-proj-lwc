@isTest
public class ResourceHandlerTest {
    
    @isTest
    static void createtestdata(){
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
        
        Test.startTest();
        insert res;
        Test.stopTest();
        
        list<V2MOM__c> v2 = [select Id, Resource__c from V2MOM__c where Resource__c = :res.Id]; 
        list<Appraisal__c> ap = [select Id, Resource__c from Appraisal__c where Resource__c = :res.Id]; 
        
        system.assertEquals(res.Id, v2[0].Resource__c);
        system.assertEquals(res.Id, ap[0].Resource__c);
    }

}