trigger DoctorTrigger on Doctor__c(
  before insert,
  after insert,
  before update,
  after update,
  before delete,
  after delete,
  after undelete
) {
  if (Trigger.isInsert && Trigger.isBefore) {
    DoctorTriggerHandler.duplicateDoctorValidation(Trigger.new);
  }
}
