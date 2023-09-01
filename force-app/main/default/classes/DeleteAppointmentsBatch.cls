public class DeleteAppointmentsBatch implements Database.Batchable<sObject>, Schedulable {
  public void execute(SchedulableContext sc) {
    Database.executeBatch(new DeleteAppointmentsBatch());
  }

  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      [
        SELECT Id
        FROM Appointment__c
        WHERE
          End_Date_Time__c <= :datetime.now().addMonths(-2)
          AND Live__c = FALSE
      ]
    );
  }

  public void execute(
    Database.BatchableContext bc,
    List<Appointment__c> appointments
  ) {
    delete appointments;
  }

  public void finish(Database.BatchableContext bc) {
    set<id> userIds = new Set<id>();

    for (GroupMember gm : [
      SELECT UserOrGroupId
      FROM GroupMember
      WHERE Group.Name = 'Daily Job'
    ]) {
      userIds.add(gm.UserOrGroupId);
    }

    Set<string> emailAddresses = new Set<String>();
    for (user user : [
      SELECT email
      FROM user
      WHERE isActive = TRUE AND id IN :userIds
    ]) {
      emailAddresses.add(user.email);
    }

    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    email.setSubject('Daily Job Batch Process Executed');
    email.setPlainTextBody(
      'The batch process \'Daily Job\' has been completed.'
    );
    email.setSenderDisplayName('Practico LTD, Co.');
    email.setHtmlBody(
      '<p>The batch process \'Daily Job\' has been completed.</p>'
    );
    email.setToAddresses(new List<string>(emailAddresses));

    Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ email });
  }
}
