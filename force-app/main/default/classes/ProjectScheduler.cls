global class ProjectScheduler implements Schedulable {

    global void execute(SchedulableContext sc){
        ProjectNotificationHandler.sendEmailtoProjectManager();
        ProjectNotificationHandler.updateprojectstatusafterenddatepassed();
    }
}