public class DeleteAppointmentsBatch implements Database.Batchable<sObject>, Schedulable {

    public void execute(SchedulableContext sc){
        Database.executeBatch(new DeleteAppointmentsBatch());

    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([select Id from Appointment__c where End_Date_Time__c <= :datetime.now().addMonths(-2) and Live__c = false]);
    }

    public void execute(Database.BatchableContext bc, List<Appointment__c> appointments) {
        
        delete appointments;
    }

    public void finish(Database.BatchableContext bc) {

        set<id> userIds = new set<id>();

        for (GroupMember gm : [select UserOrGroupId from GroupMember where Group.Name = 'Daily Job']) {
            userIds.add(gm.UserOrGroupId);
        }
        
        Set<string> emailAddresses = new Set<String>();
        for (user user : [select email from user where isActive = true and id in: userIds]) {
            emailAddresses.add(user.email);
        }

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject('Daily Job Batch Process Executed');
        email.setPlainTextBody('The batch process \'Daily Job\' has been completed.');
        email.setSenderDisplayName('Practico LTD, Co.');
        email.setHtmlBody('<p>The batch process \'Daily Job\' has been completed.</p>');
        email.setToAddresses(new list<string>(emailAddresses));

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
}