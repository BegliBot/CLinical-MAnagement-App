public class PatientTriggerHandler {

    public static void duplicatePatientValidation(list<patient__c> newPatients) {

        Set<String> existingNames = new Set<String>();
        Set<String> existingEmails = new Set<String>();
        set<string> existingPhoneNumbers = new Set<String>();

        Set<string> newName = new Set<String>();
        Set<String> newEmails = new Set<String>();
        Set<String> newPhoneNumbers = new set<string>();

        for (Patient__c newPatient : newPatients) {
            newName.add(newPatient.name);
            newEmails.add(newPatient.Email__c);
            newPhoneNumbers.add(newPatient.Phone__c);
        }

        List<patient__c> patientList = [select name, email__c, phone__c from Patient__c where name in :newName and email__c in :newEmails and phone__c in :newPhoneNumbers];

        for (patient__c eachPatient : patientList) {
            existingNames.add(eachPatient.name);
            existingEmails.add(eachPatient.Email__c);
            existingPhoneNumbers.add(eachPatient.Phone__c);
        }

        for (patient__c newPatient : newPatients) {
            if (existingNames.contains(newPatient.name) || existingEmails.contains(newPatient.Email__c) || existingPhoneNumbers.contains(newPatient.Phone__c)) {
                newPatient.addError('Duplicate patient record found with the same name, email, or phone number');
            }
        }
    }
}