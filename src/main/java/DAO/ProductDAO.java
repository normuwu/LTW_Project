package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Context.DBContext;
import Model.Product;

public class ProductDAO {

    // 1. Lấy danh sách tất cả (Cho trang Shop)
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Products"; 

        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Xử lý nếu mô tả bị null trong database
                String desc = rs.getString("description");
                if (desc == null) desc = ""; 

                list.add(new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getDouble("price"),
                    rs.getInt("discount"),
                    desc // Truyền mô tả vào
                ));
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Lấy 1 sản phẩm theo ID (Cho trang Chi tiết)
    public Product getProductById(int id) {
        String query = "SELECT * FROM Products WHERE id = ?";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String desc = rs.getString("description");
                if (desc == null) desc = "Đang cập nhật thông tin sản phẩm...";

                return new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getDouble("price"),
                    rs.getInt("discount"),
                    desc 
                );
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}