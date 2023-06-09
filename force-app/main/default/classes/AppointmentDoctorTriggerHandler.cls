public class AppointmentDoctorTriggerHandler {
    public static void validateAppDoc(List<Appointment_Doctor__c> newDoc) {
        set<id> docIds = new set<id>();
        set<id> appIds = new set<id>();
        map<string, appointment_doctor__c> appDocMap = new map<string, appointment_doctor__c>();

        for (appointment_doctor__c ad : newDoc) {
            docIds.add(ad.doctor__c);
            appIds.add(ad.appointment__c);

            string appDocKey = ad.doctor__c + '_' + ad.appointment__c;
            appDocMap.put(appDocKey, ad);
        }

        List<Appointment_Doctor__c> appDocList = [select id, doctor__c, appointment__c, doctor__r.name from appointment_doctor__c where doctor__c in :docIds and appointment__c in :appIds];

        for (appointment_doctor__c existingAppDoc : appDocList) {
            String existingKey = existingAppDoc.doctor__c + '_' + existingAppDoc.appointment__c;
            appointment_doctor__c conflictKey = appDocMap.get(existingKey);

            if (conflictKey != null) {
                conflictKey.addError(existingAppDoc.doctor__r.name + ' has already been assigned to this appointment'); 
            }
        }
    }
}