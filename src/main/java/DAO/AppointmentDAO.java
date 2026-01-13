package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Context.DBContext;
import Model.Appointment;

public class AppointmentDAO {
    
    // Số lịch hẹn tối đa mỗi bác sĩ có thể nhận trong 1 ngày
    private static final int MAX_APPOINTMENTS_PER_DAY = 5;

    // 1. Hàm thêm lịch hẹn mới (có user_id)
    public void insertAppointment(int userId, String name, String phone, String pet, String petType, int serviceId, int doctorId, String date, String note) {
        String query = "INSERT INTO appointments (user_id, customer_name, phone, pet_name, pet_type, service_id, doctor_id, booking_date, note, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending')";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            if (userId > 0) {
                ps.setInt(1, userId);
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            ps.setString(2, name);
            ps.setString(3, phone);
            ps.setString(4, pet);
            ps.setString(5, petType);
            ps.setInt(6, serviceId);

            if (doctorId == 0) {
                ps.setNull(7, java.sql.Types.INTEGER);
            } else {
                ps.setInt(7, doctorId);
            }

            ps.setString(8, date); 
            ps.setString(9, note);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 1b. Hàm thêm lịch hẹn (không có user_id - backward compatible)
    public void insertAppointment(String name, String phone, String pet, String petType, int serviceId, int doctorId, String date, String note) {
        insertAppointment(0, name, phone, pet, petType, serviceId, doctorId, date, note);
    }
    
    // 1c. Cập nhật lịch hẹn
    public boolean updateAppointment(int id, String customerName, String phone, String petName, String petType, int serviceId, String bookingDate, String note) {
        String query = "UPDATE appointments SET customer_name = ?, phone = ?, pet_name = ?, pet_type = ?, service_id = ?, booking_date = ?, note = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, customerName);
            ps.setString(2, phone);
            ps.setString(3, petName);
            ps.setString(4, petType);
            ps.setInt(5, serviceId);
            ps.setString(6, bookingDate);
            ps.setString(7, note);
            ps.setInt(8, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 2. Lấy danh sách tất cả lịch hẹn (cho Admin)
    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        String query = "SELECT a.id, a.customer_name, a.phone, a.pet_name, a.pet_type, " +
                       "a.service_id, a.doctor_id, " +
                       "s.name as service_name, d.name as doctor_name, a.booking_date, a.status, a.note " +
                       "FROM appointments a " +
                       "LEFT JOIN services s ON a.service_id = s.id " +
                       "LEFT JOIN doctors d ON a.doctor_id = d.id " +
                       "ORDER BY a.booking_date DESC"; 

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id"));
                a.setCustomerName(rs.getString("customer_name"));
                a.setPhone(rs.getString("phone"));
                a.setPetName(rs.getString("pet_name"));
                a.setPetType(rs.getString("pet_type"));
                a.setServiceId(rs.getInt("service_id"));
                a.setDoctorId(rs.getInt("doctor_id"));
                a.setNote(rs.getString("note"));
                
                String sName = rs.getString("service_name");
                String dName = rs.getString("doctor_name");
                
                a.setServiceName(sName != null ? sName : "Dịch vụ đã xóa");
                a.setDoctorName(dName != null ? dName : "Chưa chỉ định");
                
                a.setBookingDate(rs.getDate("booking_date"));
                a.setStatus(rs.getString("status")); 
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // 2b. Lấy danh sách lịch hẹn theo User ID (cho User) - Pending lên đầu
    public List<Appointment> getAppointmentsByUserId(int userId) {
        List<Appointment> list = new ArrayList<>();
        String query = "SELECT a.id, a.user_id, a.customer_name, a.phone, a.pet_name, a.pet_type, " +
                       "a.service_id, a.doctor_id, " +
                       "s.name as service_name, d.name as doctor_name, a.booking_date, a.status, a.note " +
                       "FROM appointments a " +
                       "LEFT JOIN services s ON a.service_id = s.id " +
                       "LEFT JOIN doctors d ON a.doctor_id = d.id " +
                       "WHERE a.user_id = ? " +
                       "ORDER BY CASE WHEN a.status = 'Pending' THEN 0 " +
                       "WHEN a.status = 'Confirmed' THEN 1 " +
                       "WHEN a.status = 'Completed' THEN 2 " +
                       "ELSE 3 END, a.id DESC"; 

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Appointment a = new Appointment();
                    a.setId(rs.getInt("id"));
                    a.setUserId(rs.getInt("user_id"));
                    a.setCustomerName(rs.getString("customer_name"));
                    a.setPhone(rs.getString("phone"));
                    a.setPetName(rs.getString("pet_name"));
                    a.setPetType(rs.getString("pet_type"));
                    a.setServiceId(rs.getInt("service_id"));
                    a.setDoctorId(rs.getInt("doctor_id"));
                    a.setNote(rs.getString("note"));
                    
                    String sName = rs.getString("service_name");
                    String dName = rs.getString("doctor_name");
                    
                    a.setServiceName(sName != null ? sName : "Dịch vụ đã xóa");
                    a.setDoctorName(dName != null ? dName : "Chưa chỉ định");
                    
                    a.setBookingDate(rs.getDate("booking_date"));
                    a.setStatus(rs.getString("status")); 
                    list.add(a);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // 2c. Lấy danh sách lịch hẹn theo số điện thoại (backup nếu user_id = 0) - Pending lên đầu
    public List<Appointment> getAppointmentsByPhone(String phone) {
        List<Appointment> list = new ArrayList<>();
        if (phone == null || phone.isEmpty()) return list;
        
        String query = "SELECT a.id, a.user_id, a.customer_name, a.phone, a.pet_name, a.pet_type, " +
                       "a.service_id, a.doctor_id, " +
                       "s.name as service_name, d.name as doctor_name, a.booking_date, a.status, a.note " +
                       "FROM appointments a " +
                       "LEFT JOIN services s ON a.service_id = s.id " +
                       "LEFT JOIN doctors d ON a.doctor_id = d.id " +
                       "WHERE a.phone = ? " +
                       "ORDER BY CASE WHEN a.status = 'Pending' THEN 0 " +
                       "WHEN a.status = 'Confirmed' THEN 1 " +
                       "WHEN a.status = 'Completed' THEN 2 " +
                       "ELSE 3 END, a.id DESC"; 

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Appointment a = new Appointment();
                    a.setId(rs.getInt("id"));
                    a.setUserId(rs.getInt("user_id"));
                    a.setCustomerName(rs.getString("customer_name"));
                    a.setPhone(rs.getString("phone"));
                    a.setPetName(rs.getString("pet_name"));
                    a.setPetType(rs.getString("pet_type"));
                    a.setServiceId(rs.getInt("service_id"));
                    a.setDoctorId(rs.getInt("doctor_id"));
                    a.setNote(rs.getString("note"));
                    
                    String sName = rs.getString("service_name");
                    String dName = rs.getString("doctor_name");
                    
                    a.setServiceName(sName != null ? sName : "Dịch vụ đã xóa");
                    a.setDoctorName(dName != null ? dName : "Chưa chỉ định");
                    
                    a.setBookingDate(rs.getDate("booking_date"));
                    a.setStatus(rs.getString("status")); 
                    list.add(a);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // 3. Lấy lịch hẹn theo ID
    public Appointment getAppointmentById(int id) {
        String query = "SELECT a.*, s.name as service_name, d.name as doctor_name " +
                       "FROM appointments a " +
                       "LEFT JOIN services s ON a.service_id = s.id " +
                       "LEFT JOIN doctors d ON a.doctor_id = d.id " +
                       "WHERE a.id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Appointment a = new Appointment();
                    a.setId(rs.getInt("id"));
                    a.setCustomerName(rs.getString("customer_name"));
                    a.setPhone(rs.getString("phone"));
                    a.setPetName(rs.getString("pet_name"));
                    a.setPetType(rs.getString("pet_type"));
                    a.setServiceId(rs.getInt("service_id"));
                    a.setDoctorId(rs.getInt("doctor_id"));
                    a.setNote(rs.getString("note"));
                    a.setServiceName(rs.getString("service_name"));
                    a.setDoctorName(rs.getString("doctor_name"));
                    a.setBookingDate(rs.getDate("booking_date"));
                    a.setStatus(rs.getString("status"));
                    return a;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 4. Cập nhật trạng thái lịch hẹn
    public boolean updateStatus(int appointmentId, String status) {
        String query = "UPDATE appointments SET status = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, status);
            ps.setInt(2, appointmentId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 5. Đếm số lịch hẹn đã duyệt của bác sĩ trong ngày
    public int countDoctorAppointments(int doctorId, String date) {
        String query = "SELECT COUNT(*) FROM appointments WHERE doctor_id = ? AND booking_date = ? AND status = 'Confirmed'";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, doctorId);
            ps.setString(2, date);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // 6. Kiểm tra bác sĩ có full lịch trong ngày không
    public boolean isDoctorFullyBooked(int doctorId, String date) {
        return countDoctorAppointments(doctorId, date) >= MAX_APPOINTMENTS_PER_DAY;
    }
    
    // 7. Duyệt lịch hẹn (kiểm tra bác sĩ có full không)
    public String approveAppointment(int appointmentId) {
        Appointment apt = getAppointmentById(appointmentId);
        if (apt == null) {
            return "Không tìm thấy lịch hẹn!";
        }
        
        // Nếu có bác sĩ được chỉ định, kiểm tra lịch
        if (apt.getDoctorId() > 0) {
            String dateStr = apt.getBookingDate().toString();
            if (isDoctorFullyBooked(apt.getDoctorId(), dateStr)) {
                return "FULL";
            }
        }
        
        if (updateStatus(appointmentId, "Confirmed")) {
            return "SUCCESS";
        }
        return "Có lỗi xảy ra khi duyệt lịch hẹn!";
    }
    
    // 8. Từ chối lịch hẹn
    public boolean rejectAppointment(int appointmentId) {
        return updateStatus(appointmentId, "Rejected");
    }
    
    // 9. Hoàn thành lịch hẹn
    public boolean completeAppointment(int appointmentId) {
        return updateStatus(appointmentId, "Completed");
    }
    
    // 10. Hủy lịch hẹn
    public boolean cancelAppointment(int appointmentId) {
        return updateStatus(appointmentId, "Cancelled");
    }

    
    // 10b. Xóa lịch hẹn (cho phép xóa lịch đã hủy, từ chối hoặc hoàn thành)
    public boolean deleteAppointment(int appointmentId) {
        String query = "DELETE FROM appointments WHERE id = ? AND (status = 'Cancelled' OR status = 'Rejected' OR status = 'Completed')";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, appointmentId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 10c. Xóa tất cả lịch hẹn đã hủy
    public int deleteAllCancelled() {
        String query = "DELETE FROM appointments WHERE status = 'Cancelled'";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // 10d. Xóa tất cả lịch hẹn đã hoàn thành
    public int deleteAllCompleted() {
        String query = "DELETE FROM appointments WHERE status = 'Completed'";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // 11. Đếm tổng số lịch hẹn theo trạng thái
    public int countByStatus(String status) {
        String query = "SELECT COUNT(*) FROM appointments WHERE status = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // 12. Đếm lịch hẹn hôm nay
    public int countTodayAppointments() {
        String query = "SELECT COUNT(*) FROM appointments WHERE booking_date = CURDATE()";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
