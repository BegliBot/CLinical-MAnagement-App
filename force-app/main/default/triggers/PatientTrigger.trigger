trigger PatientTrigger on Patient__c(
  before insert,
  after insert,
  before update,
  after update,
  before delete,
  after delete,
  after undelete
) {
  if (Trigger.isInsert && Trigger.isBefore) {
    PatientTriggerHandler.duplicatePatientValidation(Trigger.new);
  }
}