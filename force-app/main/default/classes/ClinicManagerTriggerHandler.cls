public class ClinicManagerTriggerHandler {
    
    public static void duplicateCM_Validation(list<clinic_manager__c> newCM) {

        Set<String> existingEmails = new set<string>();
        Set<String> existingPhoneNumbers = new Set<String>();

        Set<String> newEmails = new Set<String>();
        Set<String> newPhoneNumbers = new Set<String>();

        for (clinic_manager__c newManager : newCM) {
            newEmails.add(newManager.Email__c);
            newPhoneNumbers.add(newManager.Phone__c);
        }

        List<clinic_manager__c> listCM = [select email__c, Phone__c from clinic_manager__c where email__c in :newEmails or Phone__c in :newPhoneNumbers];

        for (clinic_manager__c eachCM : listCM) {
            existingEmails.add(eachCM.Email__c);
            existingPhoneNumbers.add(eachCM.Phone__c);
        }

        for (clinic_manager__c eachNewCM : newCM) {
            if (existingEmails.contains(eachNewCM.Email__c) || existingPhoneNumbers.contains(eachNewCM.Phone__c)) {
                eachNewCM.addError('Duplicate manager record found with the same email or phone number');
            }
        }
    }

    public static void alternativeEmailValidation(list<clinic_manager__c> newCM) {

        for (clinic_manager__c eachCM : newCM) {

            if (eachCM.email__c != null && eachCM.Alternative_Email__c != null && eachCM.Email__c.contains(eachCM.Alternative_Email__c)) {
                eachCM.addError('Alternative email cannot be the same as the original email');
            }
        }
    }

    public static void alternativePhoneValidation(list<clinic_manager__c> newCM) {

        for (clinic_manager__c eachCM : newCM) {

            if (eachCM.Phone__c != null && eachCM.Alternative_Phone__c != null && eachCM.Phone__c.contains(eachCM.Alternative_Phone__c)) {
                eachCM.addError('Alternative phone number cannot be the same as the original phone number');
            }
        }
    }
}