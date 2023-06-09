public class DoctorTriggerHandler {
    public static void duplicateDoctorValidation(List<Doctor__c> newDoctors) {
        
        Set<String> existingEmails = new Set<String>();
        Set<String> existingPhoneNumbers = new Set<String>();
        
        Set<String> newEmails = new Set<String>();
        Set<String> newPhoneNumbers = new Set<String>();
        
        for (Doctor__c newDoctor : newDoctors) {
            newEmails.add(newDoctor.Email__c);
            newPhoneNumbers.add(newDoctor.Phone__c);
        }
        
        List<Doctor__c> listDoc = [select Email__c, Phone__c from Doctor__c where Email__c in :newEmails or Phone__c in :newPhoneNumbers];
        
        for (Doctor__c doctor : listDoc) {
            existingEmails.add(doctor.Email__c);
            existingPhoneNumbers.add(doctor.Phone__c);
        }
        
        for (Doctor__c newDoctor : newDoctors) {
            if (existingEmails.contains(newDoctor.Email__c) || existingPhoneNumbers.contains(newDoctor.Phone__c)) {
                newDoctor.addError('Duplicate doctor record found with the same email or phone number');
            }
        }
    }
}