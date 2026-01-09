# 🐾 PetVaccine - Website Dịch Vụ Thú Y

Website quản lý dịch vụ tiêm vaccine và chăm sóc thú cưng.

## 📋 Yêu Cầu Hệ Thống

- **Java JDK**: 11 trở lên
- **Apache Tomcat**: 9.0
- **MySQL**: 8.0
- **Trình duyệt**: Chrome, Firefox, Edge

## 🛠️ Cài Đặt

### Bước 1: Cài đặt MySQL

**Cách 1: Dùng XAMPP (Khuyến nghị cho người mới)**
1. Tải XAMPP: https://www.apachefriends.org/download.html
2. Cài đặt và mở XAMPP Control Panel
3. Click "Start" bên cạnh MySQL

**Cách 2: Cài MySQL Server**
1. Tải MySQL: https://dev.mysql.com/downloads/mysql/
2. Cài đặt với password root: `1111`

### Bước 2: Tạo Database

Mở MySQL Workbench hoặc phpMyAdmin, chạy file `db.sql`

Hoặc chạy lệnh:
```bash
mysql -u root -p < db.sql
```

### Bước 3: Cấu hình Database

Mở file `src/main/java/Context/DBContext.java` và kiểm tra thông tin:
```java
private final String serverName = "localhost";
private final String dbName = "petvaccine";
private final String portNumber = "3306";
private final String userID = "root";       
private final String password = "1111";  // Đổi nếu password MySQL khác
```

### Bước 4: Cấu hình Tomcat

Mở file `start_tomcat.bat` và sửa đường dẫn Tomcat:
```batch
set CATALINA_HOME=E:\apache-tomcat-9.0.113-windows-x64\apache-tomcat-9.0.113
```

### Bước 5: Chạy Project

```bash
# Compile code
javac -encoding UTF-8 -d build/classes -cp "src/main/webapp/WEB-INF/lib/*;%CATALINA_HOME%/lib/servlet-api.jar" src/main/java/Context/*.java src/main/java/Model/*.java src/main/java/DAO/*.java src/main/java/Filter/*.java src/main/java/*.java

# Deploy lên Tomcat
xcopy /E /I /Y build\classes %CATALINA_HOME%\webapps\PetVaccine\WEB-INF\classes
xcopy /E /I /Y src\main\webapp %CATALINA_HOME%\webapps\PetVaccine

# Chạy Tomcat
start_tomcat.bat
```

## 🌐 Truy Cập Website

| Trang | URL |
|-------|-----|
| Trang chủ | http://localhost:8081/PetVaccine/home |
| Đăng nhập | http://localhost:8081/PetVaccine/login |
| Đăng ký | http://localhost:8081/PetVaccine/register |
| Admin | http://localhost:8081/PetVaccine/admin/dashboard |

## 👤 Tài Khoản Demo

| Role | Username | Password |
|------|----------|----------|
| Admin | admin | 123456 |
| User | user1 | 123456 |
| Doctor | doctor1 | 123456 |

## 📁 Cấu Trúc Project

```
PetVaccine/
├── src/main/java/
│   ├── Context/
│   │   └── DBContext.java          # Kết nối database
│   ├── Model/
│   │   ├── User.java               # Model người dùng
│   │   ├── Product.java            # Model sản phẩm
│   │   ├── BlogPost.java           # Model bài viết
│   │   └── ...
│   ├── DAO/
│   │   ├── UserDAO.java            # Xử lý database user
│   │   ├── ProductDAO.java         # Xử lý database sản phẩm
│   │   └── ...
│   ├── Filter/
│   │   └── AuthFilter.java         # Filter phân quyền
│   ├── LoginServlet.java           # Xử lý đăng nhập
│   ├── LogoutServlet.java          # Xử lý đăng xuất
│   ├── RegisterServlet.java        # Xử lý đăng ký
│   └── ...Servlet.java             # Các servlet khác
├── src/main/webapp/
│   ├── auth/
│   │   ├── login.jsp               # Trang đăng nhập
│   │   └── register.jsp            # Trang đăng ký
│   ├── admin/
│   │   └── dashboard.jsp           # Trang quản trị
│   ├── mainPages/
│   │   ├── home.jsp                # Trang chủ
│   │   ├── community.jsp           # Cộng đồng
│   │   └── ...
│   ├── Services/
│   │   ├── shop.jsp                # Cửa hàng
│   │   ├── vaccine.jsp             # Dịch vụ vaccine
│   │   └── ...
│   ├── header_footer/
│   │   ├── header.jsp              # Header chung
│   │   └── footer.jsp              # Footer chung
│   └── WEB-INF/
│       ├── web.xml                 # Cấu hình web
│       └── lib/                    # Thư viện JAR
├── database_setup.sql              # Script tạo database
├── add_user_table.sql              # Script tạo bảng Users
└── start_tomcat.bat                # Script chạy Tomcat
```

## ✨ Tính Năng

### Người dùng
- ✅ Đăng ký / Đăng nhập / Đăng xuất
- ✅ Xem trang chủ, dịch vụ
- ✅ Xem cửa hàng sản phẩm
- ✅ Đặt lịch hẹn
- ✅ Xem bài viết cộng đồng

### Admin
- ✅ Dashboard quản trị
- ✅ Quản lý người dùng
- ✅ Quản lý sản phẩm
- ✅ Quản lý lịch hẹn

### Bảo mật
- ✅ Filter phân quyền
- ✅ Session management
- ✅ Bảo vệ trang admin

## 🔧 Công Nghệ Sử Dụng

- **Backend**: Java Servlet, JSP
- **Frontend**: HTML, CSS, Bootstrap 5, JSTL
- **Database**: MySQL 8.0
- **Server**: Apache Tomcat 9.0
- **Icons**: Boxicons

## ❗ Xử Lý Lỗi Thường Gặp

### Lỗi "Connection refused"
- MySQL chưa chạy → Khởi động MySQL

### Lỗi "Access denied"
- Sai password MySQL → Kiểm tra DBContext.java

### Lỗi "404 Not Found"
- Chưa deploy → Chạy lại lệnh xcopy
- Tomcat chưa chạy → Chạy start_tomcat.bat

### Lỗi "CATALINA_HOME not defined"
- Sửa đường dẫn trong start_tomcat.bat

## 📞 Liên Hệ

- Email: admin@petvaccine.com
- Website: http://localhost:8080/PetVaccine

---
© 2024 PetVaccine - Animal Doctors
