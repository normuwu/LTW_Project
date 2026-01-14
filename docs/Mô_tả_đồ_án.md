# 📋 MÔ TẢ CHI TIẾT ĐỒ ÁN

## 🐾 Tên đồ án: PetVaccine - Animal Doctors

Website quản lý dịch vụ tiêm vaccine và chăm sóc thú cưng toàn diện.

---

## 1. TỔNG QUAN

### 1.1 Mục tiêu
- Xây dựng hệ thống quản lý phòng khám thú y trực tuyến
- Cho phép khách hàng đặt lịch hẹn, mua sản phẩm, theo dõi lịch sử tiêm chủng
- Cung cấp giao diện quản trị cho admin quản lý toàn bộ hệ thống

### 1.2 Đối tượng sử dụng
| Vai trò | Chức năng chính |
|---------|-----------------|
| Khách (Guest) | Xem thông tin, đăng ký tài khoản |
| Người dùng (User) | Đặt lịch hẹn, mua hàng, quản lý thú cưng |
| Bác sĩ (Doctor) | Xem lịch hẹn, ghi nhận tiêm chủng |
| Admin | Quản lý toàn bộ hệ thống |

### 1.3 Các module chính
1. **Quản lý người dùng**: Đăng ký, đăng nhập, quên mật khẩu (OTP qua email)
2. **Đặt lịch hẹn**: Đặt lịch khám, tiêm vaccine, spa, khách sạn thú cưng
3. **Siêu thị thú cưng**: Mua sắm sản phẩm, giỏ hàng, thanh toán
4. **Quản lý thú cưng**: Thêm/sửa/xóa thú cưng, lịch sử tiêm chủng
5. **Trang Admin**: Dashboard, quản lý lịch hẹn, sản phẩm, người dùng, bác sĩ, vaccine...
6. **Blog/Cộng đồng**: Chia sẻ kiến thức chăm sóc thú cưng

---

## 2. KIẾN TRÚC HỆ THỐNG

### 2.1 Mô hình MVC (Model-View-Controller)

```
┌─────────────────────────────────────────────────────────────┐
│                        CLIENT (Browser)                      │
│                    HTML, CSS, JavaScript                     │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                     CONTROLLER (Servlet)                     │
│         Xử lý request, điều hướng, gọi business logic       │
│    LoginServlet, BookingServlet, ProductServlet, ...        │
└─────────────────────────────────────────────────────────────┘
                              │
              ┌───────────────┴───────────────┐
              ▼                               ▼
┌─────────────────────────┐     ┌─────────────────────────────┐
│      VIEW (JSP)         │     │      MODEL (Java Bean)      │
│   Hiển thị giao diện    │     │   Entity: User, Pet, ...    │
│   home.jsp, login.jsp   │     │   DAO: UserDAO, PetDAO      │
└─────────────────────────┘     └─────────────────────────────┘
                                              │
                                              ▼
                              ┌─────────────────────────────────┐
                              │        DATABASE (MySQL)         │
                              │     Lưu trữ dữ liệu hệ thống    │
                              └─────────────────────────────────┘
```

### 2.2 Cấu trúc thư mục

