@RestResource(urlMapping='/AppointmentDetails/*')
global with sharing class AppointmentDetailsJSON {

    global class AppointmentDetails {
        public String appointmentId;
        public String name;
        public String appointmentType;
        public String department;
        public String fullAddress;
        public String status;
        public String startDate;
        public String endDate;
        public Boolean live;

        public AppointmentDetails(Appointment__c app){

            this.appointmentId = app.Id;
            this.name = app.Name;
            this.appointmentType = app.Appointment_Type__c;
            this.department = app.Department__c;
            this.fullAddress = app.Full_Address__c;
            this.status = app.Status__c;
            this.startDate = app.Start_Date_Time__c.format('yyyy-MM-dd hh:MM');
            this.endDate = app.End_Date_Time__c.format('yyyy-MM-dd hh:MM');
            this.live = app.Live__c;
        }
    }
    
    @HttpGet    
    global static List<AppointmentDetails> getAppDetails() {
        
        List<AppointmentDetails> details = new List<AppointmentDetails>();

        for (Appointment__c app : [SELECT Id, Name, Appointment_Type__c, Department__c, Full_Address__c, Status__c, Live__c, Start_Date_Time__c, End_Date_Time__c FROM Appointment__c WHERE Live__c = TRUE AND Start_Date_Time__c >: Date.today() WITH SECURITY_ENFORCED]){
        
            details.add(new AppointmentDetails(app));
        } 

        return details;
    }
}