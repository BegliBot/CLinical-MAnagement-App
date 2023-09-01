trigger AppointmentDoctorTrigger on Appointment_Doctor__c(
  before insert,
  after insert,
  before update,
  after update,
  before delete,
  after delete,
  after undelete
) {
  if (Trigger.isBefore && Trigger.isinsert || Trigger.isUpdate) {
    AppointmentDoctorTriggerHandler.validateAppDoc(Trigger.new);
  }
}
