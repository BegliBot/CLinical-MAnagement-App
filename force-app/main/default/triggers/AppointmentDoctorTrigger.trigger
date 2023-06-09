trigger AppointmentDoctorTrigger on Appointment_Doctor__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {

    if (trigger.isBefore && trigger.isinsert || trigger.isUpdate) {

        AppointmentDoctorTriggerHandler.validateAppDoc(trigger.new);
    }
}