```
src/main/java/
├── Context/          # Kết nối database (DBContext.java)
├── Model/            # Entity classes (POJO)
│   ├── User.java           # Người dùng
│   ├── Pet.java            # Thú cưng
│   ├── Appointment.java    # Lịch hẹn
│   ├── Product.java        # Sản phẩm
│   ├── Service.java        # Dịch vụ
│   ├── Vaccine.java        # Vaccine
│   ├── VaccinationRecord.java  # Lịch sử tiêm chủng
│   ├── Doctors.java        # Bác sĩ
│   ├── BlogPost.java       # Bài viết blog
│   ├── CartItem.java       # Giỏ hàng
│   └── Review.java         # Đánh giá sản phẩm
├── DAO/              # Data Access Objects
│   ├── UserDAO.java
│   ├── PetDAO.java
│   ├── AppointmentDAO.java
│   ├── ProductDAO.java
│   ├── ServiceDAO.java
│   ├── VaccineDAO.java
│   ├── VaccinationRecordDAO.java
│   ├── DoctorDAO.java
│   ├── BlogDAO.java
│   ├── CartDAO.java
│   └── ReportDAO.java
├── Filter/           # Servlet Filters
│   ├── AuthFilter.java              # Kiểm tra đăng nhập & phân quyền
│   └── CharacterEncodingFilter.java # Xử lý UTF-8
├── Util/             # Utility classes
│   ├── EmailUtil.java       # Gửi email
│   ├── EmailConfig.java     # Cấu hình email
│   ├── OTPUtil.java         # Tạo mã OTP
│   ├── ValidationUtil.java  # Validate dữ liệu
│   ├── FormHelper.java      # Xử lý form
│   ├── FileUploadUtil.java  # Upload file
│   ├── UploadConfig.java    # Cấu hình upload
│   └── FixVietnameseData.java # Sửa lỗi tiếng Việt
└── controller/       # Servlets (Controller)
    ├── auth/         # Xác thực (Login, Register, Logout, ForgotPassword)
    ├── admin/        # Quản trị (Dashboard, Appointments, Products, Users...)
    ├── booking/      # Đặt lịch (Booking, Schedule)
    ├── shop/         # Mua sắm (Cart, Checkout, AddToCart)
    ├── services/     # Các dịch vụ (Vaccine, Spa, Hotel, Medical, Surgery)
    ├── pages/        # Trang công khai (Home, About, Community)
    └── user/         # Trang user (MyPets, VaccinationHistory)

src/main/webapp/
├── pages/            # JSP pages (View)
│   ├── main/         # home, about, booking, schedule, community, services
│   ├── auth/         # login, register, forgot-password, reset-password
│   ├── admin/        # dashboard, appointments, products, users, doctors...
│   ├── services/     # vaccine, spa, hotel, medical, surgery, shop
│   └── user/         # my-pets, vaccination-history
├── shopping/         # cart.jsp
├── components/       # Shared JSP components
│   ├── navbar.jsp, navbar-white.jsp, navbar-styles.jsp
│   ├── header.jsp, footer.jsp
│   ├── admin-sidebar.jsp, admin-header-dropdown.jsp, admin-styles.jsp
│   ├── alerts.jsp, toast.jsp, toast-notification.jsp
│   ├── cancel-appointment-modal.jsp
│   └── back-button.jsp
├── assets/
│   ├── css/          # Stylesheets
│   ├── js/           # JavaScript files
│   └── images/       # Hình ảnh (shop_pic, community_pic, webpic...)
└── WEB-INF/
    └── web.xml       # Cấu hình web
```

---

## 3. CÔNG NGHỆ SỬ DỤNG

### 3.1 Backend

| Công nghệ | Phiên bản | Mô tả |
|-----------|-----------|-------|
| Java | 11+ | Ngôn ngữ lập trình chính |
| Java Servlet | 4.0.1 | Xử lý HTTP request/response |
| JSP (JavaServer Pages) | 2.3 | Template engine cho View |
| JSTL | 1.2 | Tag library cho JSP |
| JDBC | - | Kết nối và thao tác database |
| JavaMail API | 1.6.2 | Gửi email (OTP, thông báo) |
| Apache Commons FileUpload | 1.5 | Upload file ảnh |
| Apache Commons IO | 2.15.1 | Xử lý I/O |

### 3.2 Frontend

| Công nghệ | Mô tả |
|-----------|-------|
| HTML5 | Cấu trúc trang web |
| CSS3 | Styling, animations, responsive |
| JavaScript (ES6+) | Xử lý logic phía client, AJAX |
| Bootstrap 5 | CSS Framework responsive |
| Boxicons | Icon library |

### 3.3 Database

| Công nghệ | Phiên bản | Mô tả |
|-----------|-----------|-------|
| MySQL | 8.0 | Hệ quản trị CSDL quan hệ |
| MySQL Connector/J | 8.0.33 | JDBC Driver cho MySQL |

### 3.4 Build & Deploy

| Công cụ | Mô tả |
|---------|-------|
| Apache Maven | Build tool, quản lý dependencies |
| Apache Tomcat 9.x | Web server / Servlet container |
| WAR packaging | Đóng gói ứng dụng web |

### 3.5 IDE & Tools

| Công cụ | Mô tả |
|---------|-------|
| Eclipse IDE / IntelliJ IDEA | Môi trường phát triển |
| Git | Version control |
| GitHub | Lưu trữ source code |

---

## 4. CƠ SỞ DỮ LIỆU

