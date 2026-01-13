package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Context.DBContext;
import Model.VaccinationRecord;

public class VaccinationRecordDAO {

    // Lấy lịch sử tiêm của thú cưng
    public List<VaccinationRecord> getRecordsByPetId(int petId) {
        List<VaccinationRecord> list = new ArrayList<>();
        String query = "SELECT vr.*, p.name as pet_name, p.species as pet_species, " +
                       "v.name as vaccine_name, d.name as doctor_name " +
                       "FROM vaccination_records vr " +
                       "LEFT JOIN pets p ON vr.pet_id = p.id " +
                       "LEFT JOIN vaccines v ON vr.vaccine_id = v.id " +
                       "LEFT JOIN doctors d ON vr.doctor_id = d.id " +
                       "WHERE vr.pet_id = ? ORDER BY vr.vaccination_date DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, petId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToRecord(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy tất cả lịch sử tiêm của user (qua pets)
    public List<VaccinationRecord> getRecordsByUserId(int userId) {
        List<VaccinationRecord> list = new ArrayList<>();
        String query = "SELECT vr.*, p.name as pet_name, p.species as pet_species, " +
                       "v.name as vaccine_name, d.name as doctor_name " +
                       "FROM vaccination_records vr " +
                       "JOIN pets p ON vr.pet_id = p.id " +
                       "LEFT JOIN vaccines v ON vr.vaccine_id = v.id " +
                       "LEFT JOIN doctors d ON vr.doctor_id = d.id " +
                       "WHERE p.user_id = ? ORDER BY vr.vaccination_date DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToRecord(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy các mũi tiêm sắp đến hạn của user
    public List<VaccinationRecord> getUpcomingVaccinations(int userId) {
        List<VaccinationRecord> list = new ArrayList<>();
        String query = "SELECT vr.*, p.name as pet_name, p.species as pet_species, " +
                       "v.name as vaccine_name, d.name as doctor_name " +
                       "FROM vaccination_records vr " +
                       "JOIN pets p ON vr.pet_id = p.id " +
                       "LEFT JOIN vaccines v ON vr.vaccine_id = v.id " +
                       "LEFT JOIN doctors d ON vr.doctor_id = d.id " +
                       "WHERE p.user_id = ? AND vr.next_due_date IS NOT NULL " +
                       "AND vr.next_due_date >= CURDATE() " +
                       "ORDER BY vr.next_due_date ASC LIMIT 10";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToRecord(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy record theo ID
    public VaccinationRecord getRecordById(int id) {
        String query = "SELECT vr.*, p.name as pet_name, p.species as pet_species, " +
                       "v.name as vaccine_name, d.name as doctor_name " +
                       "FROM vaccination_records vr " +
                       "LEFT JOIN pets p ON vr.pet_id = p.id " +
                       "LEFT JOIN vaccines v ON vr.vaccine_id = v.id " +
                       "LEFT JOIN doctors d ON vr.doctor_id = d.id " +
                       "WHERE vr.id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRecord(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Thêm record mới
    public boolean insertRecord(VaccinationRecord record) {
        String query = "INSERT INTO vaccination_records (pet_id, vaccine_id, appointment_id, doctor_id, " +
                       "vaccination_date, dose_number, batch_number, next_due_date, notes) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, record.getPetId());
            ps.setInt(2, record.getVaccineId());
            if (record.getAppointmentId() != null) {
                ps.setInt(3, record.getAppointmentId());
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            if (record.getDoctorId() != null) {
                ps.setInt(4, record.getDoctorId());
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
            }
            ps.setDate(5, record.getVaccinationDate());
            ps.setInt(6, record.getDoseNumber());
            ps.setString(7, record.getBatchNumber());
            ps.setDate(8, record.getNextDueDate());
            ps.setString(9, record.getNotes());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Cập nhật record
    public boolean updateRecord(VaccinationRecord record) {
        String query = "UPDATE vaccination_records SET vaccine_id = ?, doctor_id = ?, " +
                       "vaccination_date = ?, dose_number = ?, batch_number = ?, " +
                       "next_due_date = ?, notes = ? WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, record.getVaccineId());
            if (record.getDoctorId() != null) {
                ps.setInt(2, record.getDoctorId());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }
            ps.setDate(3, record.getVaccinationDate());
            ps.setInt(4, record.getDoseNumber());
            ps.setString(5, record.getBatchNumber());
            ps.setDate(6, record.getNextDueDate());
            ps.setString(7, record.getNotes());
            ps.setInt(8, record.getId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Xóa record
    public boolean deleteRecord(int id) {
        String query = "DELETE FROM vaccination_records WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Đếm tổng số mũi tiêm của pet
    public int countByPetId(int petId) {
        String query = "SELECT COUNT(*) FROM vaccination_records WHERE pet_id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, petId);
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
    
    // Lấy mũi tiêm cuối cùng của vaccine cho pet
    public VaccinationRecord getLastVaccination(int petId, int vaccineId) {
        String query = "SELECT vr.*, p.name as pet_name, p.species as pet_species, " +
                       "v.name as vaccine_name, d.name as doctor_name " +
                       "FROM vaccination_records vr " +
                       "LEFT JOIN pets p ON vr.pet_id = p.id " +
                       "LEFT JOIN vaccines v ON vr.vaccine_id = v.id " +
                       "LEFT JOIN doctors d ON vr.doctor_id = d.id " +
                       "WHERE vr.pet_id = ? AND vr.vaccine_id = ? " +
                       "ORDER BY vr.dose_number DESC LIMIT 1";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, petId);
            ps.setInt(2, vaccineId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRecord(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Helper method
    private VaccinationRecord mapResultSetToRecord(ResultSet rs) throws Exception {
        VaccinationRecord r = new VaccinationRecord();
        r.setId(rs.getInt("id"));
        r.setPetId(rs.getInt("pet_id"));
        r.setVaccineId(rs.getInt("vaccine_id"));
        r.setAppointmentId(rs.getObject("appointment_id") != null ? rs.getInt("appointment_id") : null);
        r.setDoctorId(rs.getObject("doctor_id") != null ? rs.getInt("doctor_id") : null);
        r.setVaccinationDate(rs.getDate("vaccination_date"));
        r.setDoseNumber(rs.getInt("dose_number"));
        r.setBatchNumber(rs.getString("batch_number"));
        r.setNextDueDate(rs.getDate("next_due_date"));
        r.setNotes(rs.getString("notes"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        r.setPetName(rs.getString("pet_name"));
        r.setPetSpecies(rs.getString("pet_species"));
        r.setVaccineName(rs.getString("vaccine_name"));
        r.setDoctorName(rs.getString("doctor_name"));
        return r;
    }
}
