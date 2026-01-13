package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import Context.DBContext;

public class ReportDAO {

    // Thống kê tổng quan
    public Map<String, Integer> getOverviewStats() {
        Map<String, Integer> stats = new HashMap<>();
        
        try (Connection conn = new DBContext().getConnection()) {
            // Tổng users
            try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM users");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.put("totalUsers", rs.getInt(1));
            }
            
            // Tổng appointments
            try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM appointments");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.put("totalAppointments", rs.getInt(1));
            }
            
            // Appointments hoàn thành
            try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM appointments WHERE status = 'Completed'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.put("completedAppointments", rs.getInt(1));
            }
            
            // Tổng pets
            try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM pets");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.put("totalPets", rs.getInt(1));
            }
            
            // Tổng vaccinations
            try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM vaccination_records");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.put("totalVaccinations", rs.getInt(1));
            }
            
            // Tổng doctors
            try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM doctors");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) stats.put("totalDoctors", rs.getInt(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
    }

    // Thống kê appointments theo tháng
    public List<Map<String, Object>> getAppointmentsByMonth(int year) {
        List<Map<String, Object>> list = new ArrayList<>();
        String query = "SELECT MONTH(booking_date) as month, COUNT(*) as count, " +
                       "SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) as completed " +
                       "FROM appointments WHERE YEAR(booking_date) = ? " +
                       "GROUP BY MONTH(booking_date) ORDER BY month";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("month", rs.getInt("month"));
                    row.put("count", rs.getInt("count"));
                    row.put("completed", rs.getInt("completed"));
                    list.add(row);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thống kê vaccinations theo tháng
    public List<Map<String, Object>> getVaccinationsByMonth(int year) {
        List<Map<String, Object>> list = new ArrayList<>();
        String query = "SELECT MONTH(vaccination_date) as month, COUNT(*) as count " +
                       "FROM vaccination_records WHERE YEAR(vaccination_date) = ? " +
                       "GROUP BY MONTH(vaccination_date) ORDER BY month";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("month", rs.getInt("month"));
                    row.put("count", rs.getInt("count"));
                    list.add(row);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thống kê theo dịch vụ
    public List<Map<String, Object>> getAppointmentsByService() {
        List<Map<String, Object>> list = new ArrayList<>();
        String query = "SELECT s.name, COUNT(a.id) as count " +
                       "FROM appointments a JOIN services s ON a.service_id = s.id " +
                       "GROUP BY s.id, s.name ORDER BY count DESC LIMIT 10";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("service", rs.getString("name"));
                row.put("count", rs.getInt("count"));
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thống kê theo bác sĩ
    public List<Map<String, Object>> getAppointmentsByDoctor() {
        List<Map<String, Object>> list = new ArrayList<>();
        String query = "SELECT d.name, COUNT(a.id) as count " +
                       "FROM appointments a JOIN doctors d ON a.doctor_id = d.id " +
                       "GROUP BY d.id, d.name ORDER BY count DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("doctor", rs.getString("name"));
                row.put("count", rs.getInt("count"));
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thống kê vaccine phổ biến
    public List<Map<String, Object>> getPopularVaccines() {
        List<Map<String, Object>> list = new ArrayList<>();
        String query = "SELECT v.name, COUNT(vr.id) as count " +
                       "FROM vaccination_records vr JOIN vaccines v ON vr.vaccine_id = v.id " +
                       "GROUP BY v.id, v.name ORDER BY count DESC LIMIT 10";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("vaccine", rs.getString("name"));
                row.put("count", rs.getInt("count"));
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy appointments sắp đến hạn nhắc nhở
    public List<Map<String, Object>> getUpcomingReminders(int days) {
        List<Map<String, Object>> list = new ArrayList<>();
        String query = "SELECT vr.*, p.name as pet_name, p.user_id, v.name as vaccine_name, u.email, u.fullname " +
                       "FROM vaccination_records vr " +
                       "JOIN pets p ON vr.pet_id = p.id " +
                       "JOIN vaccines v ON vr.vaccine_id = v.id " +
                       "JOIN users u ON p.user_id = u.id " +
                       "WHERE vr.next_due_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL ? DAY) " +
                       "ORDER BY vr.next_due_date";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, days);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("id", rs.getInt("id"));
                    row.put("petName", rs.getString("pet_name"));
                    row.put("vaccineName", rs.getString("vaccine_name"));
                    row.put("nextDueDate", rs.getDate("next_due_date"));
                    row.put("email", rs.getString("email"));
                    row.put("fullname", rs.getString("fullname"));
                    row.put("userId", rs.getInt("user_id"));
                    list.add(row);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
