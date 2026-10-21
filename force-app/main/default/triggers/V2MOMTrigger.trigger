trigger V2MOMTrigger on V2MOM__c (before insert, after insert, before update, after update) {

    if(trigger.isAfter && trigger.isInsert){
        FeedbackHandler.createFeedbackRecord(trigger.new);
    }
}