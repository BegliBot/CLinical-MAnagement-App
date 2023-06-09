@IsTest
public class DoctorTriggerHandlerTest {
    
    @IsTest
    public static void testDuplicateDoctorValidation() {
        
        List<Doctor__c> newDoctors = new List<Doctor__c>();
        newDoctors.add(new Doctor__c(Email__c = 'test1@gmail.com', Phone__c = '11111'));
        newDoctors.add(new Doctor__c(Email__c = 'test2@gmail.com', Phone__c = '55555'));
        newDoctors.add(new Doctor__c(Email__c = 'test3@gmail.com', Phone__c = '22222'));
        
        
        List<Doctor__c> existingDoctors = new List<Doctor__c>();
        existingDoctors.add(new Doctor__c(Email__c = 'test3@gmail.com', Phone__c = '77777'));
        existingDoctors.add(new Doctor__c(Email__c = 'test4@gmail.com', Phone__c = '11111'));
        insert existingDoctors;
        
        
        DoctorTriggerHandler.duplicateDoctorValidation(newDoctors);
        
        
        System.assertEquals(1, newDoctors[0].getErrors().size());
        System.assertEquals(0, newDoctors[1].getErrors().size());
        System.assertEquals(1, newDoctors[2].getErrors().size());
    }
}
