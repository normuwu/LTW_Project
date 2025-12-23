package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Context.DBContext;
import Model.Product;

public class ProductDAO {

    Connection conn = null;          // Kết nối với SQL
    PreparedStatement ps = null;     // Ném câu lệnh query sang SQL
    ResultSet rs = null;             // Nhận kết quả trả về

    // Hàm lấy danh sách tất cả sản phẩm
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        // Câu lệnh SQL (khớp với tên cột trong Database bạn đã tạo)
        String query = "SELECT * FROM Products"; 

        try {
            // 1. Mở kết nối
            conn = new DBContext().getConnection(); 
            
            // 2. Ném câu lệnh query vào
            ps = conn.prepareStatement(query);
            
            // 3. Chạy lệnh và nhận kết quả
            rs = ps.executeQuery();

            // 4. Lặp qua từng dòng kết quả để đẩy vào List
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
            e.printStackTrace(); // In lỗi ra Console nếu có (sai pass, sai tên bảng...)
        }
        // Đóng kết nối (để tránh đầy bộ nhớ) là việc nên làm, nhưng tạm thời Java sẽ tự dọn dẹp
        return list;
    }
    
    // Test thử ngay tại đây xem có lấy được dữ liệu không (Hàm Main)
    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.getAllProducts();
        
        for (Product o : list) {
            System.out.println(o.getName()); // Nếu in ra tên sản phẩm ở Console là thành công
        }
    }
}