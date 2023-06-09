trigger DoctorTrigger on Doctor__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    
    if (trigger.isInsert && trigger.isBefore) {

        DoctorTriggerHandler.duplicateDoctorValidation(trigger.new);
    }
}