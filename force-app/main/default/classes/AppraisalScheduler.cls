global class AppraisalScheduler implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        AppraisalHandler.createAppraisel();
    }
}