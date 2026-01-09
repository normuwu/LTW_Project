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
    public void insertAppointment(String name, String phone, String pet, String petType, int serviceId, int doctorId, String date, String note) {
        String query = "INSERT INTO appointments (customer_name, phone, pet_name, pet_type, service_id, doctor_id, booking_date, note, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Pending')";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, pet);
            ps.setString(4, petType);
            ps.setInt(5, serviceId);

           
            if (doctorId == 0) {
                ps.setNull(6, java.sql.Types.INTEGER);
            } else {
                ps.setInt(6, doctorId);
            }
            // -----------------------------

            ps.setString(7, date); 
            ps.setString(8, note);
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
        String query = "SELECT a.id, a.customer_name, a.phone, a.pet_name, a.pet_type, " +
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
                a.setPetType(rs.getString("pet_type"));
                
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