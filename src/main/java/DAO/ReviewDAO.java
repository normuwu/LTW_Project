package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Context.DBContext;
import Model.Review;

public class ReviewDAO {

    public List<Review> getReviewsByProductId(int productId) {
        List<Review> list = new ArrayList<>();
        // Query Join để lấy tên người dùng từ bảng Users
        String query = "SELECT r.*, u.full_name FROM Reviews r " +
                       "JOIN Users u ON r.user_id = u.id " +
                       "WHERE r.product_id = ? " +
                       "ORDER BY r.created_at DESC";
        
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Review(
                    rs.getInt("id"),
                    rs.getInt("product_id"),
                    rs.getInt("user_id"),
                    rs.getString("full_name"), // Lấy tên user
                    rs.getInt("rating"),
                    rs.getString("comment"),
                    rs.getDate("created_at")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}