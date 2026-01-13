package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Context.DBContext;
import Model.Vaccine;

public class VaccineDAO {

    // Lấy tất cả vaccine
    public List<Vaccine> getAllVaccines() {
        List<Vaccine> list = new ArrayList<>();
        String query = "SELECT * FROM vaccines ORDER BY target_species, name";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(mapResultSetToVaccine(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy vaccine đang hoạt động
    public List<Vaccine> getActiveVaccines() {
        List<Vaccine> list = new ArrayList<>();
        String query = "SELECT * FROM vaccines WHERE is_active = 1 ORDER BY target_species, name";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(mapResultSetToVaccine(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy vaccine theo loài
    public List<Vaccine> getVaccinesBySpecies(String species) {
        List<Vaccine> list = new ArrayList<>();
        String query = "SELECT * FROM vaccines WHERE is_active = 1 AND (target_species = ? OR target_species = 'Tất cả') ORDER BY name";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, species);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToVaccine(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy vaccine theo ID
    public Vaccine getVaccineById(int id) {
        String query = "SELECT * FROM vaccines WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToVaccine(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Thêm vaccine mới
    public boolean insertVaccine(Vaccine vaccine) {
        String query = "INSERT INTO vaccines (name, description, target_species, manufacturer, price, " +
                       "doses_required, interval_days, min_age_weeks, stock_quantity, is_active) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, vaccine.getName());
            ps.setString(2, vaccine.getDescription());
            ps.setString(3, vaccine.getTargetSpecies());
            ps.setString(4, vaccine.getManufacturer());
            ps.setLong(5, vaccine.getPrice());
            ps.setInt(6, vaccine.getDosesRequired());
            ps.setInt(7, vaccine.getIntervalDays());
            ps.setInt(8, vaccine.getMinAgeWeeks());
            ps.setInt(9, vaccine.getStockQuantity());
            ps.setBoolean(10, vaccine.isActive());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Cập nhật vaccine
    public boolean updateVaccine(Vaccine vaccine) {
        String query = "UPDATE vaccines SET name = ?, description = ?, target_species = ?, manufacturer = ?, " +
                       "price = ?, doses_required = ?, interval_days = ?, min_age_weeks = ?, " +
                       "stock_quantity = ?, is_active = ? WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, vaccine.getName());
            ps.setString(2, vaccine.getDescription());
            ps.setString(3, vaccine.getTargetSpecies());
            ps.setString(4, vaccine.getManufacturer());
            ps.setLong(5, vaccine.getPrice());
            ps.setInt(6, vaccine.getDosesRequired());
            ps.setInt(7, vaccine.getIntervalDays());
            ps.setInt(8, vaccine.getMinAgeWeeks());
            ps.setInt(9, vaccine.getStockQuantity());
            ps.setBoolean(10, vaccine.isActive());
            ps.setInt(11, vaccine.getId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Xóa vaccine
    public boolean deleteVaccine(int id) {
        String query = "DELETE FROM vaccines WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Cập nhật số lượng tồn kho
    public boolean updateStock(int id, int quantity) {
        String query = "UPDATE vaccines SET stock_quantity = stock_quantity + ? WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, quantity);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Giảm tồn kho khi tiêm
    public boolean decreaseStock(int id) {
        String query = "UPDATE vaccines SET stock_quantity = stock_quantity - 1 WHERE id = ? AND stock_quantity > 0";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Đếm tổng vaccine
    public int countAll() {
        String query = "SELECT COUNT(*) FROM vaccines";
        
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
    
    // Đếm vaccine sắp hết hàng
    public int countLowStock() {
        String query = "SELECT COUNT(*) FROM vaccines WHERE stock_quantity <= 10 AND stock_quantity > 0";
        
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
    
    // Đếm vaccine hết hàng
    public int countOutOfStock() {
        String query = "SELECT COUNT(*) FROM vaccines WHERE stock_quantity = 0";
        
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
    
    // Helper method
    private Vaccine mapResultSetToVaccine(ResultSet rs) throws Exception {
        Vaccine v = new Vaccine();
        v.setId(rs.getInt("id"));
        v.setName(rs.getString("name"));
        v.setDescription(rs.getString("description"));
        v.setTargetSpecies(rs.getString("target_species"));
        v.setManufacturer(rs.getString("manufacturer"));
        v.setPrice(rs.getLong("price"));
        v.setDosesRequired(rs.getInt("doses_required"));
        v.setIntervalDays(rs.getInt("interval_days"));
        v.setMinAgeWeeks(rs.getInt("min_age_weeks"));
        v.setStockQuantity(rs.getInt("stock_quantity"));
        v.setActive(rs.getBoolean("is_active"));
        v.setCreatedAt(rs.getTimestamp("created_at"));
        return v;
    }
}