### 4.1 Sơ đồ ERD (Entity Relationship Diagram)

```
┌─────────────┐       ┌─────────────┐       ┌─────────────┐
│   USERS     │       │    PETS     │       │  VACCINES   │
├─────────────┤       ├─────────────┤       ├─────────────┤
│ id (PK)     │◄──┐   │ id (PK)     │   ┌──►│ id (PK)     │
│ username    │   │   │ user_id(FK) │───┘   │ name        │
│ password    │   │   │ name        │       │ description │
│ fullname    │   │   │ species     │       │ target_species│
│ email       │   │   │ breed       │       │ manufacturer│
│ role        │   │   │ gender      │       │ price       │
│ status      │   │   │ birth_date  │       │ doses_required│
│ phone       │   │   │ weight      │       │ interval_days│
│ address     │   │   │ color       │       │ stock_quantity│
│ reset_token │   │   │ image       │       └─────────────┘
│ created_at  │   │   │ notes       │              │
└─────────────┘   │   └─────────────┘              │
      │           │          │                     │
      │           │          ▼                     │
      │           │   ┌─────────────────────┐      │
      │           │   │ VACCINATION_RECORDS │      │
      │           │   ├─────────────────────┤      │
      │           │   │ id (PK)             │      │
      │           │   │ pet_id (FK)         │◄─────┘
      │           │   │ vaccine_id (FK)     │
      │           │   │ doctor_id (FK)      │───────┐
      │           │   │ vaccination_date    │       │
      │           │   │ dose_number         │       │
      │           │   │ batch_number        │       │
      │           │   │ next_due_date       │       │
      │           │   │ notes               │       │
      │           │   └─────────────────────┘       │
      │           │                                 │
      ▼           │                                 ▼
┌─────────────┐   │                         ┌─────────────┐
│APPOINTMENTS │   │                         │  DOCTORS    │
├─────────────┤   │                         ├─────────────┤
│ id (PK)     │   │                         │ id (PK)     │
│ user_id(FK) │───┘                         │ name        │
│ customer_name│                            │ image       │
│ phone       │                             │ specialty   │
│ pet_name    │                             │ phone       │
│ pet_type    │                             │ email       │
│ service_id  │───┐                         │ work_schedule│
│ doctor_id   │───┼────────────────────────►│ is_active   │
│ booking_date│   │                         └─────────────┘
│ note        │   │
│ status      │   │
│ created_at  │   │
└─────────────┘   │
                  │
                  ▼
          ┌─────────────┐
          │  SERVICES   │
          ├─────────────┤
          │ id (PK)     │
          │ name        │
          │ price       │
          │ description │
          │ category    │
          │ duration_minutes│
          │ is_active   │
          └─────────────┘
```

### 4.2 Danh sách các bảng

| Bảng | Mô tả | Số bản ghi mẫu |
|------|-------|----------------|
| `users` | Người dùng (admin, doctor, user) | 3 |
| `pets` | Thú cưng của người dùng | 2 |
| `doctors` | Bác sĩ thú y | 12 |
| `services` | Dịch vụ (khám, tiêm, spa, hotel) | 5 |
| `vaccines` | Danh sách vaccine | 5 |
| `appointments` | Lịch hẹn khám/tiêm | 3 |
| `vaccination_records` | Lịch sử tiêm chủng | 3 |
| `hotel_bookings` | Đặt phòng khách sạn thú cưng | 2 |
| `spa_bookings` | Đặt lịch spa/grooming | 2 |
| `products` | Sản phẩm siêu thị | 5 |
| `cart` | Giỏ hàng | 3 |
| `reviews` | Đánh giá sản phẩm | 2 |
| `blogposts` | Bài viết blog | 12 |
| `careitems` | Nội dung chăm sóc | 7 |
| `features` | Tính năng nổi bật | 3 |

---

## 5. CHỨC NĂNG CHI TIẾT

### 5.1 Phân quyền người dùng

