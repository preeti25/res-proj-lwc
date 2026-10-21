trigger ResourceAllocationTrigger on Resource_Allocation__c (before insert, after insert, before update, after update) {

    if(trigger.isAfter && trigger.isInsert){
        ResourceAllocationHandler.calculaterevenueandcostonProject(trigger.new);
    }
    
    if(trigger.isBefore && trigger.isInsert){
        ResourceAllocationHandler.checkpointsbeforecreate(trigger.new);
    }
}