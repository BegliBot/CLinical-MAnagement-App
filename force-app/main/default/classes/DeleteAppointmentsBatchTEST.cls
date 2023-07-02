@isTest
private class DeleteAppointmentsBatchTEST {
    @isTest
    static void testBatchJob() {

        Clinic_Manager__c manager = new clinic_manager__c(Name = 'Test MAnager', Email__c = 'test@test.com', phone__c = '123456789');
        insert manager;
        
        List<Appointment__c> appointments = new List<Appointment__c>();
        for (Integer i = 0; i < 200; i++) {
            Appointment__c appointment = new Appointment__c(clinic_manager__c = manager.id, name__c = 'Test',Maximum_Number_of_Patients__c = 10, Start_Date_Time__c = datetime.now().addMonths(-3), End_Date_Time__c = Datetime.now().addMonths(-2), Live__c = false);
            appointments.add(appointment);
        }
        insert appointments;

        Test.startTest();

        DeleteAppointmentsBatch batch = new DeleteAppointmentsBatch();
        Database.executeBatch(batch);

        Test.stopTest();

        
        List<Appointment__c> remainingAppointments = [select Id from Appointment__c];
        System.assertEquals(0, remainingAppointments.size());
    }
}