| Chức năng | Guest | User | Doctor | Admin |
|-----------|:-----:|:----:|:------:|:-----:|
| Xem trang chủ, giới thiệu | ✅ | ✅ | ✅ | ✅ |
| Xem dịch vụ, blog | ✅ | ✅ | ✅ | ✅ |
| Đăng ký tài khoản | ✅ | ❌ | ❌ | ❌ |
| Đăng nhập | ✅ | ❌ | ❌ | ❌ |
| Đặt lịch hẹn | ❌ | ✅ | ✅ | ✅ |
| Xem lịch hẹn của mình | ❌ | ✅ | ✅ | ✅ |
| Hủy lịch hẹn | ❌ | ✅ | ❌ | ✅ |
| Quản lý thú cưng | ❌ | ✅ | ❌ | ✅ |
| Xem lịch sử tiêm chủng | ❌ | ✅ | ✅ | ✅ |
| Mua sắm, giỏ hàng | ❌ | ✅ | ✅ | ✅ |
| Đánh giá sản phẩm | ❌ | ✅ | ✅ | ✅ |
| Truy cập trang Admin | ❌ | ❌ | ❌ | ✅ |
| Quản lý lịch hẹn (CRUD) | ❌ | ❌ | ❌ | ✅ |
| Quản lý sản phẩm (CRUD) | ❌ | ❌ | ❌ | ✅ |
| Quản lý người dùng | ❌ | ❌ | ❌ | ✅ |
| Quản lý bác sĩ | ❌ | ❌ | ❌ | ✅ |
| Quản lý vaccine | ❌ | ❌ | ❌ | ✅ |
| Quản lý dịch vụ | ❌ | ❌ | ❌ | ✅ |
| Ghi nhận tiêm chủng | ❌ | ❌ | ✅ | ✅ |
| Xem thống kê, báo cáo | ❌ | ❌ | ❌ | ✅ |

### 5.2 Module Xác thực (Authentication)

| Chức năng | Servlet | JSP | Mô tả |
|-----------|---------|-----|-------|
| Đăng nhập | LoginServlet | login.jsp | Username/password |
| Đăng nhập Email | EmailLoginServlet | email-login.jsp | OTP qua email |
| Đăng ký | RegisterServlet | register.jsp | Tạo tài khoản mới |
| Đăng xuất | LogoutServlet | - | Hủy session |
| Quên mật khẩu | ForgotPasswordServlet | forgot-password.jsp | Gửi OTP qua email |
| Đặt lại mật khẩu | ResetPasswordServlet | reset-password.jsp | Nhập mật khẩu mới |

### 5.3 Module Đặt lịch (Booking)

| Chức năng | Servlet | JSP | Mô tả |
|-----------|---------|-----|-------|
| Đặt lịch khám/tiêm | BookingServlet | booking.jsp | Form đặt lịch |
| Xem lịch hẹn | ScheduleServlet | schedule.jsp | Danh sách lịch hẹn |
| Đặt phòng khách sạn | HotelServlet | hotel.jsp | Gửi thú cưng |
| Đặt lịch spa | SpaServlet | spa.jsp | Tắm, cắt tỉa lông |

### 5.4 Module Mua sắm (Shopping)

| Chức năng | Servlet | JSP | Mô tả |
|-----------|---------|-----|-------|
| Xem sản phẩm | ShopServlet | shop.jsp | Danh sách sản phẩm |
| Thêm vào giỏ | AddToCartServlet | - | AJAX call |
| Xem giỏ hàng | CartServlet | cart.jsp | Quản lý giỏ hàng |
| Thanh toán | CheckoutServlet | - | Xử lý đơn hàng |
| Đánh giá | AddReviewServlet | - | Đánh giá sản phẩm |

### 5.5 Module Quản trị (Admin)

| Chức năng | Servlet | JSP | Mô tả |
|-----------|---------|-----|-------|
| Dashboard | DashboardServlet | dashboard.jsp | Tổng quan hệ thống |
| Quản lý lịch hẹn | AppointmentServlet | appointments.jsp | CRUD lịch hẹn |
| Quản lý sản phẩm | ProductServlet | products.jsp | CRUD sản phẩm |
| Quản lý người dùng | UserManageServlet | users.jsp | CRUD users |
| Quản lý bác sĩ | DoctorManageServlet | doctors.jsp | CRUD bác sĩ |
| Quản lý dịch vụ | ServiceManageServlet | services.jsp | CRUD dịch vụ |
| Quản lý vaccine | VaccineManageServlet | vaccines.jsp | CRUD vaccine |
| Ghi nhận tiêm chủng | VaccinationRecordServlet | vaccination-records.jsp | Lịch sử tiêm |
| Quản lý blog | BlogServlet | blogs.jsp | CRUD bài viết |
| Đặt phòng khách sạn | HotelBookingServlet | hotel-bookings.jsp | Quản lý booking |
| Đặt lịch spa | SpaBookingServlet | spa-bookings.jsp | Quản lý booking |
| Thống kê | StatisticsServlet | statistics.jsp | Biểu đồ, số liệu |
| Báo cáo | ReportServlet | reports.jsp | Xuất báo cáo |
| Thông báo | NotificationServlet | notifications.jsp | Gửi thông báo |

