# 🐾 PetVaccine - Animal Doctors

Website quản lý dịch vụ tiêm vaccine và chăm sóc thú cưng.

## ⚡ Hướng Dẫn Nhanh (Quick Start)

```bash
# 1. Clone project
git clone -b new-update --single-branch https://github.com/normuwu/LTW_Project.git

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
git clone -b new-update --single-branch https://github.com/normuwu/LTW_Project.git
```

---

### 🔷 Cách 1: Chạy bằng Eclipse

**Bước 1: Import Project**
1. File → Import → Maven → **Existing Maven Projects**
2. Browse → Chọn thư mục project vừa clone → Finish
3. Đợi Eclipse download dependencies (góc phải dưới có progress bar)

**Bước 2: Cấu hình Tomcat Server**
1. Window → Preferences → Server → **Runtime Environments**
2. Click **Add** → Apache Tomcat v9.0 → Next
3. Browse → Chọn thư mục Tomcat 9 đã cài → Finish

**Bước 3: Thêm Project vào Server**
1. Mở tab **Servers** (Window → Show View → Servers)
2. Click phải vào Tomcat → **Add and Remove...**
3. Chọn PetVaccine → Add → Finish

**Bước 4: Chạy Project**
1. Click phải vào Tomcat Server → **Start**
2. Mở trình duyệt: http://localhost:8080/PetVaccine/home

---

### 🔶 Cách 2: Chạy bằng IntelliJ IDEA

**Bước 1: Import Project**
1. File → **Open** → Chọn thư mục project
2. IntelliJ sẽ tự nhận diện Maven project
3. Đợi IntelliJ download dependencies (góc phải dưới có progress bar)

**Bước 2: Cấu hình Tomcat Server**
1. Run → **Edit Configurations**
2. Click **+** → Tomcat Server → **Local**
3. Tab **Server**: Click **Configure** → Chọn thư mục Tomcat 9
4. Tab **Deployment**: 
   - Click **+** → **Artifact**
   - Chọn **PetVaccine:war exploded**
   - Application context: `/PetVaccine`
5. Click **OK**

**Bước 3: Chạy Project**
1. Click nút **Run** (hoặc Shift+F10)
2. Mở trình duyệt: http://localhost:8080/PetVaccine/home

---

### 🔹 Cách 3: Chạy bằng Command Line (không cần IDE)

Dùng các script có sẵn trong thư mục `scripts/`:
```bash
scripts\setup.bat        # Kiểm tra môi trường + build
scripts\import-db.bat    # Import database
scripts\config-tomcat.bat # Cấu hình đường dẫn Tomcat
scripts\deploy.bat       # Build + deploy WAR
start.bat                # Khởi động Tomcat
```

---

> 💡 **Lưu ý:** Dù chạy bằng cách nào, bạn vẫn cần:
> - Import database (chạy `scripts\import-db.bat` hoặc import `db.sql` thủ công)
> - Cấu hình `DBContext.java` với password MySQL của bạn

### Bước 1: Cài đặt phần mềm cần thiết

#### 1.1 Cài Java JDK 11+
```bash
# Kiểm tra Java đã cài chưa
java -version

# Nếu chưa có, tải và cài từ: https://adoptium.net/
```

#### 1.2 Cài Maven
```bash
# Kiểm tra Maven đã cài chưa
mvn -version
```

**Nếu chưa có Maven:**
1. Tải từ: https://maven.apache.org/download.cgi (chọn file `apache-maven-x.x.x-bin.zip`)
2. Giải nén vào thư mục (VD: `C:\apache-maven-3.9.6`)
3. **Thêm vào PATH:**
   - Nhấn `Windows + R`, gõ `sysdm.cpl`, Enter
   - Chọn tab **Advanced** → Click **Environment Variables**
   - Trong **System variables**, tìm `Path`, click **Edit**
   - Click **New**, thêm: `C:\apache-maven-3.9.6\bin` (đường dẫn thư mục bin của Maven)
   - Click **OK** để lưu
4. **Mở CMD mới** và gõ `mvn -version` để kiểm tra

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
private final String password = "MySQL"  // ← Sửa password của bạn
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
