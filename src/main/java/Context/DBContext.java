package Context;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    
    /* CẤU HÌNH TÀI KHOẢN DATABASE CỦA BẠN Ở ĐÂY */
    private final String serverName = "localhost";
    private final String dbName = "petvaccine";
    private final String portNumber = "3306";
    private final String userID = "root";       
    private final String password = "MySQL Root Password";      

    public Connection getConnection() throws Exception {
        // 1. Khai báo Driver cho MySQL 8.0
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // 2. Tạo chuỗi kết nối
        String url = "jdbc:mysql://" + serverName + ":" + portNumber + "/" + dbName;
        
        // 3. Mở kết nối
        return DriverManager.getConnection(url, userID, password);
    }
}