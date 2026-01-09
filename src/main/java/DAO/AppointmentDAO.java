package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Context.DBContext;
import Model.Appointment;

public class AppointmentDAO {

    // 1. Hàm thêm lịch hẹn mới 
    public void insertAppointment(String name, String phone, String pet, int serviceId, int doctorId, String date, String note) {
        String query = "INSERT INTO appointments (customer_name, phone, pet_name, service_id, doctor_id, booking_date, note, status) VALUES (?, ?, ?, ?, ?, ?, ?, 'Pending')";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, pet);
            ps.setInt(4, serviceId);

           
            if (doctorId == 0) {
                ps.setNull(5, java.sql.Types.INTEGER);
            } else {
                ps.setInt(5, doctorId);
            }
            // -----------------------------

            ps.setString(6, date); 
            ps.setString(7, note);
            ps.executeUpdate();
            
            // Đóng kết nối để tránh quá tải
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 2. Hàm lấy danh sách (Giữ nguyên logic của bạn, thêm đóng kết nối cho an toàn)
    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        // Query chuẩn có JOIN bảng để lấy tên
        String query = "SELECT a.id, a.customer_name, a.phone, a.pet_name, " +
                       "s.name as service_name, d.name as doctor_name, a.booking_date, a.status " +
                       "FROM appointments a " +
                       "LEFT JOIN services s ON a.service_id = s.id " +
                       "LEFT JOIN doctors d ON a.doctor_id = d.id " +
                       "ORDER BY a.booking_date DESC"; 

        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id"));
                a.setCustomerName(rs.getString("customer_name"));
                a.setPhone(rs.getString("phone"));
                a.setPetName(rs.getString("pet_name"));
                
                // Xử lý hiển thị tên Dịch vụ / Bác sĩ
                String sName = rs.getString("service_name");
                String dName = rs.getString("doctor_name");
                
                a.setServiceName(sName != null ? sName : "Dịch vụ đã xóa");
                a.setDoctorName(dName != null ? dName : "Chưa chỉ định");
                
                a.setBookingDate(rs.getDate("booking_date"));
                a.setStatus(rs.getString("status")); 
                list.add(a);
            }
            // Đóng kết nối
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}