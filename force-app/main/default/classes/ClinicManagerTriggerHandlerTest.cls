@IsTest
public class ClinicManagerTriggerHandlerTest {
  @IsTest
  public static void duplicateCM_ValidationTEST() {
    List<clinic_manager__c> newCM = new List<clinic_manager__c>();
    newCM.add(
      new clinic_manager__c(
        Email__c = 'test1@gmail.com',
        Phone__c = '1234567890'
      )
    );
    newCM.add(
      new clinic_manager__c(
        Email__c = 'test2@gmail.com',
        Phone__c = '9876543210'
      )
    );
    newCM.add(
      new clinic_manager__c(
        Email__c = 'test3@gmail.com',
        Phone__c = '1234567890'
      )
    );

    List<clinic_manager__c> existingCM = new List<clinic_manager__c>();
    existingCM.add(
      new clinic_manager__c(
        Email__c = 'test3@gmail.com',
        Phone__c = '5555555555'
      )
    );
    existingCM.add(
      new clinic_manager__c(
        Email__c = 'test4@gmail.com',
        Phone__c = '1234567890'
      )
    );
    insert existingCM;

    ClinicManagerTriggerHandler.duplicateCM_Validation(newCM);

    system.assertEquals(1, newCM[0].getErrors().size());
    system.assertEquals(0, newCM[1].getErrors().size());
    system.assertEquals(1, newCM[2].getErrors().size());
  }

  @IsTest
  public static void testAlternativeEmailValidation() {
    List<clinic_manager__c> newCM = new List<clinic_manager__c>();
    newCM.add(
      new clinic_manager__c(
        Email__c = 'test1@gmail.com',
        Alternative_Email__c = 'alternative1@exampl.com'
      )
    );
    newCM.add(
      new clinic_manager__c(
        Email__c = 'test2@gmail.com',
        Alternative_Email__c = 'alternative2@gmail.com'
      )
    );
    newCM.add(
      new clinic_manager__c(
        Email__c = 'test3@gmail.com',
        Alternative_Email__c = 'test3@gmail.com'
      )
    );

    ClinicManagerTriggerHandler.alternativeEmailValidation(newCM);

    system.assertEquals(0, newCM[0].getErrors().size());
    system.assertEquals(0, newCM[1].getErrors().size());
    system.assertEquals(1, newCM[2].getErrors().size());
  }

  @IsTest
  public static void testAlternativePhoneValidation() {
    List<clinic_manager__c> newCM = new List<clinic_manager__c>();
    newCM.add(
      new clinic_manager__c(
        Phone__c = '1234567890',
        Alternative_Phone__c = '9876543210'
      )
    );
    newCM.add(
      new clinic_manager__c(
        Phone__c = '9876543210',
        Alternative_Phone__c = '1234567890'
      )
    );
    newCM.add(
      new clinic_manager__c(
        Phone__c = '1234567890',
        Alternative_Phone__c = '1234567890'
      )
    );

    ClinicManagerTriggerHandler.alternativePhoneValidation(newCM);

    system.assertEquals(0, newCM[0].getErrors().size());
    system.assertEquals(0, newCM[1].getErrors().size());
    system.assertEquals(1, newCM[2].getErrors().size());
  }
}
