trigger TimesheetTrigger on Timesheet__c (before insert, after insert, before update, after update) {
    
    if(trigger.isAfter && trigger.isUpdate){
        ProjectHandler.calculateRevenueandCost(trigger.new);
    }

}