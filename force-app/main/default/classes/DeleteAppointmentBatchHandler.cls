public class DeleteAppointmentsBatchHandler {
  public static void scheduleBatch() {
    DeleteAppointmentsBatch batch = new DeleteAppointmentsBatch();
    String cronExp = '0 0 3 * * ?';

    // Schedule the batch job
    system.schedule('Delete Old Appointments', cronExp, batch);
  }
}
