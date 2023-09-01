public class AppointmentDoctorTriggerHandler {
  public static void validateAppDoc(List<Appointment_Doctor__c> newDoc) {
    set<id> docIds = new Set<id>();
    set<id> appIds = new Set<id>();
    map<string, appointment_doctor__c> appDocMap = new Map<string, appointment_doctor__c>();

    for (appointment_doctor__c ad : newDoc) {
      docIds.add(ad.doctor__c);
      appIds.add(ad.appointment__c);

      string appDocKey = ad.doctor__c + '_' + ad.appointment__c;
      appDocMap.put(appDocKey, ad);
    }

    List<Appointment_Doctor__c> appDocList = [
      SELECT Id, Doctor__c, Appointment__c, Doctor__r.name
      FROM Appointment_doctor__c
      WHERE Doctor__c IN :docIds AND Appointment__c IN :appIds
    ];

    for (appointment_doctor__c existingAppDoc : appDocList) {
      String existingKey =
        existingAppDoc.doctor__c +
        '_' +
        existingAppDoc.appointment__c;
      appointment_doctor__c conflictKey = appDocMap.get(existingKey);

      if (conflictKey != null) {
        conflictKey.addError(
          existingAppDoc.doctor__r.name +
          ' already has been assigned to this appointment!'
        );
      }
    }
  }
}
