package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Context.DBContext;
import Model.BlogPost;

public class BlogDAO {
    // Hàm lấy tất cả bài viết
    public List<BlogPost> getAllBlogs() {
        List<BlogPost> list = new ArrayList<>();
        String query = "SELECT * FROM BlogPosts ORDER BY id DESC"; 

        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new BlogPost(
                    
                    rs.getString("title"),
                    rs.getString("image"),
                    rs.getString("category"),
                    rs.getString("created_date"),
                    rs.getString("author"),
                    rs.getString("summary")
                ));
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}