### 5.6 Module Người dùng (User)

| Chức năng | Servlet | JSP | Mô tả |
|-----------|---------|-----|-------|
| Quản lý thú cưng | MyPetsServlet | my-pets.jsp | CRUD thú cưng |
| Lịch sử tiêm chủng | VaccinationHistoryServlet | vaccination-history.jsp | Xem lịch sử |

---

## 6. KỸ THUẬT WEB SỬ DỤNG

### 6.1 Server-side

#### Servlet & JSP
```java
// Servlet xử lý request
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, 
                          HttpServletResponse response) {
        // Xử lý đăng nhập
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(username, password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("home");
        }
    }
}
```

#### JDBC - Kết nối Database (DAO Pattern)
```java
// DBContext.java
public class DBContext {
    public Connection getConnection() throws Exception {
        String url = "jdbc:mysql://localhost:3306/petvaccine" +
                     "?useUnicode=true&characterEncoding=UTF-8";
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, "root", "password");
    }
}

// UserDAO.java - PreparedStatement chống SQL Injection
public User login(String username, String password) {
    String query = "SELECT * FROM users WHERE username = ? AND password = ?";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        // ...
    }
}
```

#### Servlet Filter
```java
// AuthFilter - Kiểm tra đăng nhập & phân quyền
@WebFilter(urlPatterns = {"/pages/admin/*", "/admin/*"})
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            ((HttpServletResponse) res).sendRedirect("/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            ((HttpServletResponse) res).sendRedirect("/home");
            return;
        }
        chain.doFilter(req, res);
    }
}

// CharacterEncodingFilter - Xử lý UTF-8
@WebFilter("/*")
public class CharacterEncodingFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, 
                         FilterChain chain) {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        chain.doFilter(request, response);
    }
}
```

#### Session Management
```java
// Lưu thông tin đăng nhập
HttpSession session = request.getSession();
session.setAttribute("user", user);
session.setAttribute("cart", cartMap);

// Đọc từ session
User user = (User) session.getAttribute("user");

// Đăng xuất - hủy session
session.invalidate();
```

#### JSTL & EL (Expression Language)
```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty user}">
    Xin chào, ${user.fullname}
</c:if>

<c:forEach items="${products}" var="p">
    ${p.name} - <fmt:formatNumber value="${p.price}" type="currency"/>
</c:forEach>

<c:choose>
    <c:when test="${user.role == 'admin'}">Admin Panel</c:when>
    <c:otherwise>User Dashboard</c:otherwise>
</c:choose>
```

### 6.2 Client-side

#### Responsive Design (Bootstrap 5)
```html
<div class="container">
    <div class="row">
        <div class="col-lg-4 col-md-6 col-12">
            <!-- Card sản phẩm -->
        </div>
    </div>
</div>
```

```css
/* Mobile-first approach */
@media (max-width: 768px) {
    .sidebar { display: none; }
    .navbar-collapse { background: white; }
}
```

#### AJAX (Fetch API)
```javascript
// Thêm vào giỏ hàng không reload trang
function addToCart(productId) {
    fetch('/cart?action=add&productId=' + productId, {
        method: 'POST'
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            updateCartBadge(data.cartCount);
            showToast('Đã thêm vào giỏ hàng!', 'success');
        }
    });
}
```

#### Form Validation
```javascript
// Client-side validation
function validateForm() {
    const email = document.getElementById('email').value;
    const phone = document.getElementById('phone').value;
    
    if (!email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
        showError('Email không hợp lệ');
        return false;
    }
    
    if (!phone.match(/^0[0-9]{9,10}$/)) {
        showError('Số điện thoại không hợp lệ');
        return false;
    }
    return true;
}
```

