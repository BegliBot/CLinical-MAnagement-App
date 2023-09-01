trigger ClinicManagerTrigger on Clinic_Manager__c(
  before insert,
  after insert,
  before update,
  after update,
  before delete,
  after delete,
  after undelete
) {
  //Duplicate Clinic Manager Validation
  if (Trigger.isBefore && Trigger.isInsert) {
    ClinicManagerTriggerHandler.duplicateCM_Validation(Trigger.new);
  }

  //Alternative Phone or Email cannot be the same as original (validation)
  if (Trigger.isBefore && Trigger.isInsert || Trigger.isUpdate) {
    ClinicManagerTriggerHandler.alternativeEmailValidation(Trigger.new);
    ClinicManagerTriggerHandler.alternativePhoneValidation(Trigger.new);
  }
}
