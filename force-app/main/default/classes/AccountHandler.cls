public with sharing class AccountHandler {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAllAccounts() {
        return [
            SELECT Id, Name, Phone
            FROM Account
            LIMIT 200
        ];
    }

    public static void accountBeforeInsertMethod(List<Account> aclist) {
        for (Account ac : aclist) {
            if (String.isNotBlank(ac.Industry) && ac.Industry == 'Media') {
                ac.Rating = 'Hot';
            }

            if (ac.CopyBillingToShipping__c == true) {
                ac.ShippingCity = ac.BillingCity;
                ac.ShippingCountry = ac.BillingCountry;
                ac.ShippingPostalCode = ac.BillingPostalCode;
                ac.ShippingState = ac.BillingState;
                ac.ShippingStreet = ac.BillingStreet;
            }
        }
    }

    public static void accountAfterInsertMethod(List<Account> aclist) {
        List<Contact> contlist = new List<Contact>();
        List<Opportunity> oplist = new List<Opportunity>();

        for (Account ac : aclist) {
            if (ac.Active__c == 'Yes' && ac.Opportunity_Checkbox__c == true) {
                Opportunity op = new Opportunity(
                    AccountId = ac.Id,
                    Name = ac.Name + ' - Opp',
                    CloseDate = Date.today().addDays(90),
                    StageName = 'Prospecting',
                    Amount = 50000
                );
                oplist.add(op);
            }

            if (ac.Contact_Checkbox__c == true) {
                Contact con = new Contact(
                    AccountId = ac.Id,
                    FirstName = 'trigger',
                    LastName = 'contact'
                );
                contlist.add(con);
            }
        }

        if (!contlist.isEmpty()) {
            insert contlist;
        }

        if (!oplist.isEmpty()) {
            insert oplist;
        }
    }

    public static void updateAccDesconPhoneUpdate(List<Account> acclist, Map<Id, Account> oldAccMap) {
        for (Account ac : acclist) {
            if (ac.Phone != oldAccMap.get(ac.Id).Phone) {
                ac.Description = 'Phone is Updated! Old Value : ' + oldAccMap.get(ac.Id).Phone + ' & New Value : ' + ac.Phone;
            }
        }
    }

    public static void accountBeforeUpdateMethod(List<Account> acclist) {
        for (Account ac : acclist) {
            if (ac.Industry != null && ac.Industry == 'Media') {
                ac.Rating = 'Hot';
            }

            if (ac.CopyBillingToShipping__c == true) {
                ac.ShippingCity = ac.BillingCity;
                ac.ShippingCountry = ac.BillingCountry;
                ac.ShippingPostalCode = ac.BillingPostalCode;
                ac.ShippingState = ac.BillingState;
                ac.ShippingStreet = ac.BillingStreet;
            }
        }
    }

    public static void updateRelatedContactsPhone(List<Account> aclist, Map<Id, Account> oldmap) {
        Set<Id> accIds = new Set<Id>();
        List<Contact> conlist = new List<Contact>();

        for (Account ac : aclist) {
            if (ac.Phone != null && oldmap != null && ac.Phone != oldmap.get(ac.Id).Phone) {
                accIds.add(ac.Id);
            }
        }

        for (Account acc : [
            SELECT Id, Phone, (SELECT HomePhone, AccountId FROM Contacts)
            FROM Account
            WHERE Id IN :accIds
        ]) {
            if (acc.Contacts != null) {
                for (Contact con : acc.Contacts) {
                    con.HomePhone = acc.Phone;
                    conlist.add(con);
                }
            }
        }

        if (!conlist.isEmpty()) {
            update conlist;
        }
    }

    public static void updateRelatedContactsMailingAddress(List<Account> aclist, Map<Id, Account> oldmap) {
        List<Contact> conlist = new List<Contact>();
        Map<Id, Account> accmap = new Map<Id, Account>();

        for (Account ac : aclist) {
            accmap.put(ac.Id, ac);
        }

        if (!accmap.isEmpty()) {
            List<Contact> relatedconlist = [
                SELECT Id, MailingStreet, MailingCity, MailingCountry, MailingPostalCode, MailingState, AccountId
                FROM Contact
                WHERE AccountId IN :accmap.keySet()
            ];

            for (Contact con : relatedconlist) {
                if (accmap.containsKey(con.AccountId)) {
                    con.MailingStreet = accmap.get(con.AccountId).BillingStreet;
                    con.MailingCity = accmap.get(con.AccountId).BillingCity;
                    con.MailingCountry = accmap.get(con.AccountId).BillingCountry;
                    con.MailingPostalCode = accmap.get(con.AccountId).BillingPostalCode;
                    con.MailingState = accmap.get(con.AccountId).BillingState;
                    conlist.add(con);
                }
            }
        }

        if (!conlist.isEmpty()) {
            update conlist;
        }
    }

    public static void updateoppstagetocloselost(List<Account> aclist, Map<Id, Account> oldmap) {
        Set<Id> acIds = new Set<Id>();

        for (Account ac : aclist) {
            if (oldmap.get(ac.Id).Active__c == 'Yes' && ac.Active__c == 'No') {
                acIds.add(ac.Id);
            }
        }

        if (!acIds.isEmpty()) {
            List<Opportunity> oplist = [
                SELECT Id, Name, StageName
                FROM Opportunity
                WHERE AccountId IN :acIds
            ];

            for (Opportunity op : oplist) {
                op.StageName = 'Closed Lost';
            }

            update oplist;
        }
    }

    public static void preventDeleteifActiveYes(List<Account> aclist) {
        for (Account ac : aclist) {
            if (ac.Active__c == 'Yes') {
                ac.addError('You can not delete Active Account');
            }
        }
    }

    public static void preventAccEditingcreatedSevenDaysBack(List<Account> aclist) {
        // left intentionally blank for now
    }

    public static void checkOnlySystemAdmincanDeleteRecord(List<Account> aclist) {
        Profile p = [
            SELECT Name
            FROM Profile
            WHERE Id = :UserInfo.getProfileId()
        ];

        for (Account ac : aclist) {
            if (p.Name != 'System Administrator') {
                ac.addError('Only System Administrator can Delete Record');
            }
        }
    }
}