#### Modal & Toast Notifications
```javascript
// Bootstrap Modal
const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
modal.show();

// Custom Toast
function showToast(message, type) {
    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;
    toast.textContent = message;
    document.body.appendChild(toast);
    setTimeout(() => toast.remove(), 3000);
}
```

---

## 7. BẢO MẬT (SECURITY)

### 7.1 Authentication (Xác thực người dùng)

**Session-based Authentication**
```java
// Khi đăng nhập thành công
HttpSession session = request.getSession();
session.setAttribute("user", user);
session.setAttribute("role", user.getRole());

// Khi đăng xuất
session.invalidate();
```

**OTP (One-Time Password) qua Email**
```java
// OTPUtil.java - Tạo mã OTP 6 số
public static String generateOTP() {
    Random random = new Random();
    return String.format("%06d", random.nextInt(1000000));
}

// Gửi OTP qua email
EmailUtil.sendOTPEmail(email, otp);
session.setAttribute("otp", otp);
session.setAttribute("otpExpiry", System.currentTimeMillis() + 5*60*1000); // 5 phút
```

### 7.2 Authorization (Phân quyền)

**URL Pattern Authorization**
| URL Pattern | Quyền truy cập |
|-------------|----------------|
| `/home`, `/about`, `/services` | Public |
| `/login`, `/register` | Guest only |
| `/booking`, `/cart`, `/schedule` | User đã đăng nhập |
| `/pages/admin/*`, `/admin/*` | Admin only |

### 7.3 SQL Injection Prevention

```java
// ❌ SAI - Dễ bị tấn công
String query = "SELECT * FROM users WHERE username='" + username + "'";

// ✅ ĐÚNG - Dùng PreparedStatement
String query = "SELECT * FROM users WHERE username = ? AND password = ?";
PreparedStatement ps = conn.prepareStatement(query);
ps.setString(1, username);
ps.setString(2, password);
```

### 7.4 XSS Prevention

```jsp
<%-- JSTL tự động escape HTML --%>
<p>Xin chào, ${user.fullname}</p>
<%-- Nếu fullname = "<script>alert('XSS')</script>" --%>
<%-- Sẽ hiển thị: &lt;script&gt;... --%>
```

```java
// Input Validation (ValidationUtil.java)
public static boolean isValidEmail(String email) {
    return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
}

public static boolean isValidPhone(String phone) {
    return phone != null && phone.matches("^0[0-9]{9,10}$");
}

public static String sanitize(String input) {
    if (input == null) return null;
    return input.replaceAll("[<>\"'&]", "");
}
```

### 7.5 Session Security

```xml
<!-- web.xml -->
<session-config>
    <session-timeout>30</session-timeout>
    <cookie-config>
        <http-only>true</http-only>
    </cookie-config>
</session-config>
```

### 7.6 Tổng kết Security

| Lỗ hổng | Biện pháp | Trạng thái |
|---------|-----------|------------|
| SQL Injection | PreparedStatement | ✅ Đã áp dụng |
| XSS | JSTL auto-escape, Input validation | ✅ Đã áp dụng |
| Session Hijacking | HttpOnly cookie | ✅ Đã áp dụng |
| Broken Auth | Session-based, AuthFilter | ✅ Đã áp dụng |
| UTF-8 Encoding | CharacterEncodingFilter | ✅ Đã áp dụng |
| CSRF | Token-based | ⚠️ Chưa implement |

---

## 8. FILE UPLOAD

### 8.1 Cấu hình @MultipartConfig

```java
@WebServlet("/pages/admin/products")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB
    maxFileSize = 1024 * 1024 * 5,        // 5 MB
    maxRequestSize = 1024 * 1024 * 20     // 20 MB
)
public class ProductServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "assets/images/shop_pic";
}
```

### 8.2 Xử lý Upload

```java
Part filePart = request.getPart("imageFile");

if (filePart != null && filePart.getSize() > 0) {
    String fileName = getSubmittedFileName(filePart);
    String contentType = filePart.getContentType();
    
    // Validate loại file
    if (!isValidImageType(contentType)) {
        // Báo lỗi
        return;
    }
    
    // Tạo tên file unique
    String newFileName = "product_" + UUID.randomUUID().toString().substring(0, 8) 
                       + "_" + System.currentTimeMillis() + getFileExtension(fileName);
    
    // Lưu file
    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
    filePart.write(uploadPath + File.separator + newFileName);
}
```

