package Context;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    
    /* CẤU HÌNH TÀI KHOẢN DATABASE CỦA BẠN Ở ĐÂY */
    private final String serverName = "localhost";
    private final String dbName = "petvaccine";
    private final String portNumber = "3306";
    private final String userID = "root";       
    private final String password = "1111";      

    public Connection getConnection() throws Exception {
        // 1. Khai báo Driver cho MySQL 8.0
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // 2. Tạo chuỗi kết nối với UTF-8 encoding
        String url = "jdbc:mysql://" + serverName + ":" + portNumber + "/" + dbName 
                   + "?useUnicode=true&characterEncoding=UTF-8&characterSetResults=UTF-8";
        
        // 3. Mở kết nối
        return DriverManager.getConnection(url, userID, password);
    }
}