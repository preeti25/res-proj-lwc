public class EncoderAppsPracticeClass {
    
    
    public static void getAccountRecords(){
        list<Account> acclist = [Select Id, Name From Account limit 5];
        
        // point 1 for account Id Set
        set<Id> accIds = new set<Id>();
        
        for(Account ac : acclist){
            system.debug('Ac ID - '+ac.Id);
            accIds.add(ac.Id);
        }
        
        system.debug('Set of ID - '+accIds);
        
        
        // point 2 for Account Map
        
        Map<Id, Account> acmap = new Map<Id, Account>();
        
        for(Account ac : acclist){
   			acmap.put(ac.Id, ac);
        }
        
        system.debug('Map data - '+acmap);
        
        // pint 3 for Account map without using loop
        
        Map<Id, Account> acmap2 = new Map<Id, Account>(acclist);
        
        system.debug('Map data without loop - '+acmap2);
        
        //point 4th of account to iterate set of id and check into map
        
        for(Id acid : accIds){
            if(acmap2.containsKey(acid)){
                Account accRecord = acmap2.get(acid);
                system.debug('Matched Record - '+accRecord.Name);
            }
        }  
    }
    
    //5th point to get this/last week created account records
   
    public static void thisorlastweekAccountRecords(){
        list<Account> this_lastweekData = [select Id, Name from Account where CreatedDate = THIS_WEEK OR CreatedDate = LAST_WEEK];
        
        system.debug('Account record of this/last week - '+ this_lastweekData);
    }
    
    //6th point to get this/last week created Contact records
    public static void thisorlastweekContactRecords(){
        list<Contact> cntthis_lastweekData = [select Id, Name from Contact where CreatedDate = THIS_WEEK OR CreatedDate = LAST_WEEK];
        
        system.debug('Contact record of this/last week - '+cntthis_lastweekData);
    }
    
    //7th point query
    //select Id, Name, (select Id, Name from Contacts) from Account where CreatedDate = THIS_WEEK OR CreatedDate = LAST_WEEK

    //8th point query
    //select Id, Name, Account.Id, Account.Name, Account.Industry from Contact where CreatedDate = THIS_WEEK OR CreatedDate = LAST_WEEK
    
    
    //9th point query
    //select Id, Name, Phone, CreatedDate, (select Name, CloseDate, StageName from Opportunities) from Account where Phone != NULL order by CreatedDate DESC
    //select Id, Name, Phone, CreatedDate, (select Name, CloseDate, StageName from Opportunities) from Account where Phone != NULL order by CreatedDate ASC
    
    
    //10th point
    public static void getaccountwithcontacts(){
        List<Account> acnewlist = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Phone != NULL];
        
        for(Account ac : acnewlist){
            integer contCount = ac.Contacts.size();
            system.debug(ac.Name+' has '+contCount+ ' related contacts');
            //system.debug();
        }
    }
    
    //11th point
    public static void getaccountwithopp(){
        List<Account> accopplist = [SELECT Id, Name, (SELECT Id, Name, Amount FROM Opportunities) FROM Account WHERE Phone != NULL];
        
        for(Account ac : accopplist){
            decimal total_amount = 0;
            
            for(Opportunity op : ac.Opportunities){
                total_amount+=op.Amount;
            }
            system.debug(ac.Name+' has '+total_amount+' worth opprtunities');
        }
    }
    
    //12th point
    public static void insertrecordwith2ways(){
        Account ac1 = new Account(
        	Name = 'Test Account 1',
            Phone = '1234567'
        );
        insert ac1;
        
        Account ac2 = new Account(
        	Name = 'Test Account 2',
            Phone = '1234567'
        );
        insert ac2;
        
        
        //insert using list with single insert statement
        List<Account> aclist = new List<Account>();
           aclist.add(new Account(Name = 'insert with list1',
            Phone = '232424425'
           ));
        aclist.add(new Account(Name = 'insert with list2',
            Phone = '232424425'
           ));
        
        insert aclist;
    }
    
    //13th point
    public static void insertaccountrecordusingloop(){
        
        list<Account> aclist = new list<Account>();
        for(integer i=1; i<=5; i++){
           Account ac = new Account(
        	Name = 'Test loop Account '+i,
            Phone = '123456'
        );
            aclist.add(ac);
        }
        insert aclist;
    }
    
    //14th point
    public static void insertopportunityrecordusingloop(){
        list<Opportunity> oplist = new list<Opportunity>();
        for(integer i=1; i<=5; i++){
           Opportunity op = new Opportunity(
        	Name = 'Test loop Opportunity '+i,
            CloseDate = Date.today(),
            StageName = 'Prospecting'
        );
            oplist.add(op);
        }
        insert oplist;

    }
    
    
    //15th & 16th point
    public static void insertcontactwithaccount(){
        Account ac = new Account(
        	Name = 'Preeti Test Account 4',
            Phone = '1234567'
        );
        insert ac;
        
        Id acID = ac.Id;
        
        Contact cnt = new Contact(
        	FirstName = 'Preeti Test Account 4',
            LastName = 'Contact',
            AccountId = acID,
            Phone = '1234354657'
        );
        
        insert cnt;
        
        Opportunity op = new Opportunity(
        	Name = 'Test Account Opportunity 4',
            StageName = 'Prospecting',
            Amount = 10000,
            AccountId = acID,
            CloseDate = Date.today()
        );
        
        insert op;
        
    }
    
    //19th point - update account phone, if phone is blank
    public static void updateAccountRecord(){
        list<Account> aclist = [Select Id, Name, Phone From Account Where Phone = NULL];
        system.debug(aclist);
        
        for(Account ac : aclist){
           ac.Phone = '654321';
        }
        
        update aclist;
    }
    
    //20th point - update contact email if email is blank
    public static void updateContactRecord(){
        list<Contact> conlist = [Select Id, Name, Email From Contact Where Email = NULL];
        system.debug(conlist);
        
        for(Contact con : conlist){
           con.Email = 'test@test.com';
        }
        
        update conlist;
    }
    
    //21st point
    public static void accountquerywithemptyfield(){
        /*list<Account> aclist = [select Id, Name, Phone from Account where Phone = NULL];
        system.debug(aclist);
        
        for(Account ac : aclist){
            ac.Phone = '123456';
        }
        database.update(aclist,false);*/
        
        list<Account> newlist = new list<Account>();
        
        for(integer i = 1; i<=5; i++){
            Account acup = new Account();
            acup.Name = 'test account '+i;
            acup.External_Id__c = 'ACC-' + i;
            
            newlist.add(acup);
             
        }
        
        Database.upsert(newlist,false);
        
    }
    
    
    //22nd point
    public static void oppocreateandupdatemethod(){
        list<Opportunity> oplist = [select Id, Name, CreatedDate from Opportunity where CreatedDate = LAST_MONTH];
        
        for(Opportunity op : oplist){
            op.StageName = 'Closed Won';
        }
        
        update oplist;
        
        
        List<Opportunity> oppList = new List<Opportunity>();

for(Integer i = 1; i <= 5; i++){
    Opportunity opp = new Opportunity();
    opp.Name = 'Test Opportunity ' + i;
    opp.StageName = 'Prospecting';   // Required field
    opp.CloseDate = Date.today().addDays(30); // Required field
    opp.External_Id__c = 'ACC- '+i;

    oppList.add(opp);
}

// Upsert records
database.upsert(oppList,false);
    }
    
    //23rd point
    
    public static void deleteaccountrecordsbyphone(){
        list<Account> acclist = [select Id, Phone from Account where Phone = '123456'];
        system.debug(acclist);
        
        Database.delete(acclist,false);
        
        Database.emptyRecycleBin(acclist);
    }
    
    //25th point
    
    public static void deleteoppbystageandlastmonth(){
        list<Opportunity> oplist = [select Id, Name from Opportunity where StageName  = 'Closed Lost' AND CreatedDate = LAST_MONTH];
        system.debug(oplist);
        delete oplist;
    }
    
    //26th point
    public static void getaccountscreatedlastweek(){
        list<Account> aclist = [select Id, Name from Account where CreatedDate = LAST_WEEK];
        system.debug(aclist);
        
        list<Opportunity> oplist = new list<Opportunity>();
        
        for(Account ac : aclist){
            Opportunity op = new Opportunity();
            op.AccountId = ac.Id;
            op.Name = ac.Name+' Opportunity';
            op.Amount = 10000;
            op.StageName = 'Qualification';
            op.CloseDate = Date.today();
            
            oplist.add(op);
        }
        
        insert oplist;
    }
    
    //27th point
    public static void getlastsevendaysaccounts(){
        list<Account> aclist = [select Id, Name from Account where CreatedDate = LAST_N_DAYS:7];
        system.debug(aclist);
        
        for(Account ac : aclist){
            ac.Phone = '1234567890';
        }
        
        database.update(aclist,false);
    }
    
    //28th point
    public static void getopplastsevendaysandupdatedesc(){
        list<Opportunity> oplist = [select Id, Name, StageName from Opportunity where CreatedDate = LAST_N_DAYS:7];
        system.debug(oplist);
        
        for(Opportunity op : oplist){
            if(op.StageName == 'Closed Won'){
                op.Description = 'Opportunity is Closed Won';
            }
            else if(op.StageName == 'Closed Lost'){
                op.Description = 'Opportunity is Closed Lost';
            }
        }
        
        update oplist;
        
    }
    
    //29th point
    public static void getlastonemonthaccountrecords(){
        list<Account> aclist = [select Id, Name, (select Id from Contacts) from Account where CreatedDate = LAST_N_DAYS:30];
        system.debug(aclist);
        
        for(Account ac : aclist){
            integer contact_count = ac.Contacts.size();
            ac.Total_Contacts__c = contact_count;
            system.debug('AC Id - '+ac.Id+' contact count '+contact_count);
        }
    }
    
    //30th point
    public static void getlastweekcontactstoupdate(){
        list<Contact> conlist = [select Id, Name, Phone, Account.Phone From Contact where CreatedDate = THIS_WEEK];
        system.debug(conlist); 
        
        for(Contact cn : conlist){
            
            if(String.isBlank(cn.Phone)){
                system.debug(cn.Account.Phone);
                cn.Phone = cn.Account.Phone;
            }
        }
        
        update conlist;
    }
    
    //31st point
    public static void getaccountwithemployee(){
        list<Account> aclist = [select Id, Name, (select Id, Name__c, Salary__c from Employee__r) From Account];
        //system.debug(aclist);
        
        decimal totalsalary = 0;
        for(Account ac : aclist){
            system.debug(ac.Id);
            for(Employee__c emp : ac.Employee__r){
                totalsalary+=emp.Salary__c;
                
            }
            ac.Total_Salary__c = totalsalary;
            system.debug(totalsalary);
        }
        
        update aclist;
    }
    
}