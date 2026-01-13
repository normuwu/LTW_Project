# 🐾 PetVaccine - Animal Doctors

Website quản lý dịch vụ tiêm vaccine và chăm sóc thú cưng.

## 📋 Yêu Cầu Hệ Thống

| Phần mềm | Phiên bản | Link tải |
|----------|-----------|----------|
| Java JDK | 11+ | [Download](https://adoptium.net/) |
| Apache Maven | 3.6+ | [Download](https://maven.apache.org/download.cgi) |
| Apache Tomcat | 9.0 | [Download](https://tomcat.apache.org/download-90.cgi) |
| MySQL | 8.0 | [Download](https://dev.mysql.com/downloads/mysql/) |

## 🚀 Hướng Dẫn Cài Đặt

### Bước 1: Cài đặt phần mềm cần thiết

#### 1.1 Cài Java JDK 11+
```bash
# Kiểm tra Java đã cài chưa
java -version

# Nếu chưa có, tải và cài từ: https://adoptium.net/
```

#### 1.2 Cài Maven
```bash
# Kiểm tra Maven
mvn -version

# Nếu chưa có:
# Windows: Tải từ https://maven.apache.org/download.cgi
# Giải nén và thêm bin folder vào PATH
```

#### 1.3 Cài MySQL
- **Cách 1 (Khuyến nghị)**: Dùng XAMPP - https://www.apachefriends.org/download.html
- **Cách 2**: Cài MySQL Server - https://dev.mysql.com/downloads/mysql/

#### 1.4 Cài Tomcat 9
1. Tải từ: https://tomcat.apache.org/download-90.cgi
2. Giải nén vào thư mục (VD: `C:\tomcat` hoặc `E:\apache-tomcat-9.0.113`)

### Bước 2: Tạo Database

1. Khởi động MySQL (hoặc Start MySQL trong XAMPP)
2. Mở MySQL Workbench hoặc phpMyAdmin
3. Chạy file `db.sql` để tạo database và dữ liệu mẫu

```bash
# Hoặc dùng command line:
mysql -u root -p < db.sql
```

### Bước 3: Cấu hình Database

Mở file `src/main/java/Context/DBContext.java` và sửa thông tin kết nối:

```java
private final String serverName = "localhost";
private final String dbName = "petvaccine";
private final String portNumber = "3306";
private final String userID = "root";       
private final String password = "YOUR_MYSQL_PASSWORD";  // ← Sửa password của bạn
```

### Bước 4: Cấu hình đường dẫn Tomcat

Mở 2 file và sửa đường dẫn Tomcat cho đúng máy của bạn:

**File `start_tomat.bat`:**
```batch
set CATALINA_HOME=C:\path\to\your\tomcat    ← Sửa đường dẫn
```

**File `scripts/deploy.bat`:**
```batch
copy /Y target\PetVaccine.war "C:\path\to\your\tomcat\webapps\"    ← Sửa đường dẫn
```

### Bước 5: Build và Deploy

```bash
# Build project
mvn clean package -DskipTests

# Copy file WAR vào Tomcat (hoặc chạy scripts/deploy.bat)
copy target\PetVaccine.war [TOMCAT_HOME]\webapps\
```

### Bước 6: Chạy Tomcat

```bash
# Windows - chạy file
start_tomat.bat

# Hoặc vào thư mục Tomcat/bin và chạy
startup.bat
```

### Bước 7: Truy cập Website

Mở trình duyệt: **http://localhost:8080/PetVaccine/home**

## 👤 Tài Khoản Demo

| Vai trò | Username | Password |
|---------|----------|----------|
| Admin | admin | 123456 |
| User | user1 | 123456 |
| Doctor | doctor1 | 123456 |

## 🌐 Các Trang Chính

| Trang | URL |
|-------|-----|
| Trang chủ | /PetVaccine/home |
| Đăng nhập | /PetVaccine/login |
| Đăng ký | /PetVaccine/register |
| Đặt lịch | /PetVaccine/booking |
| Siêu thị | /PetVaccine/shop |
| Admin Dashboard | /PetVaccine/admin/dashboard |

## 📁 Cấu Trúc Project

```
PetVaccine/
├── pom.xml                         # Maven config
├── db.sql                          # Database script
├── start_tomat.bat                 # Script chạy Tomcat
├── scripts/
│   └── deploy.bat                  # Script build & deploy
├── src/main/java/
│   ├── Context/DBContext.java      # Kết nối database
│   ├── Model/                      # Các entity class
│   ├── DAO/                        # Data Access Objects
│   ├── Filter/                     # Auth filters
│   ├── Util/                       # Utility classes
│   └── controller/                 # Servlets
└── src/main/webapp/
    ├── pages/                      # JSP pages
    ├── components/                 # Shared components
    ├── assets/                     # CSS, JS, Images
    └── WEB-INF/web.xml            # Web config
```

## ❗ Xử Lý Lỗi Thường Gặp

| Lỗi | Nguyên nhân | Cách fix |
|-----|-------------|----------|
| Connection refused | MySQL chưa chạy | Start MySQL/XAMPP |
| Access denied | Sai password MySQL | Sửa DBContext.java |
| 404 Not Found | Chưa deploy WAR | Chạy deploy.bat |
| Port 8080 in use | Port bị chiếm | Đổi port trong Tomcat/conf/server.xml |
| mvn not found | Chưa cài Maven | Cài Maven và thêm vào PATH |

## 🔧 Công Nghệ

- **Backend**: Java Servlet, JSP, JSTL
- **Frontend**: HTML, CSS, Bootstrap 5, JavaScript
- **Database**: MySQL 8.0
- **Build Tool**: Maven
- **Server**: Apache Tomcat 9.0

---
© 2024 PetVaccine - Animal Doctors
