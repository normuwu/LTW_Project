package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Context.DBContext;
import Model.Service;

public class ServiceDAO {

    // Lấy tất cả dịch vụ
    public List<Service> getAllServices() {
        List<Service> list = new ArrayList<>();
        String query = "SELECT * FROM services ORDER BY category, name";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(mapResultSetToService(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy dịch vụ đang hoạt động
    public List<Service> getActiveServices() {
        List<Service> list = new ArrayList<>();
        String query = "SELECT * FROM services WHERE is_active = 1 ORDER BY category, name";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(mapResultSetToService(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy dịch vụ theo danh mục
    public List<Service> getServicesByCategory(String category) {
        List<Service> list = new ArrayList<>();
        String query = "SELECT * FROM services WHERE category = ? AND is_active = 1 ORDER BY name";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, category);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToService(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy dịch vụ theo ID
    public Service getServiceById(int id) {
        String query = "SELECT * FROM services WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToService(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Lấy tên dịch vụ theo ID
    public String getServiceNameById(int id) {
        String query = "SELECT name FROM services WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("name");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Thêm dịch vụ mới
    public boolean insertService(Service service) {
        String query = "INSERT INTO services (name, price, description, category, duration_minutes, is_active, image) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, service.getName());
            ps.setString(2, service.getPrice());
            ps.setString(3, service.getDescription());
            ps.setString(4, service.getCategory());
            ps.setInt(5, service.getDurationMinutes());
            ps.setBoolean(6, service.isActive());
            ps.setString(7, service.getImage());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Cập nhật dịch vụ
    public boolean updateService(Service service) {
        String query = "UPDATE services SET name = ?, price = ?, description = ?, " +
                       "category = ?, duration_minutes = ?, is_active = ?, image = ? WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, service.getName());
            ps.setString(2, service.getPrice());
            ps.setString(3, service.getDescription());
            ps.setString(4, service.getCategory());
            ps.setInt(5, service.getDurationMinutes());
            ps.setBoolean(6, service.isActive());
            ps.setString(7, service.getImage());
            ps.setInt(8, service.getId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Xóa dịch vụ
    public boolean deleteService(int id) {
        String query = "DELETE FROM services WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Đếm tổng dịch vụ
    public int countAll() {
        String query = "SELECT COUNT(*) FROM services";
        
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
    
    // Lấy danh sách categories
    public List<String> getAllCategories() {
        List<String> list = new ArrayList<>();
        String query = "SELECT DISTINCT category FROM services ORDER BY category";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                String cat = rs.getString("category");
                if (cat != null) list.add(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Helper method
    private Service mapResultSetToService(ResultSet rs) throws Exception {
        Service s = new Service();
        s.setId(rs.getInt("id"));
        s.setName(rs.getString("name"));
        s.setPrice(rs.getString("price"));
        s.setDescription(rs.getString("description"));
        
        // Handle columns that might not exist in old schema
        try {
            s.setCategory(rs.getString("category"));
        } catch (Exception e) {
            s.setCategory("Khám chữa bệnh");
        }
        try {
            s.setDurationMinutes(rs.getInt("duration_minutes"));
        } catch (Exception e) {
            s.setDurationMinutes(30);
        }
        try {
            s.setActive(rs.getBoolean("is_active"));
        } catch (Exception e) {
            s.setActive(true);
        }
        try {
            s.setImage(rs.getString("image"));
        } catch (Exception e) {
            s.setImage(null);
        }
        
        return s;
    }
}
