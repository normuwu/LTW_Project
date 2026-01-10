package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Context.DBContext;
import Model.BlogPost;

public class BlogDAO {
    
    // Lấy tất cả bài viết
    public List<BlogPost> getAllBlogs() {
        List<BlogPost> list = new ArrayList<>();
        String query = "SELECT * FROM BlogPosts ORDER BY id DESC"; 
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                BlogPost blog = new BlogPost();
                blog.setId(rs.getInt("id"));
                blog.setTitle(rs.getString("title"));
                blog.setImage(rs.getString("image"));
                blog.setCategory(rs.getString("category"));
                blog.setDate(rs.getString("created_date"));
                blog.setAuthor(rs.getString("author"));
                blog.setSummary(rs.getString("summary"));
                list.add(blog);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy bài viết theo ID
    public BlogPost getBlogById(int id) {
        String query = "SELECT * FROM BlogPosts WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BlogPost blog = new BlogPost();
                    blog.setId(rs.getInt("id"));
                    blog.setTitle(rs.getString("title"));
                    blog.setImage(rs.getString("image"));
                    blog.setCategory(rs.getString("category"));
                    blog.setDate(rs.getString("created_date"));
                    blog.setAuthor(rs.getString("author"));
                    blog.setSummary(rs.getString("summary"));
                    return blog;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm bài viết mới
    public boolean insertBlog(String title, String image, String category, String date, String author, String summary) {
        String query = "INSERT INTO BlogPosts (title, image, category, created_date, author, summary) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, title);
            ps.setString(2, image);
            ps.setString(3, category);
            ps.setString(4, date);
            ps.setString(5, author);
            ps.setString(6, summary);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Cập nhật bài viết
    public boolean updateBlog(int id, String title, String image, String category, String date, String author, String summary) {
        String query = "UPDATE BlogPosts SET title = ?, image = ?, category = ?, created_date = ?, author = ?, summary = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, title);
            ps.setString(2, image);
            ps.setString(3, category);
            ps.setString(4, date);
            ps.setString(5, author);
            ps.setString(6, summary);
            ps.setInt(7, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Xóa bài viết
    public boolean deleteBlog(int id) {
        String query = "DELETE FROM BlogPosts WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Đếm tổng số bài viết
    public int countAll() {
        String query = "SELECT COUNT(*) FROM BlogPosts";
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
    
    // Đếm theo danh mục
    public int countByCategory(String category) {
        String query = "SELECT COUNT(*) FROM BlogPosts WHERE category = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, category);
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
    
    // Lấy danh sách danh mục
    public List<String> getAllCategories() {
        List<String> list = new ArrayList<>();
        String query = "SELECT DISTINCT category FROM BlogPosts ORDER BY category";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(rs.getString("category"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
