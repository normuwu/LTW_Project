package Model;

public class Appointment {
    private String id;
    private String date;
    private String time;
    private String serviceName;
    private String petName;
    
    private Doctor doctor; // 👈 Thay String bằng Object Doctor
    
    private String status;

    // Cập nhật Constructor nhận vào Doctor
    public Appointment(String id, String date, String time, String serviceName, String petName, Doctor doctor, String status) {
        this.id = id;
        this.date = date;
        this.time = time;
        this.serviceName = serviceName;
        this.petName = petName;
        this.doctor = doctor; // Gán Object
        this.status = status;
    }

    public String getId() { return id; }
    public String getDate() { return date; }
    public String getTime() { return time; }
    public String getServiceName() { return serviceName; }
    public String getPetName() { return petName; }
    
    public Doctor getDoctor() { return doctor; } // 👈 Getter trả về Doctor
    
    public String getStatus() { return status; }
}