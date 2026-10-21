public class ProjectNotificationHandler {
    
    public static void sendEmailtoProjectManager(){
        
        date todayDate = Date.today();
        
        list<Project__c> prlist = [select Id, Name, End_Date__c, Project_Manager__r.Email__c from Project__c];
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        for(Project__c pr : prlist){
            date oneweekbeforedate = pr.End_Date__c.addDays(-7);
            if(oneweekbeforedate == todayDate){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                
                //mail.setToAddresses(new String[] {pr.Project_Manager__r.Email__c});
                mail.setToAddresses(new String[] {'pre.sharma00293@gmail.com'}); 
                mail.setSubject('Project Ending Soon: ' + pr.Name);
                mail.setPlainTextBody(
                    'Your project "' + pr.Name + '" is ending in one week.\n\n' +
                    'Your Project End Date is '+ pr.End_Date__c + '\n\n'+
                    'If there is no extension, no action is needed.\n' +
                    'If extension is required, please update the project.'
                );
                
                emails.add(mail);
            }
        }
        
        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
    }
    
    public static void updateprojectstatusafterenddatepassed(){
        date todayDate = Date.today();
        
        list<Project__c> prlist = [select Id, Name, End_Date__c, Status__c, Project_Manager__r.Email__c from Project__c];
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        for(Project__c pr : prlist){
            date afteroneweek = pr.End_Date__c.addDays(7);
            
            if(todayDate == afteroneweek){
                pr.Status__c = 'Completed';
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                
                mail.setToAddresses(new String[] {'pre.sharma00293@gmail.com'}); 
                mail.setSubject(pr.Name + ' Status is Changed to Completed: ');
                mail.setPlainTextBody(
                    'Your project "' + pr.Name + '" has been ended on "' + pr.End_Date__c +'".\n\n' +
                    'And the status is changed to Completed'
                );
                
                emails.add(mail);
            }
        }
        
        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
        
        update prlist;
    }

}