trigger ClinicManagerTrigger on Clinic_Manager__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {

    //Duplicate Clinic Manager Validation
    if (trigger.isBefore && trigger.isInsert) {

        ClinicManagerTriggerHandler.duplicateCM_Validation(trigger.new);
    }

    //Alternative Phone or Email cannot be the same as original (validation)
    if (trigger.isBefore && trigger.isInsert || trigger.isUpdate) {

        ClinicManagerTriggerHandler.alternativeEmailValidation(trigger.new);
        ClinicManagerTriggerHandler.alternativePhoneValidation(trigger.new);
    }
}