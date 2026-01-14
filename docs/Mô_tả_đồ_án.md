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
| Admin | Quản lý toàn bộ hệ thống |

### 1.3 Các module chính
1. **Quản lý người dùng**: Đăng ký, đăng nhập, quên mật khẩu
2. **Đặt lịch hẹn**: Đặt lịch khám, tiêm vaccine, spa, khách sạn
3. **Siêu thị thú cưng**: Mua sắm sản phẩm, giỏ hàng, thanh toán
4. **Quản lý thú cưng**: Thêm/sửa/xóa thú cưng, lịch sử tiêm chủng
5. **Trang Admin**: Dashboard, quản lý lịch hẹn, sản phẩm, người dùng...

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
├── Context/          # Kết nối database
├── Model/            # Entity classes (POJO)
├── DAO/              # Data Access Objects
├── Filter/           # Servlet Filters
├── Util/             # Utility classes
└── controller/       # Servlets (Controller)
    ├── auth/         # Xác thực
    ├── admin/        # Quản trị
    ├── booking/      # Đặt lịch
    ├── shop/         # Mua sắm
    └── ...

src/main/webapp/
├── pages/            # JSP pages (View)
├── components/       # Shared components
├── assets/           # Static resources
└── WEB-INF/          # Config files
```

---

## 3. CÔNG NGHỆ SỬ DỤNG

### 3.1 Backend

| Công nghệ | Phiên bản | Mô tả |
|-----------|-----------|-------|
| Java | 11+ | Ngôn ngữ lập trình chính |
| Java Servlet | 4.0 | Xử lý HTTP request/response |
| JSP (JavaServer Pages) | 2.3 | Template engine cho View |
| JSTL | 1.2 | Tag library cho JSP |
| JDBC | - | Kết nối và thao tác database |
| JavaMail API | 1.6.2 | Gửi email (OTP, thông báo) |

### 3.2 Frontend

| Công nghệ | Mô tả |
|-----------|-------|
| HTML5 | Cấu trúc trang web |
| CSS3 | Styling, animations |
| JavaScript (ES6+) | Xử lý logic phía client |
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
| Eclipse IDE | Môi trường phát triển |
| Git | Version control |
| GitHub | Lưu trữ source code |

---

## 4. KỸ THUẬT WEB SỬ DỤNG

### 4.1 Server-side

#### Servlet & JSP
```java
// Servlet xử lý request
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, 
                          HttpServletResponse response) {
        // Xử lý đăng nhập
    }
}
```

#### JDBC - Kết nối Database
```java
// DBContext.java
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection(url, user, password);

// DAO Pattern
PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE id=?");
ps.setInt(1, userId);
ResultSet rs = ps.executeQuery();
```

#### Servlet Filter
```java
// AuthFilter - Kiểm tra đăng nhập
@WebFilter("/admin/*")
public class AuthFilter implements Filter {
    public void doFilter(request, response, chain) {
        if (session.getAttribute("user") == null) {
            response.sendRedirect("/login");
        }
    }
}

// CharacterEncodingFilter - Xử lý UTF-8
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
```

#### Session Management
```java
// Lưu thông tin đăng nhập
HttpSession session = request.getSession();
session.setAttribute("user", user);
session.setAttribute("cart", cartMap);

// Đọc từ session
User user = (User) session.getAttribute("user");
```

#### JSTL & EL (Expression Language)
```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty user}">
    Xin chào, ${user.fullname}
</c:if>

<c:forEach items="${products}" var="p">
    ${p.name} - ${p.price}đ
</c:forEach>
```

### 4.2 Client-side

#### Responsive Design
```css
/* Mobile-first approach */
@media (max-width: 768px) {
    .sidebar { display: none; }
}
```

#### AJAX (Asynchronous JavaScript)
```javascript
// Cập nhật giỏ hàng không reload trang
fetch('/cart?action=update&id=' + productId)
    .then(response => response.json())
    .then(data => updateCartUI(data));
```

#### Form Validation
```javascript
// Client-side validation
function validateForm() {
    if (email.value === '') {
        showError('Email không được để trống');
        return false;
    }
}
```

#### Modal & Toast Notifications
```javascript
// Bootstrap Modal
var modal = new bootstrap.Modal(document.getElementById('deleteModal'));
modal.show();

