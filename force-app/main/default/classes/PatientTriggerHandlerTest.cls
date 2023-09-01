@IsTest
public class PatientTriggerHandlerTest {
  @IsTest
  public static void testDuplicatePatientValidation() {
    // Test data setup
    List<Patient__c> newPatients = new List<Patient__c>();
    newPatients.add(
      new Patient__c(
        Name = 'Vladimir Putin',
        Email__c = 'kremlin@russia.ru',
        Phone__c = '+77777777777'
      )
    );
    newPatients.add(
      new Patient__c(
        Name = 'Donald Trump',
        Email__c = 'donaldtrump@usa.gov',
        Phone__c = '+12025557777'
      )
    );
    newPatients.add(
      new Patient__c(
        Name = 'Pablo Escobar',
        Email__c = 'encrypted@unknown.com',
        Phone__c = '+575557777'
      )
    );

    // Existing patients with duplicates
    List<Patient__c> existingPatients = new List<Patient__c>();
    existingPatients.add(
      new Patient__c(
        Name = 'Vladimir Putin',
        Email__c = 'kremlin@russia.ru',
        Phone__c = '+7777775555'
      )
    );
    existingPatients.add(
      new Patient__c(
        Name = 'John Doe',
        Email__c = 'johndoe@example.com',
        Phone__c = '+123456789'
      )
    );
    insert existingPatients;

    // Invoke the method under test
    Test.startTest();
    PatientTriggerHandler.duplicatePatientValidation(newPatients);
    Test.stopTest();

    // Assertions
    System.assertEquals(1, newPatients[0].getErrors().size());
    System.assertEquals(0, newPatients[1].getErrors().size());
    System.assertEquals(0, newPatients[2].getErrors().size());
  }

  @IsTest
  public static void testDuplicatePatientValidation_NoExistingPatients() {
    // Test data setup
    List<Patient__c> newPatients = new List<Patient__c>();
    newPatients.add(
      new Patient__c(
        Name = 'John Doe',
        Email__c = 'johndoe@example.com',
        Phone__c = '+123456789'
      )
    );

    // Invoke the method under test
    Test.startTest();
    PatientTriggerHandler.duplicatePatientValidation(newPatients);
    Test.stopTest();

    // Assertions
    System.assertEquals(0, newPatients[0].getErrors().size());
  }
}