### 8.3 Form HTML

```html
<form method="post" enctype="multipart/form-data">
    <input type="file" name="imageFile" accept="image/*">
    <button type="submit">Upload</button>
</form>
```

---

## 9. DESIGN PATTERNS

| Pattern | Áp dụng | Mô tả |
|---------|---------|-------|
| MVC | Toàn bộ project | Tách biệt Model-View-Controller |
| DAO | Tất cả DAO classes | Tách logic truy cập database |
| Singleton | DBContext | Quản lý connection |
| Front Controller | Servlet | Điều hướng request |
| Factory | - | Tạo đối tượng |

---

## 10. LUỒNG XỬ LÝ END-TO-END

### 10.1 Luồng Đặt Lịch Tiêm Vaccine

```
[1] User truy cập /booking
    │
    ▼
[2] BookingServlet.doGet()
    ├── Kiểm tra đăng nhập (session)
    ├── Lấy danh sách pets: PetDAO.getPetsByUserId()
    ├── Lấy danh sách services: ServiceDAO.getAllServices()
    ├── Lấy danh sách doctors: DoctorDAO.getAllDoctors()
    └── Forward → booking.jsp
    │
    ▼
[3] User điền form và submit
    │
    ▼
[4] BookingServlet.doPost()
    ├── Validate dữ liệu
    ├── Tạo Appointment object
    ├── AppointmentDAO.insertAppointment()
    ├── Gửi email xác nhận (EmailUtil)
    └── Redirect → /schedule
    │
    ▼
[5] ScheduleServlet.doGet()
    ├── AppointmentDAO.getAppointmentsByUserId()
    └── Forward → schedule.jsp (hiển thị lịch hẹn)
    │
    ▼
[6] Admin duyệt lịch hẹn
    ├── AppointmentServlet.doPost() action=approve
    ├── AppointmentDAO.updateStatus("Confirmed")
    └── Gửi email thông báo cho user
    │
    ▼
[7] Hoàn thành - Ghi nhận tiêm chủng
    ├── VaccinationRecordServlet.doPost() action=add
    ├── VaccinationRecordDAO.insert()
    └── Cập nhật appointment status = "Completed"
```

### 10.2 Luồng Mua Sản Phẩm

```
[1] User xem /shop
    │
    ▼
[2] ShopServlet.doGet()
    ├── ProductDAO.getAllProducts()
    └── Forward → shop.jsp
    │
    ▼
[3] User click "Thêm vào giỏ"
    │
    ▼
[4] AJAX → AddToCartServlet
    ├── Lấy cart từ session
    ├── Thêm/cập nhật CartItem
    ├── Nếu đã đăng nhập: CartDAO.addToCart()
    └── Response JSON: {success: true, cartCount: 5}
    │
    ▼
[5] User xem /cart
    │
    ▼
[6] CartServlet.doGet()
    ├── Lấy cart từ session
    ├── Tính tổng tiền
    └── Forward → cart.jsp
    │
    ▼
[7] User thanh toán
    │
    ▼
[8] CheckoutServlet.doPost()
    ├── Tạo đơn hàng
    ├── Xóa cart
    └── Redirect với message "Đặt hàng thành công"
```

### 10.3 Luồng Đăng nhập

```
[1] User truy cập /login
    │
    ▼
[2] LoginServlet.doGet()
    └── Forward → login.jsp
    │
    ▼
[3] User nhập username/password và submit
    │
    ▼
[4] LoginServlet.doPost()
    ├── UserDAO.login(username, password)
    ├── Nếu thành công:
    │   ├── session.setAttribute("user", user)
    │   └── Redirect → /home
    └── Nếu thất bại:
        └── Forward → login.jsp với error message
```

---

## 11. HƯỚNG DẪN CÀI ĐẶT

### 11.1 Yêu cầu hệ thống