// Custom Toast
showToast('Thêm vào giỏ hàng thành công!', 'success');
```

### 4.3 Security (Bảo mật)

#### 4.3.1 Authentication (Xác thực người dùng)

**Session-based Authentication**
```java
// Khi đăng nhập thành công - lưu user vào session
HttpSession session = request.getSession();
session.setAttribute("user", user);
session.setAttribute("role", user.getRole()); // "admin", "user", "doctor"

// Khi đăng xuất - hủy session
session.invalidate();

// Kiểm tra đăng nhập
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("/login");
}
```

**OTP (One-Time Password) qua Email**
```java
// OTPUtil.java - Tạo mã OTP 6 số
public static String generateOTP() {
    Random random = new Random();
    return String.format("%06d", random.nextInt(1000000));
}

// Gửi OTP qua email khi quên mật khẩu
EmailUtil.sendOTPEmail(email, otp);
session.setAttribute("otp", otp);
session.setAttribute("otpExpiry", System.currentTimeMillis() + 5*60*1000); // 5 phút
```

#### 4.3.2 Authorization (Phân quyền)

**Servlet Filter - Kiểm tra quyền truy cập**
```java
// AuthFilter.java
@WebFilter(urlPatterns = {"/pages/admin/*", "/admin/*"})
public class AuthFilter implements Filter {
    
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        
        // Kiểm tra đã đăng nhập chưa
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Kiểm tra quyền admin
        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        chain.doFilter(request, response);
    }
}
```

**Phân quyền theo URL**
| URL Pattern | Quyền truy cập |
|-------------|----------------|
| `/home`, `/about`, `/services` | Public (ai cũng xem được) |
| `/login`, `/register` | Guest only (chưa đăng nhập) |
| `/booking`, `/cart`, `/schedule` | User đã đăng nhập |
| `/pages/admin/*`, `/admin/*` | Admin only |

#### 4.3.3 SQL Injection Prevention (Chống SQL Injection)

**❌ Cách SAI - Dễ bị tấn công**
```java
// KHÔNG BAO GIỜ làm thế này!
String query = "SELECT * FROM users WHERE username='" + username + "'";
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(query);
// Hacker có thể nhập: ' OR '1'='1
```

**✅ Cách ĐÚNG - Dùng PreparedStatement**
```java
// Luôn dùng PreparedStatement với tham số ?
String query = "SELECT * FROM users WHERE username = ? AND password = ?";
PreparedStatement ps = conn.prepareStatement(query);
ps.setString(1, username);  // Tự động escape ký tự đặc biệt
ps.setString(2, password);
ResultSet rs = ps.executeQuery();
```

**Ví dụ trong project (UserDAO.java)**
```java
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

#### 4.3.4 XSS Prevention (Chống Cross-Site Scripting)

**Output Encoding trong JSP**
```jsp
<%-- JSTL tự động escape HTML --%>
<p>Xin chào, ${user.fullname}</p>

<%-- Nếu user.fullname = "<script>alert('XSS')</script>" --%>
<%-- Sẽ hiển thị: &lt;script&gt;alert('XSS')&lt;/script&gt; --%>

<%-- Tránh dùng scriptlet với out.print() --%>
<%-- ❌ SAI: <% out.print(request.getParameter("name")); %> --%>
```

**Input Validation (ValidationUtil.java)**
```java
public class ValidationUtil {
    // Kiểm tra email hợp lệ
    public static boolean isValidEmail(String email) {
        String regex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email != null && email.matches(regex);
    }
    
    // Kiểm tra số điện thoại
    public static boolean isValidPhone(String phone) {
        return phone != null && phone.matches("^0[0-9]{9,10}$");
    }
    
    // Loại bỏ ký tự nguy hiểm
    public static String sanitize(String input) {
        if (input == null) return null;
        return input.replaceAll("[<>\"'&]", "");
    }
}
```

#### 4.3.5 Character Encoding (Xử lý UTF-8)

**CharacterEncodingFilter.java**
```java
@WebFilter("/*")
public class CharacterEncodingFilter implements Filter {
    
    public void doFilter(ServletRequest request, ServletResponse response, 
                         FilterChain chain) throws IOException, ServletException {
        // Set UTF-8 cho request và response
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        chain.doFilter(request, response);
    }
}
```

**Cấu hình MySQL UTF-8**
```java
// DBContext.java
String url = "jdbc:mysql://localhost:3306/petvaccine" +
             "?useUnicode=true" +
             "&characterEncoding=UTF-8" +
             "&characterSetResults=UTF-8";
```

#### 4.3.6 Session Security

**Cấu hình Session trong web.xml**
```xml
<session-config>
    <session-timeout>30</session-timeout> <!-- 30 phút -->
    <cookie-config>
        <http-only>true</http-only>  <!-- Chống XSS đọc cookie -->
        <secure>false</secure>        <!-- true nếu dùng HTTPS -->
    </cookie-config>
</session-config>
```

**Regenerate Session ID sau khi đăng nhập**
```java
// Chống Session Fixation Attack
HttpSession oldSession = request.getSession(false);
if (oldSession != null) {
    oldSession.invalidate();
}
HttpSession newSession = request.getSession(true);
newSession.setAttribute("user", user);
```

#### 4.3.7 Password Security

**Lưu trữ mật khẩu**
```java
// Hiện tại: Lưu plain text (không khuyến khích)
// Khuyến nghị: Dùng BCrypt hoặc SHA-256 + Salt

// Ví dụ với SHA-256
import java.security.MessageDigest;

public static String hashPassword(String password) {
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
    StringBuilder hexString = new StringBuilder();
    for (byte b : hash) {
        hexString.append(String.format("%02x", b));
    }
    return hexString.toString();
}
```

#### 4.3.8 Tổng kết Security

| Lỗ hổng | Biện pháp phòng chống | Áp dụng trong project |
|---------|----------------------|----------------------|
| SQL Injection | PreparedStatement | ✅ Tất cả DAO |
| XSS | JSTL auto-escape, Input validation | ✅ JSP pages |
| CSRF | (Chưa implement) | ⚠️ Cần thêm |
| Session Hijacking | HttpOnly cookie | ✅ web.xml |
| Broken Auth | Session-based, Filter | ✅ AuthFilter |
| Sensitive Data | UTF-8 encoding | ✅ EncodingFilter |

### 4.4 File Upload (Servlet 3.0 API)

#### 4.4.1 Cấu hình @MultipartConfig

Servlet 3.0 cung cấp API native để xử lý file upload mà không cần thư viện bên ngoài như Apache Commons FileUpload.

```java
@WebServlet("/pages/admin/products")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB - ngưỡng lưu vào bộ nhớ
    maxFileSize = 1024 * 1024 * 5,        // 5 MB - kích thước file tối đa
    maxRequestSize = 1024 * 1024 * 20     // 20 MB - kích thước request tối đa
)
public class ProductServlet extends HttpServlet {
    // ...
}
```

#### 4.4.2 Xử lý File Upload trong Servlet

```java
// Lấy file từ request
Part filePart = request.getPart("imageFile");

if (filePart != null && filePart.getSize() > 0) {
    // Lấy tên file gốc
    String fileName = getSubmittedFileName(filePart);
    
    // Validate loại file
    String contentType = filePart.getContentType();
    if (!isValidImageType(contentType)) {
        // Báo lỗi: chỉ chấp nhận ảnh
        return;
    }
    
    // Tạo tên file unique
    String extension = getFileExtension(fileName);
    String newFileName = "product_" + UUID.randomUUID().toString().substring(0, 8) 
                       + "_" + System.currentTimeMillis() + extension;
    
    // Lưu file vào thư mục
    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs();
    }
    
    String filePath = uploadPath + File.separator + newFileName;
    filePart.write(filePath);
}
```

#### 4.4.3 Helper Methods

```java
// Lấy tên file từ Part header
private String getSubmittedFileName(Part part) {
    String contentDisp = part.getHeader("content-disposition");
    if (contentDisp != null) {
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1)
                           .trim().replace("\"", "");
            }
        }
    }
    return null;
}

// Kiểm tra loại file ảnh hợp lệ
private boolean isValidImageType(String contentType) {
    return contentType != null && (
        contentType.equals("image/jpeg") ||
        contentType.equals("image/png") ||
        contentType.equals("image/gif") ||
        contentType.equals("image/webp")
    );
}

// Lấy extension của file
private String getFileExtension(String fileName) {
    int lastDot = fileName.lastIndexOf('.');
    if (lastDot > 0) {
        return fileName.substring(lastDot).toLowerCase();
    }
    return ".jpg";
}
```

#### 4.4.4 Form HTML với enctype multipart

```html
<form method="post" enctype="multipart/form-data">
    <input type="hidden" name="action" value="add">
    <input type="hidden" name="existingImage" id="formExistingImage">
    
    <input type="text" name="name" required>
    <input type="file" name="imageFile" accept="image/*">
    <input type="number" name="price" required>
    
    <button type="submit">Lưu sản phẩm</button>
</form>
```

#### 4.4.5 Áp dụng trong Project

| Servlet | Thư mục Upload | Max Size |
|---------|---------------|----------|
| ProductServlet | `assets/images/shop_pic/` | 5 MB |
| BlogServlet | `assets/images/community_pic/` | 10 MB |

### 4.5 Design Patterns

| Pattern | Áp dụng |
|---------|---------|
| MVC | Tách biệt Model-View-Controller |
| DAO (Data Access Object) | Tách logic truy cập database |
| Singleton | DBContext connection |
| Front Controller | Servlet điều hướng request |

---

## 5. LUỒNG XỬ LÝ END-TO-END

### 5.1 Luồng Đặt Lịch Tiêm Vaccine (User)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    LUỒNG ĐẶT LỊCH TIÊM VACCINE                              │
└─────────────────────────────────────────────────────────────────────────────┘

[1] USER TRUY CẬP TRANG ĐẶT LỊCH
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ Browser → GET /booking                                                       │
│                                                                              │
│ BookingServlet.doGet():                                                      │
│   1. Kiểm tra user đã đăng nhập (session.getAttribute("user"))              │
│   2. Nếu chưa → redirect /login                                             │
│   3. Lấy danh sách thú cưng: PetDAO.getPetsByUserId(userId)                 │
│   4. Lấy danh sách dịch vụ: ServiceDAO.getAllServices()                     │
│   5. Lấy danh sách bác sĩ: DoctorDAO.getAllDoctors()                        │
│   6. Forward → /pages/main/booking.jsp                                       │
└─────────────────────────────────────────────────────────────────────────────┘
    │
    ▼
[2] USER ĐIỀN FORM ĐẶT LỊCH
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ booking.jsp hiển thị:                                                        │
│   - Dropdown chọn thú cưng (từ pets của user)                               │
│   - Dropdown chọn dịch vụ (Tiêm vaccine, Khám bệnh, Spa...)                 │
│   - Dropdown chọn bác sĩ                                                     │
│   - Date picker chọn ngày hẹn                                               │
│   - Textarea ghi chú                                                         │
│                                                                              │
│ JavaScript validation:                                                       │
│   - Kiểm tra đã chọn thú cưng                                               │
│   - Kiểm tra đã chọn dịch vụ                                                │
│   - Kiểm tra ngày hẹn >= ngày hiện tại                                      │
└─────────────────────────────────────────────────────────────────────────────┘
    │
    ▼
[3] USER SUBMIT FORM
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ Browser → POST /booking                                                      │
│                                                                              │
│ BookingServlet.doPost():                                                     │
│   1. request.setCharacterEncoding("UTF-8")                                  │
│   2. Lấy parameters: petId, serviceId, doctorId, bookingDate, notes         │
│   3. Server-side validation:                                                 │
│      - Kiểm tra petId thuộc về user hiện tại                                │
│      - Kiểm tra serviceId tồn tại                                           │
│      - Kiểm tra bookingDate hợp lệ                                          │
│   4. Tạo Appointment object                                                  │
│   5. AppointmentDAO.insertAppointment(appointment)                          │
│      → INSERT INTO appointments (user_id, pet_id, service_id, ...)          │
│   6. Gửi email xác nhận: EmailUtil.sendBookingConfirmation(...)             │
│   7. session.setAttribute("message", "Đặt lịch thành công!")                │
│   8. redirect → /schedule                                                    │
└─────────────────────────────────────────────────────────────────────────────┘
    │
    ▼
[4] HIỂN THỊ LỊCH HẸN
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ Browser → GET /schedule                                                      │
│                                                                              │
│ ScheduleServlet.doGet():                                                     │
│   1. Lấy userId từ session                                                   │
│   2. AppointmentDAO.getAppointmentsByUserId(userId)                         │
│      → SELECT a.*, p.name as pet_name, s.name as service_name, ...          │
│   3. Forward → /pages/main/schedule.jsp                                      │
│                                                                              │
│ schedule.jsp hiển thị:                                                       │
│   - Danh sách lịch hẹn dạng card/table                                      │
│   - Trạng thái: Chờ duyệt / Đã duyệt / Đã hủy / Hoàn thành                  │
│   - Nút "Hủy lịch" cho các lịch chưa hoàn thành                             │
└─────────────────────────────────────────────────────────────────────────────┘
    │
    ▼
[5] ADMIN DUYỆT LỊCH HẸN
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ Browser → GET /pages/admin/appointments                                      │
│                                                                              │
│ AppointmentServlet.doGet():                                                  │
│   1. Kiểm tra role = "admin" (AuthFilter)                                   │
│   2. AppointmentDAO.getAllAppointments()                                    │
│   3. Forward → /pages/admin/appointments.jsp                                 │
│                                                                              │
│ Admin click "Duyệt" → POST /pages/admin/appointments                        │
│   action=approve, appointmentId=123                                          │
│                                                                              │
│ AppointmentServlet.doPost():                                                 │
│   1. AppointmentDAO.updateStatus(appointmentId, "approved")                 │
│   2. Gửi email thông báo cho user                                           │
│   3. redirect với message "Đã duyệt lịch hẹn"                               │
└─────────────────────────────────────────────────────────────────────────────┘
    │
    ▼
[6] HOÀN THÀNH - GHI NHẬN TIÊM CHỦNG
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ Sau khi tiêm vaccine xong, Admin ghi nhận:                                   │
│                                                                              │
│ Browser → POST /pages/admin/vaccination-records                              │
│   action=add, petId, vaccineId, vaccinationDate, nextDueDate, notes         │
│                                                                              │
│ VaccinationRecordServlet.doPost():                                           │
│   1. Tạo VaccinationRecord object                                           │
│   2. VaccinationRecordDAO.insert(record)                                    │
│      → INSERT INTO vaccination_records (pet_id, vaccine_id, ...)            │
│   3. Cập nhật trạng thái appointment = "completed"                          │
│   4. Gửi email thông báo hoàn thành cho user                                │
│                                                                              │
│ User có thể xem lịch sử tiêm chủng tại /vaccination-history                 │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.2 Luồng Mua Sản Phẩm (User)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    LUỒNG MUA SẢN PHẨM                                        │
└─────────────────────────────────────────────────────────────────────────────┘

[1] USER XEM DANH SÁCH SẢN PHẨM
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ Browser → GET /shop                                                          │
│                                                                              │
│ ShopServlet.doGet():                                                         │
│   1. ProductDAO.getAllProducts()                                            │
│      → SELECT * FROM products WHERE status = 'active'                       │
│   2. Forward → /pages/services/shop.jsp                                      │
│                                                                              │
│ shop.jsp hiển thị:                                                           │
│   - Grid sản phẩm với ảnh, tên, giá, giảm giá                               │
│   - Nút "Thêm vào giỏ" cho mỗi sản phẩm                                     │
│   - Bộ lọc theo danh mục, giá                                               │
└─────────────────────────────────────────────────────────────────────────────┘
    │
    ▼
[2] USER THÊM SẢN PHẨM VÀO GIỎ HÀNG
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ JavaScript AJAX call:                                                        │
│   fetch('/cart?action=add&productId=123&quantity=1')                        │
│                                                                              │
│ CartServlet.doGet() hoặc doPost():                                          │
│   1. Lấy productId, quantity từ request                                     │
│   2. Kiểm tra user đã đăng nhập:                                            │
│      - Nếu CHƯA: Lưu vào session cart (Map<Integer, CartItem>)              │
│      - Nếu RỒI: Lưu vào database + session                                  │
│                                                                              │
│   // Lưu vào session                                                         │
│   Map<Integer, CartItem> cart = (Map) session.getAttribute("cart");         │
│   if (cart == null) cart = new HashMap<>();                                 │
│                                                                              │
│   if (cart.containsKey(productId)) {                                        │
│       cart.get(productId).setQuantity(cart.get(productId).getQuantity()+1); │
│   } else {                                                                   │
│       Product p = ProductDAO.getProductById(productId);                     │
│       cart.put(productId, new CartItem(p, 1));                              │
│   }                                                                          │
│   session.setAttribute("cart", cart);                                        │
│                                                                              │
│   // Nếu đã đăng nhập, sync vào database                                    │
│   if (user != null) {                                                        │
│       CartDAO.addToCart(userId, productId, quantity);                       │
│   }                                                                          │
│                                                                              │
│   3. Trả về JSON: {"success": true, "cartCount": 5}                         │
│   4. JavaScript cập nhật badge số lượng trên icon giỏ hàng                  │
└─────────────────────────────────────────────────────────────────────────────┘
    │
    ▼
[3] USER XEM GIỎ HÀNG
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ Browser → GET /cart                                                          │
│                                                                              │
│ CartServlet.doGet():                                                         │
│   1. Lấy cart từ session                                                     │
│   2. Nếu user đã đăng nhập: CartDAO.getCartByUserId(userId)                 │
│   3. Tính tổng tiền, áp dụng giảm giá                                       │
│   4. Forward → /shopping/cart.jsp                                            │
│                                                                              │
│ cart.jsp hiển thị:                                                           │
│   - Danh sách sản phẩm trong giỏ                                            │
│   - Input số lượng (có thể +/- hoặc nhập trực tiếp)                         │
│   - Nút xóa từng sản phẩm                                                   │
│   - Tổng tiền, phí ship, giảm giá                                           │
│   - Nút "Thanh toán"                                                         │
└─────────────────────────────────────────────────────────────────────────────┘
    │
    ▼
[4] USER CẬP NHẬT SỐ LƯỢNG / XÓA SẢN PHẨM
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ AJAX: /cart?action=update&productId=123&quantity=3                          │
│ AJAX: /cart?action=remove&productId=123                                     │
│                                                                              │
│ CartServlet:                                                                 │
│   action=update:                                                             │
│     - Cập nhật quantity trong session cart                                  │
│     - Nếu đã đăng nhập: CartDAO.updateQuantity(userId, productId, qty)      │
│                                                                              │
│   action=remove:                                                             │
│     - Xóa khỏi session cart                                                 │
│     - Nếu đã đăng nhập: CartDAO.removeFromCart(userId, productId)           │
│                                                                              │
│   Trả về JSON với tổng tiền mới để JavaScript cập nhật UI                   │
└─────────────────────────────────────────────────────────────────────────────┘
    │
    ▼
[5] USER THANH TOÁN
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ Browser → POST /checkout                                                     │
│                                                                              │
│ CheckoutServlet.doPost():                                                    │
│   1. Kiểm tra user đã đăng nhập                                             │
│   2. Lấy thông tin giao hàng: fullname, phone, address                      │
│   3. Validation thông tin                                                    │
│   4. Tạo Order:                                                              │
│      - OrderDAO.createOrder(userId, totalAmount, shippingInfo)              │
│      - INSERT INTO orders (user_id, total, status, ...)                     │
│   5. Tạo OrderItems cho từng sản phẩm:                                      │
│      - INSERT INTO order_items (order_id, product_id, quantity, price)      │
│   6. Xóa giỏ hàng:                                                          │
│      - session.removeAttribute("cart")                                       │
│      - CartDAO.clearCart(userId)                                            │
│   7. Gửi email xác nhận đơn hàng                                            │
│   8. Redirect → /order-success?orderId=xxx                                  │
│                                                                              │
│ (Hiện tại: Thanh toán COD - Thanh toán khi nhận hàng)                       │
│ (Tương lai: Tích hợp VNPay, Momo, ZaloPay)                                  │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.3 Luồng Thêm Sản Phẩm (Admin)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    LUỒNG THÊM SẢN PHẨM (ADMIN)                               │
└─────────────────────────────────────────────────────────────────────────────┘

[1] ADMIN TRUY CẬP TRANG QUẢN LÝ SẢN PHẨM
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ Browser → GET /pages/admin/products                                          │
│                                                                              │
│ AuthFilter kiểm tra:                                                         │
│   - session.getAttribute("user") != null                                    │
│   - user.getRole().equals("admin")                                          │
│   - Nếu không → redirect /login                                             │
│                                                                              │
│ ProductServlet.doGet():                                                      │
│   1. ProductDAO.getAllProducts()                                            │
│   2. ProductDAO.getTotalProducts()                                          │
│   3. ProductDAO.getDiscountedProducts()                                     │
│   4. request.setAttribute("products", products)                             │
│   5. Forward → /pages/admin/products.jsp                                     │
│                                                                              │
│ products.jsp hiển thị:                                                       │
│   - Thống kê: Tổng SP, Đang giảm giá, Giá gốc                               │
│   - Bảng danh sách sản phẩm                                                 │
│   - Nút "Thêm sản phẩm" → mở Modal                                          │
└─────────────────────────────────────────────────────────────────────────────┘
    │
    ▼
[2] ADMIN MỞ MODAL THÊM SẢN PHẨM
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ JavaScript: openAddModal()                                                   │
│   - Reset form fields                                                        │
│   - Set formAction = "add"                                                   │
│   - Hiển thị modal                                                           │
│                                                                              │
│ Modal form bao gồm:                                                          │
│   - Tên sản phẩm (required)                                                 │
│   - Ảnh sản phẩm (file upload với drag & drop)                              │
│   - Giá bán (required, format VND)                                          │
│   - Giảm giá (0-100%)                                                       │
│   - Mô tả sản phẩm                                                          │
└─────────────────────────────────────────────────────────────────────────────┘
    │
    ▼
[3] ADMIN UPLOAD ẢNH SẢN PHẨM
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ Cách 1: Click "Chọn ảnh" → chọn file từ máy                                 │
│ Cách 2: Kéo thả file vào vùng preview                                       │
│                                                                              │
│ JavaScript handleFileSelect(event):                                          │
│   1. Lấy file từ event.target.files[0]                                      │
│   2. Kiểm tra file.type.startsWith('image/')                                │
│   3. Kiểm tra file.size <= 5MB                                              │
│   4. FileReader đọc file → hiển thị preview                                 │
│   5. File sẽ được gửi kèm form khi submit                                   │
│                                                                              │
│ <form enctype="multipart/form-data">                                        │
│   <input type="file" name="imageFile" accept="image/*">                     │
│ </form>                                                                      │
└─────────────────────────────────────────────────────────────────────────────┘
    │
    ▼
[4] ADMIN SUBMIT FORM
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ Browser → POST /pages/admin/products                                         │
│ Content-Type: multipart/form-data                                            │
│                                                                              │
│ ProductServlet.doPost():                                                     │
│                                                                              │
│   // 1. Đọc parameters                                                       │
│   String action = request.getParameter("action");        // "add"           │
│   String name = request.getParameter("name");                               │
│   String priceStr = request.getParameter("price");                          │
│   String discountStr = request.getParameter("discount");                    │
│   String description = request.getParameter("description");                 │
│                                                                              │
│   // 2. Validation                                                           │
│   if (name == null || name.trim().isEmpty()) {                              │
│       errors.append("Tên sản phẩm không được để trống");                    │
│   }                                                                          │
│   if (price <= 0) {                                                          │
│       errors.append("Giá bán phải lớn hơn 0");                              │
│   }                                                                          │
│                                                                              │
│   // 3. Xử lý File Upload (Servlet 3.0 API)                                 │
│   Part filePart = request.getPart("imageFile");                             │
│   String imageName = null;                                                   │
│                                                                              │
│   if (filePart != null && filePart.getSize() > 0) {                         │
│       // Validate file type                                                  │
│       String contentType = filePart.getContentType();                       │
│       if (!isValidImageType(contentType)) {                                 │
│           return error("Chỉ chấp nhận file ảnh!");                          │
│       }                                                                      │
│                                                                              │
│       // Generate unique filename                                            │
│       String extension = getFileExtension(fileName);                        │
│       imageName = "product_" + UUID.randomUUID().toString().substring(0,8)  │
│                 + "_" + System.currentTimeMillis() + extension;             │
│                                                                              │
│       // Save file to disk                                                   │
│       String uploadPath = getServletContext().getRealPath("")               │
│                         + File.separator + "assets/images/shop_pic";        │
│       filePart.write(uploadPath + File.separator + imageName);              │
│   }                                                                          │
│                                                                              │
│   // 4. Lưu vào Database                                                     │
│   ProductDAO.addProduct(name, imageName, price, discount, description);     │
│   → INSERT INTO products (name, image, price, discount, description)        │
│                                                                              │
│   // 5. Redirect với thông báo                                               │
│   session.setAttribute("message", "Thêm sản phẩm thành công!");             │
│   response.sendRedirect("/pages/admin/products");                           │
└─────────────────────────────────────────────────────────────────────────────┘
    │
    ▼
[5] HIỂN THỊ KẾT QUẢ
    │
    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ Browser redirect → GET /pages/admin/products                                 │
│                                                                              │
│ products.jsp:                                                                │
│   - Hiển thị Toast thông báo "Thêm sản phẩm thành công!"                    │
│   - Danh sách sản phẩm đã được cập nhật với sản phẩm mới                    │
│   - Ảnh sản phẩm hiển thị từ: /assets/images/shop_pic/{imageName}           │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.4 Sơ đồ tổng quan các luồng

```
                                    ┌─────────────┐
                                    │   BROWSER   │
                                    └──────┬──────┘
                                           │
                    ┌──────────────────────┼──────────────────────┐
                    │                      │                      │
                    ▼                      ▼                      ▼
            ┌───────────────┐      ┌───────────────┐      ┌───────────────┐
            │  AuthFilter   │      │ EncodingFilter│      │    Servlet    │
            │ (Phân quyền)  │      │   (UTF-8)     │      │  (Controller) │
            └───────┬───────┘      └───────┬───────┘      └───────┬───────┘
                    │                      │                      │
                    └──────────────────────┼──────────────────────┘
                                           │
                                           ▼
                                    ┌─────────────┐
                                    │     DAO     │
                                    │ (Data Layer)│
                                    └──────┬──────┘
                                           │
                                           ▼
                                    ┌─────────────┐
                                    │   MySQL     │
                                    │  Database   │
                                    └─────────────┘
```

---

## 6. CƠ SỞ DỮ LIỆU

### 6.1 Các bảng chính

| Bảng | Mô tả |
|------|-------|
| users | Thông tin người dùng |
| pets | Thú cưng của người dùng |
| appointments | Lịch hẹn khám/tiêm |
| services | Các dịch vụ (khám, tiêm, spa...) |
| doctors | Thông tin bác sĩ |
| products | Sản phẩm siêu thị |
| cart | Giỏ hàng |
| vaccines | Danh sách vaccine |
| vaccination_records | Lịch sử tiêm chủng |
| hotel_bookings | Đặt phòng khách sạn |
| spa_bookings | Đặt lịch spa |
| blogs | Bài viết cộng đồng |

### 6.2 Quan hệ giữa các bảng

```
users (1) ──────< (n) pets
users (1) ──────< (n) appointments
users (1) ──────< (n) cart
pets (1) ──────< (n) vaccination_records
appointments (n) >────── (1) services
appointments (n) >────── (1) doctors
vaccination_records (n) >────── (1) vaccines
```

---

## 7. TÍNH NĂNG CHI TIẾT

### 7.1 Người dùng (User)
- ✅ Đăng ký / Đăng nhập / Đăng xuất
- ✅ Quên mật khẩu (gửi OTP qua email)
- ✅ Đặt lịch hẹn (khám, tiêm vaccine, spa, khách sạn)
- ✅ Xem và hủy lịch hẹn
- ✅ Quản lý thú cưng
- ✅ Xem lịch sử tiêm chủng
- ✅ Mua sắm sản phẩm
- ✅ Giỏ hàng và thanh toán

### 7.2 Admin
- ✅ Dashboard thống kê
- ✅ Quản lý lịch hẹn (duyệt/từ chối)
- ✅ Quản lý người dùng
- ✅ Quản lý bác sĩ
- ✅ Quản lý dịch vụ
- ✅ Quản lý sản phẩm
- ✅ Quản lý vaccine
- ✅ Quản lý đặt phòng khách sạn
- ✅ Quản lý đặt lịch spa
- ✅ Quản lý blog/bài viết
-  Gửi email thông báo(đang hoàn thiện)

---

## 8. HƯỚNG PHÁT TRIỂN

- [ ] Tích hợp thanh toán online (VNPay, Momo)
- [ ] Thêm tính năng chat realtime
- [ ] Ứng dụng mobile (React Native / Flutter)
- [ ] Migrate sang Jakarta EE (Tomcat 10+)
- [ ] Thêm REST API cho mobile app
- [ ] Tích hợp AI chatbot hỗ trợ khách hàng

---

## 9. THÔNG TIN LIÊN HỆ

- **GitHub**: https://github.com/normuwu/LTW_Project
- **Môn học**: Lập trình Web
- **Năm**:2025-2026

---

© 2026 PetVaccine - Animal Doctors
