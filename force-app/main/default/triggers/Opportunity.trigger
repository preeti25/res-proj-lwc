trigger Opportunity on Opportunity (before insert, after insert, before update, after update) {
    
    if(trigger.isAfter && trigger.isUpdate){
        OpportunityHandler.createprojectonOpportunityClose(Trigger.new);
    }

}