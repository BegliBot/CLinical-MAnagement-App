@IsTest
public class AppointmentDoctorTriggerHandlerTest {
  @TestSetup
  static void makeData() {
    clinic_manager__c cm = new clinic_manager__c(
      name = 'Test Manager',
      email__c = 'testmanager@gmail.com',
      phone__c = '7777777'
    );
    insert cm;

    appointment__c app = new appointment__c(
      clinic_manager__c = cm.id,
      Name__c = 'Test Appointment',
      Start_date_time__c = Datetime.now(),
      End_date_time__c = Datetime.now().addDays(3),
      Maximum_Number_of_Patients__c = 10,
      Live__c = true
    );
    insert app;

    doctor__c doc = new doctor__c(
      name = 'Test Doc',
      email__c = 'testdoc@gmail.com',
      phone__c = '55555'
    );
    insert doc;

    appointment_doctor__c appDoc = new appointment_doctor__c(
      appointment__c = app.id,
      doctor__c = doc.id
    );
    insert appDoc;
  }

  @isTest
  static void testCoverage() {
    appointment_doctor__c appDoc = [
      SELECT doctor__c, appointment__c
      FROM appointment_doctor__c
      LIMIT 1
    ];

    Test.startTest();
    try {
      insert new appointment_doctor__c(
        appointment__c = appDoc.appointment__c,
        doctor__c = appDoc.doctor__c
      );
    } catch (Exception e) {
      system.assert(
        e.getMessage().contains('has already been assigned to this appointment')
      );
    }
    test.stopTest();
  }
}
