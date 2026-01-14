# 🐾 PetVaccine - Animal Doctors

Website quản lý dịch vụ tiêm vaccine và chăm sóc thú cưng.

## ⚡ Hướng Dẫn Nhanh (Quick Start)

```bash
# 1. Clone project
git clone git clone -b new-update --single-branch https://github.com/normuwu/LTW_Project.git

cd LTW_Project

# 2. Chạy script setup (kiểm tra môi trường + build)
scripts\setup.bat

# 3. Cấu hình database (sửa password MySQL)
#    Mở file: src/main/java/Context/DBContext.java
#    Sửa dòng: private final String password = "your_mysql_password";

# 4. Import database
scripts\import-db.bat

# 5. Cấu hình Tomcat (tự động)
scripts\config-tomcat.bat
#    Nhập đường dẫn Tomcat của bạn (VD: C:\apache-tomcat-9.0.98)

# 6. Deploy và chạy
scripts\deploy.bat
start.bat

# 7. Mở trình duyệt: http://localhost:8080/PetVaccine/home
```

**Tài khoản mặc định:**
- Admin: `admin` / `Admin@123`
- User: `user1` / `User@123`

---

## 📋 Yêu Cầu Hệ Thống

| Phần mềm | Phiên bản | Download |
|----------|-----------|----------|
| Java JDK | 11, 17, 21 | [Adoptium](https://adoptium.net/) |
| Apache Maven | 3.6+ | [Download](https://maven.apache.org/download.cgi) |
| Apache Tomcat | **9.x** | [Download Tomcat 9](https://tomcat.apache.org/download-90.cgi) |
| MySQL | 8.0 | [Download](https://dev.mysql.com/downloads/mysql/) |

> ⚠️ **Lưu ý quan trọng về Tomcat:**
> - Project sử dụng `javax.servlet.*` (Java EE)
> - **Tomcat 9.x**: ✅ Tương thích
> - **Tomcat 10/11**: ❌ Không tương thích (dùng `jakarta.servlet.*`)
> - Nếu bạn chỉ có Tomcat 10/11, cần migrate project sang Jakarta EE

## 🚀 Hướng Dẫn Cài Đặt

### Bước 0: Clone và Import Project

```bash
git clone https://github.com/normuwu/LTW_Project.git
```

**Import vào Eclipse:**
1. File → Import → Maven → Existing Maven Projects
2. Chọn thư mục project vừa clone
3. Eclipse sẽ tự tạo `.classpath`, `.project`, `.settings/` theo cấu hình máy của bạn

**Import vào IntelliJ IDEA:**
1. File → Open → Chọn thư mục project
2. IntelliJ sẽ tự nhận diện Maven project
3. Đợi IntelliJ download dependencies
4. Cấu hình Tomcat:
   - Run → Edit Configurations → Add New → Tomcat Server → Local
   - Configure → Chọn thư mục Tomcat 9
   - Deployment → Add → Artifact → PetVaccine:war exploded
   - Application context: `/PetVaccine`

> 💡 Các file Eclipse config không được commit lên Git vì mỗi máy có JDK/Tomcat khác nhau

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
private final String password = "MySQL Root Password"  // ← Sửa password của bạn
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
start.bat

### Bước 7: Truy cập Website

Mở trình duyệt: **http://localhost:8080/PetVaccine/home**


## 🌐 Các Trang Chính

### Trang công khai
| Trang | URL |
|-------|-----|
| Trang chủ | /PetVaccine/home |
| Giới thiệu | /PetVaccine/about |
| Dịch vụ | /PetVaccine/services |
| Cộng đồng | /PetVaccine/community |
| Đăng nhập | /PetVaccine/login |
| Đăng ký | /PetVaccine/register |

### Dịch vụ
| Trang | URL |
|-------|-----|
| Tiêm vaccine | /PetVaccine/vaccine |
| Khám bệnh | /PetVaccine/medical |
| Phẫu thuật | /PetVaccine/surgery |
| Spa & Grooming | /PetVaccine/spa |
| Khách sạn thú cưng | /PetVaccine/hotel |
| Siêu thị | /PetVaccine/shop |

### Đặt lịch & Giỏ hàng
| Trang | URL |
|-------|-----|
| Đặt lịch hẹn | /PetVaccine/booking |
| Lịch hẹn của tôi | /PetVaccine/schedule |
| Giỏ hàng | /PetVaccine/cart |

### Trang Admin
| Trang | URL |
|-------|-----|
| Dashboard | /PetVaccine/pages/admin/dashboard |
| Quản lý lịch hẹn | /PetVaccine/pages/admin/appointments |
| Quản lý sản phẩm | /PetVaccine/pages/admin/products |
| Quản lý người dùng | /PetVaccine/admin/users |
| Quản lý bác sĩ | /PetVaccine/admin/doctors |
| Quản lý dịch vụ | /PetVaccine/admin/services |
| Quản lý vaccine | /PetVaccine/pages/admin/vaccines |
| Đặt phòng khách sạn | /PetVaccine/admin/hotel-bookings |
| Đặt lịch spa | /PetVaccine/admin/spa-bookings |
| Quản lý blog | /PetVaccine/pages/admin/blogs |

## 📁 Cấu Trúc Project

```
PetVaccine/
├── pom.xml                         # Maven config
├── db.sql                          # Database schema + data
├── sample_data.sql                 # Dữ liệu mẫu
├── start_tomat.bat                 # Script chạy Tomcat + mở browser
├── scripts/
│   ├── deploy.bat                  # Build & deploy WAR
│   └── stop.bat                    # Dừng Tomcat
│
├── src/main/java/
│   ├── Context/
│   │   └── DBContext.java          # Kết nối MySQL
│   ├── Model/                      # Entity classes
│   │   ├── User.java
│   │   ├── Pet.java
│   │   ├── Appointment.java
│   │   ├── Product.java
│   │   ├── Service.java
│   │   ├── Vaccine.java
│   │   └── ...
│   ├── DAO/                        # Data Access Objects
│   │   ├── UserDAO.java
│   │   ├── AppointmentDAO.java
│   │   ├── ProductDAO.java
│   │   └── ...
│   ├── Filter/                     # Servlet Filters
│   │   ├── AuthFilter.java
│   │   └── CharacterEncodingFilter.java
│   ├── Util/                       # Utility classes
│   │   ├── EmailUtil.java
│   │   ├── ValidationUtil.java
│   │   └── ...
│   └── controller/                 # Servlets
│       ├── auth/                   # Login, Register, Logout
│       ├── admin/                  # Admin pages
│       ├── booking/                # Đặt lịch
│       ├── shop/                   # Giỏ hàng, thanh toán
│       ├── services/               # Các dịch vụ
│       └── pages/                  # Trang công khai
│
└── src/main/webapp/
    ├── pages/
    │   ├── main/                   # home, about, services...
    │   ├── auth/                   # login, register
    │   ├── admin/                  # Admin dashboard, management
    │   ├── services/               # vaccine, spa, hotel...
    │   └── user/                   # my-pets, vaccination-history
    ├── shopping/                   # cart, product detail
    ├── components/                 # Shared JSP components
    │   ├── navbar.jsp
    │   ├── footer.jsp
    │   ├── admin-sidebar.jsp
    │   └── ...
    ├── assets/
    │   ├── css/
    │   ├── js/
    │   └── images/
    └── WEB-INF/
        └── web.xml
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
© 2026 PetVaccine - Animal Doctors
