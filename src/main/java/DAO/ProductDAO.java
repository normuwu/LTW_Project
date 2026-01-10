package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Context.DBContext;
import Model.Product;

public class ProductDAO {

    // Hàm lấy danh sách tất cả sản phẩm
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Products ORDER BY id DESC"; 

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getDouble("price"),
                    rs.getDouble("old_price"),
                    rs.getInt("discount")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy sản phẩm theo ID
    public Product getProductById(int id) {
        String query = "SELECT * FROM Products WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getDouble("price"),
                        rs.getDouble("old_price"),
                        rs.getInt("discount")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Thêm sản phẩm mới
    public boolean addProduct(String name, String image, double price, double oldPrice, int discount) {
        String query = "INSERT INTO Products (name, image, price, old_price, discount) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setDouble(3, price);
            ps.setDouble(4, oldPrice);
            ps.setInt(5, discount);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Cập nhật sản phẩm
    public boolean updateProduct(int id, String name, String image, double price, double oldPrice, int discount) {
        String query = "UPDATE Products SET name = ?, image = ?, price = ?, old_price = ?, discount = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setDouble(3, price);
            ps.setDouble(4, oldPrice);
            ps.setInt(5, discount);
            ps.setInt(6, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Xóa sản phẩm
    public boolean deleteProduct(int id) {
        String query = "DELETE FROM Products WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Đếm tổng sản phẩm
    public int getTotalProducts() {
        String query = "SELECT COUNT(*) FROM Products";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Đếm sản phẩm đang giảm giá
    public int getDiscountedProducts() {
        String query = "SELECT COUNT(*) FROM Products WHERE discount > 0";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Test thử ngay tại đây xem có lấy được dữ liệu không (Hàm Main)
    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.getAllProducts();
        
        for (Product o : list) {
            System.out.println(o.getName());
        }
    }
}
