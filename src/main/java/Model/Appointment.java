package Model;

import java.sql.Date;

public class Appointment {
    private int id;
    private String customerName;
    private String phone;
    private String petName;
    private String serviceName; // Tên dịch vụ (Lấy từ bảng Services)
    private String doctorName;  // Tên bác sĩ (Lấy từ bảng Doctors)
    private Date bookingDate;
    private String status;      // Trạng thái (Pending/Confirmed)

    public Appointment() {}

    // Constructor và Getter/Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }
    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }
    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }
    public Date getBookingDate() { return bookingDate; }
    public void setBookingDate(Date bookingDate) { this.bookingDate = bookingDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}