| Phần mềm | Phiên bản | Download |
|----------|-----------|----------|
| Java JDK | 11, 17, 21 | [Adoptium](https://adoptium.net/) |
| Apache Maven | 3.6+ | [Download](https://maven.apache.org/download.cgi) |
| Apache Tomcat | **9.x** | [Download](https://tomcat.apache.org/download-90.cgi) |
| MySQL | 8.0 | [Download](https://dev.mysql.com/downloads/mysql/) |

> ⚠️ **Lưu ý:** Project sử dụng `javax.servlet.*` (Java EE), chỉ tương thích với Tomcat 9.x

### 11.2 Cài đặt nhanh

```bash
# 1. Clone project
git clone -b new-update --single-branch https://github.com/normuwu/LTW_Project.git
cd LTW_Project

# 2. Chạy script setup
scripts\setup.bat

# 3. Cấu hình database
# Mở file: src/main/java/Context/DBContext.java
# Sửa: private final String password = "your_mysql_password";

# 4. Import database
scripts\import-db.bat

# 5. Cấu hình Tomcat
scripts\config-tomcat.bat

# 6. Deploy và chạy
scripts\deploy.bat
start.bat

# 7. Mở trình duyệt: http://localhost:8080/PetVaccine/home
```

### 11.3 Tài khoản mặc định

| Vai trò | Username | Password |
|---------|----------|----------|
| Admin | admin | Admin@123 |
| User | user1 | Thanh@123 |
| Doctor | doctor1 | 123456 |

---

## 12. CÁC TRANG CHÍNH

### 12.1 Trang công khai

| Trang | URL |
|-------|-----|
| Trang chủ | /PetVaccine/home |
| Giới thiệu | /PetVaccine/about |
| Dịch vụ | /PetVaccine/services |
| Cộng đồng | /PetVaccine/community |
| Đăng nhập | /PetVaccine/login |
| Đăng ký | /PetVaccine/register |

### 12.2 Dịch vụ

| Trang | URL |
|-------|-----|
| Tiêm vaccine | /PetVaccine/vaccine |
| Khám bệnh | /PetVaccine/medical |
| Phẫu thuật | /PetVaccine/surgery |
| Spa & Grooming | /PetVaccine/spa |
| Khách sạn thú cưng | /PetVaccine/hotel |
| Siêu thị | /PetVaccine/shop |

### 12.3 Đặt lịch & Giỏ hàng

| Trang | URL |
|-------|-----|
| Đặt lịch hẹn | /PetVaccine/booking |
| Lịch hẹn của tôi | /PetVaccine/schedule |
| Giỏ hàng | /PetVaccine/cart |

### 12.4 Trang Admin

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
| Thống kê | /PetVaccine/pages/admin/statistics |
| Lịch sử tiêm chủng | /PetVaccine/pages/admin/vaccination-records |

### 12.5 Trang User

| Trang | URL |
|-------|-----|
| Thú cưng của tôi | /PetVaccine/my-pets |
| Lịch sử tiêm chủng | /PetVaccine/vaccination-history |

---

## 13. SCREENSHOTS (Giao diện)

### 13.1 Trang chủ
- Hero section với slider
- Giới thiệu dịch vụ
- Đội ngũ bác sĩ
- Đánh giá khách hàng

### 13.2 Trang đặt lịch
- Form đặt lịch với dropdown chọn dịch vụ, bác sĩ
- Date picker chọn ngày hẹn
- Validation form

### 13.3 Trang Admin
- Dashboard với thống kê tổng quan
- Bảng quản lý với pagination
- Modal thêm/sửa/xóa
- Toast notification

---

## 14. HƯỚNG PHÁT TRIỂN

### 14.1 Tính năng có thể mở rộng
- [ ] Thanh toán online (VNPay, Momo)
- [ ] Notification realtime (WebSocket)
- [ ] Chat với bác sĩ
- [ ] Mobile app (React Native)
- [ ] API RESTful cho mobile
- [ ] Đa ngôn ngữ (i18n)
- [ ] Dark mode

### 14.2 Cải thiện bảo mật
- [ ] CSRF Token
- [ ] Password hashing (BCrypt)
- [ ] Rate limiting
- [ ] HTTPS

### 14.3 Cải thiện hiệu năng
- [ ] Connection pooling (HikariCP)
- [ ] Caching (Redis)
- [ ] CDN cho static files
- [ ] Lazy loading images

---

## 15. THÔNG TIN LIÊN HỆ

- **Tên đồ án**: PetVaccine - Animal Doctors
- **Môn học**: Lập trình Web (LTW)
- **Năm học**: 2025-2026
- **Repository**: https://github.com/normuwu/LTW_Project

---

© 2026 PetVaccine - Animal Doctors. All rights reserved.
