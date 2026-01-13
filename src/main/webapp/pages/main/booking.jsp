<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Đặt Lịch Hẹn - Animal Doctors</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap');
        
        :root {
            --primary: #00bfa5;
            --primary-dark: #00897b;
            --primary-light: #e0f2f1;
            --secondary: #ff7043;
            --dark: #263238;
            --gray: #607d8b;
            --light-gray: #eceff1;
            --white: #ffffff;
            --shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 20px 60px rgba(0, 0, 0, 0.15);
        }
        
        body {
            font-family: 'Nunito', sans-serif;
            background: linear-gradient(135deg, #e0f7fa 0%, #f5f5f5 50%, #fff8e1 100%);
            min-height: 100vh;
            padding-top: 80px !important;
        }
        
        /* Navbar font override - giữ nguyên Montserrat cho navbar */
        nav#navbar-main,
        nav#navbar-main * {
            font-family: 'Montserrat', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
        }
        nav#navbar-main i.bx {
            font-family: 'boxicons' !important;
        }
        
        /* Fix dropdown z-index - CRITICAL */
        .dropdown-menu {
            z-index: 999999 !important;
            position: absolute !important;
        }
        
        /* Fix navbar dropdown */
        nav#navbar-main .dropdown-menu {
            z-index: 999999 !important;
            position: absolute !important;
            top: 100% !important;
            right: 0 !important;
            left: auto !important;
        }
        
        /* Ensure booking container doesn't overlap */
        .booking-container {
            position: relative;
            z-index: 10;
        }
        
        /* Hero Section */
        .booking-hero {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
            padding: 60px 0 120px;
            text-align: center;
            color: white;
            position: relative;
            overflow: hidden;
        }
        .booking-hero::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="20" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="40" r="3" fill="rgba(255,255,255,0.1)"/><circle cx="40" cy="80" r="2" fill="rgba(255,255,255,0.1)"/></svg>');
            opacity: 0.5;
        }
        .booking-hero h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 10px;
            position: relative;
        }
        .booking-hero p {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
        }
        .booking-hero i {
            font-size: 3rem;
            margin-bottom: 15px;
            display: block;
        }
        
        /* Main Container */
        .booking-container {
            max-width: 900px;
            margin: -80px auto 60px;
            padding: 0 20px;
            position: relative;
            z-index: 10;
        }
        
        /* Booking Card */
        .booking-card {
            background: var(--white);
            border-radius: 24px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }
        
        /* Progress Steps */
        .booking-steps {
            display: flex;
            background: var(--light-gray);
            padding: 20px 30px;
            gap: 10px;
        }
        .step {
            flex: 1;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 16px;
            border-radius: 12px;
            background: white;
            transition: all 0.3s;
        }
        .step.active {
            background: var(--primary);
            color: white;
        }
        .step-number {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: var(--light-gray);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 0.9rem;
        }
        .step.active .step-number {
            background: white;
            color: var(--primary);
        }
        .step-text {
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        /* Form Body */
        .booking-body {
            padding: 40px;
        }
        
        /* Section Title */
        .section-title {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            padding-bottom: 12px;
            border-bottom: 2px solid var(--light-gray);
        }
        .section-title i {
            width: 44px;
            height: 44px;
            background: var(--primary-light);
            color: var(--primary);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
        }
        .section-title h3 {
            margin: 0;
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--dark);
        }

        /* Form Grid */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }
        .form-grid.single {
            grid-template-columns: 1fr;
        }
        
        /* Form Group */
        .form-group {
            position: relative;
        }
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        .form-label {
            display: block;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 8px;
            font-size: 0.95rem;
        }
        .form-label .required {
            color: var(--secondary);
        }
        .form-label i {
            margin-right: 6px;
            color: var(--primary);
        }
        
        /* Input Styles */
        .form-input, .form-select, .form-textarea {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid var(--light-gray);
            border-radius: 12px;
            font-size: 1rem;
            font-family: inherit;
            transition: all 0.3s;
            background: var(--white);
        }
        .form-input:focus, .form-select:focus, .form-textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(0, 191, 165, 0.1);
        }
        .form-input::placeholder {
            color: #b0bec5;
        }
        .form-textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        /* Pet Type Cards */
        .pet-type-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
        }
        .pet-type-card {
            padding: 16px;
            border: 2px solid var(--light-gray);
            border-radius: 14px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: white;
        }
        .pet-type-card:hover {
            border-color: var(--primary);
            transform: translateY(-2px);
        }
        .pet-type-card.selected {
            border-color: var(--primary);
            background: var(--primary-light);
        }
        .pet-type-card input {
            display: none;
        }
        .pet-type-card .pet-icon {
            font-size: 2rem;
            margin-bottom: 6px;
            display: block;
        }
        .pet-type-card .pet-name {
            font-weight: 600;
            color: var(--dark);
            font-size: 0.9rem;
        }
        
        /* Service Cards */
        .service-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 14px;
        }
        .service-card {
            padding: 18px;
            border: 2px solid var(--light-gray);
            border-radius: 14px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 14px;
            background: white;
        }
        .service-card:hover {
            border-color: var(--primary);
            transform: translateY(-2px);
        }
        .service-card.selected {
            border-color: var(--primary);
            background: var(--primary-light);
        }
        .service-card input {
            display: none;
        }
        .service-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.4rem;
            flex-shrink: 0;
        }
        .service-info h4 {
            margin: 0 0 4px 0;
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--dark);
        }
        .service-info p {
            margin: 0;
            font-size: 0.85rem;
            color: var(--gray);
        }
        
        /* Submit Button */
        .btn-submit {
            width: 100%;
            padding: 18px 32px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            border: none;
            border-radius: 14px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: 0 8px 25px rgba(0, 191, 165, 0.3);
        }
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(0, 191, 165, 0.4);
        }
        .btn-submit i {
            font-size: 1.3rem;
        }
        
        /* Info Box */
        .info-box {
            background: linear-gradient(135deg, #fff8e1 0%, #ffecb3 100%);
            border-radius: 14px;
            padding: 18px 20px;
            margin-bottom: 30px;
            display: flex;
            align-items: flex-start;
            gap: 14px;
        }
        .info-box i {
            color: #ff8f00;
            font-size: 1.5rem;
            flex-shrink: 0;
        }
        .info-box p {
            margin: 0;
            color: #5d4037;
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .booking-hero h1 { font-size: 1.8rem; }
            .booking-body { padding: 24px; }
            .form-grid { grid-template-columns: 1fr; }
            .pet-type-grid { grid-template-columns: repeat(2, 1fr); }
            .service-grid { grid-template-columns: 1fr; }
            .booking-steps { flex-direction: column; padding: 16px; }
        }
    </style>
</head>
<body>
    <jsp:include page="/components/navbar.jsp" />
    <jsp:include page="/components/toast-notification.jsp" />

    <section class="booking-hero">
        <i class='bx bxs-calendar-heart'></i>
        <h1>Đặt Lịch Khám Online</h1>
        <p>Chăm sóc sức khỏe thú cưng của bạn chỉ với vài bước đơn giản</p>
    </section>

    <div class="booking-container">
        <div class="booking-card">
            <div class="booking-steps">
                <div class="step active">
                    <span class="step-number">1</span>
                    <span class="step-text">Thông tin</span>
                </div>
                <div class="step active">
                    <span class="step-number">2</span>
                    <span class="step-text">Dịch vụ</span>
                </div>
                <div class="step active">
                    <span class="step-number">3</span>
                    <span class="step-text">Xác nhận</span>
                </div>
            </div>
            
            <div class="booking-body">
                <form action="${pageContext.request.contextPath}/booking" method="post" id="bookingForm">
                    
                    <div class="section-title">
                        <i class='bx bxs-user-circle'></i>
                        <h3>Thông tin chủ nuôi</h3>
                    </div>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">
                                <i class='bx bx-user'></i> Họ và tên <span class="required">*</span>
                            </label>
                            <input type="text" name="customerName" class="form-input" 
                                   placeholder="Nhập họ tên của bạn" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <i class='bx bx-phone'></i> Số điện thoại <span class="required">*</span>
                            </label>
                            <input type="tel" name="phone" id="phoneInput" class="form-input" 
                                   placeholder="VD: 0901234567" required
                                   maxlength="10" pattern="0[0-9]{9}" inputmode="numeric">
                            <small class="phone-error" style="color: #ef4444; font-size: 0.8rem; margin-top: 4px; display: none;">
                                Số điện thoại phải gồm 10 chữ số và bắt đầu bằng 0
                            </small>
                        </div>
                    </div>

                    <div class="section-title">
                        <i class='bx bxs-dog'></i>
                        <h3>Thông tin thú cưng</h3>
                    </div>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">
                                <i class='bx bx-rename'></i> Tên thú cưng
                            </label>
                            <input type="text" name="petName" class="form-input" 
                                   placeholder="Mimi, Lucky, Bông..."
                                   value="${selectedPetName != null ? selectedPetName : ''}">
                            <input type="hidden" name="petId" value="${selectedPetId != null ? selectedPetId : ''}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <i class='bx bx-category'></i> Loại thú cưng <span class="required">*</span>
                            </label>
                            <select name="petType" id="petTypeSelect" class="form-select" required onchange="toggleCustomPetType()">
                                <option value="">-- Chọn loại thú cưng --</option>
                                <option value="Chó" ${selectedPetType == 'Chó' ? 'selected' : ''}>🐕 Chó</option>
                                <option value="Mèo" ${selectedPetType == 'Mèo' ? 'selected' : ''}>🐱 Mèo</option>
                                <option value="Chim" ${selectedPetType == 'Chim' ? 'selected' : ''}>🐦 Chim</option>
                                <option value="Thỏ" ${selectedPetType == 'Thỏ' ? 'selected' : ''}>🐰 Thỏ</option>
                                <option value="Hamster" ${selectedPetType == 'Hamster' ? 'selected' : ''}>🐹 Hamster</option>
                                <option value="Khác" ${selectedPetType == 'Khác' ? 'selected' : ''}>🐾 Khác</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-grid" id="customPetTypeRow" style="display: none;">
                        <div class="form-group full-width">
                            <label class="form-label">
                                <i class='bx bx-edit'></i> Nhập loại thú cưng <span class="required">*</span>
                            </label>
                            <input type="text" name="customPetType" id="customPetType" class="form-input" 
                                   placeholder="Ví dụ: Rùa, Cá, Bò sát...">
                        </div>
                    </div>
                    
                    <div class="section-title">
                        <i class='bx bxs-first-aid'></i>
                        <h3>Chọn dịch vụ</h3>
                    </div>
                    
                    <div class="service-grid">
                        <label class="service-card" onclick="selectService(this, '1')">
                            <input type="radio" name="serviceId" value="1" ${selectedService == '1' || empty selectedService ? 'checked' : ''}>
                            <div class="service-icon"><i class='bx bx-plus-medical'></i></div>
                            <div class="service-info">
                                <h4>Khám & Điều trị</h4>
                                <p>Từ 150.000đ</p>
                            </div>
                        </label>
                        <label class="service-card" onclick="selectService(this, '2')">
                            <input type="radio" name="serviceId" value="2" ${selectedService == '2' ? 'checked' : ''}>
                            <div class="service-icon"><i class='bx bx-cut'></i></div>
                            <div class="service-info">
                                <h4>Phẫu thuật</h4>
                                <p>Theo ca phẫu thuật</p>
                            </div>
                        </label>
                        <label class="service-card" onclick="selectService(this, '3')">
                            <input type="radio" name="serviceId" value="3" ${selectedService == '3' ? 'checked' : ''}>
                            <div class="service-icon"><i class='bx bx-injection'></i></div>
                            <div class="service-info">
                                <h4>Tiêm phòng Vaccine</h4>
                                <p>Tùy loại vaccine</p>
                            </div>
                        </label>
                        <label class="service-card" onclick="selectService(this, '4')">
                            <input type="radio" name="serviceId" value="4" ${selectedService == '4' ? 'checked' : ''}>
                            <div class="service-icon"><i class='bx bx-spa'></i></div>
                            <div class="service-info">
                                <h4>Spa & Làm đẹp</h4>
                                <p>Từ 350.000đ</p>
                            </div>
                        </label>
                        <label class="service-card" onclick="selectService(this, '5')">
                            <input type="radio" name="serviceId" value="5" ${selectedService == '5' ? 'checked' : ''}>
                            <div class="service-icon"><i class='bx bx-home-heart'></i></div>
                            <div class="service-info">
                                <h4>Khách sạn thú cưng</h4>
                                <p>200.000đ/ngày</p>
                            </div>
                        </label>
                    </div>
                    
                    <div class="section-title" style="margin-top: 30px;">
                        <i class='bx bxs-calendar'></i>
                        <h3>Lịch hẹn</h3>
                    </div>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">
                                <i class='bx bx-calendar-event'></i> Ngày hẹn <span class="required">*</span>
                            </label>
                            <input type="date" name="bookingDate" class="form-input" required id="bookingDate">
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <i class='bx bx-user-pin'></i> Bác sĩ (không bắt buộc)
                            </label>
                            <select name="doctorId" class="form-select">
                                <option value="0">-- Để phòng khám chỉ định --</option>
                                <c:forEach items="${listDoctors}" var="d">
                                    <option value="${d.id}">${d.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-grid single">
                        <div class="form-group">
                            <label class="form-label">
                                <i class='bx bx-note'></i> Triệu chứng / Ghi chú
                            </label>
                            <textarea name="note" class="form-textarea" 
                                      placeholder="Mô tả triệu chứng hoặc yêu cầu đặc biệt..."></textarea>
                        </div>
                    </div>
                    
                    <div class="info-box">
                        <i class='bx bx-info-circle'></i>
                        <p>Sau khi đặt lịch, nhân viên sẽ liên hệ xác nhận trong vòng 30 phút (giờ làm việc). Vui lòng giữ điện thoại để nhận cuộc gọi.</p>
                    </div>
                    
                    <button type="submit" class="btn-submit">
                        <i class='bx bx-calendar-check'></i>
                        Xác Nhận Đặt Lịch
                    </button>
                    
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/components/footer.jsp" />
    
    <div class="modal fade" id="successModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 20px; border: none; overflow: hidden; position: relative;">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" 
                        style="position: absolute; top: 16px; right: 16px; z-index: 10;"></button>
                <div class="modal-body text-center" style="padding: 40px;">
                    <div style="width: 100px; height: 100px; background: linear-gradient(135deg, #d1fae5, #a7f3d0); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 24px;">
                        <i class='bx bx-check' style="font-size: 4rem; color: #10b981;"></i>
                    </div>
                    <h4 style="color: #263238; font-weight: 700; margin-bottom: 12px;">Đặt lịch thành công!</h4>
                    <p style="color: #607d8b; margin-bottom: 24px; line-height: 1.6;">
                        Cảm ơn bạn đã đặt lịch hẹn tại Animal Doctors.<br>
                        Nhân viên sẽ liên hệ xác nhận trong vòng <strong>30 phút</strong> (giờ làm việc).
                    </p>
                    <div style="background: #f5f5f5; border-radius: 12px; padding: 16px; margin-bottom: 24px; text-align: left;">
                        <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                            <i class='bx bx-info-circle' style="color: #00bfa5;"></i>
                            <span style="font-weight: 600; color: #263238;">Lưu ý:</span>
                        </div>
                        <ul style="margin: 0; padding-left: 20px; color: #607d8b; font-size: 0.9rem;">
                            <li>Vui lòng giữ điện thoại để nhận cuộc gọi xác nhận</li>
                            <li>Bạn có thể xem và quản lý lịch hẹn tại trang "Lịch hẹn của tôi"</li>
                        </ul>
                    </div>
                    <div style="display: flex; gap: 12px; justify-content: center;">
                        <a href="${pageContext.request.contextPath}/schedule" class="btn" style="background: linear-gradient(135deg, #00bfa5, #00897b); color: white; padding: 14px 28px; border-radius: 12px; font-weight: 600; text-decoration: none;">
                            <i class='bx bx-calendar-check'></i> Xem lịch hẹn
                        </a>
                        <button type="button" class="btn" data-bs-dismiss="modal" onclick="resetBookingForm()" style="background: #eceff1; color: #607d8b; padding: 14px 28px; border-radius: 12px; font-weight: 600; border: none;">
                            <i class='bx bx-plus'></i> Đặt lịch mới
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Set min date to today
        document.addEventListener('DOMContentLoaded', function() {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById('bookingDate').setAttribute('min', today);
            
            // Initialize selected service
            initSelectedService();
            
            // Phone validation
            initPhoneValidation();
            
            // Check if booking success
            <c:if test="${not empty success}">
                var successModal = new bootstrap.Modal(document.getElementById('successModal'));
                successModal.show();
            </c:if>
        });
        
        function initPhoneValidation() {
            var phoneInput = document.getElementById('phoneInput');
            var phoneError = document.querySelector('.phone-error');
            
            // Only allow numbers
            phoneInput.addEventListener('input', function(e) {
                // Remove non-numeric characters
                this.value = this.value.replace(/[^0-9]/g, '');
                
                // Validate format
                validatePhone();
            });
            
            phoneInput.addEventListener('blur', function() {
                validatePhone();
            });
            
            // Prevent form submit if phone invalid
            document.getElementById('bookingForm').addEventListener('submit', function(e) {
                if (!validatePhone()) {
                    e.preventDefault();
                    phoneInput.focus();
                }
            });
        }
        
        function validatePhone() {
            var phoneInput = document.getElementById('phoneInput');
            var phoneError = document.querySelector('.phone-error');
            var value = phoneInput.value;
            
            // Check if starts with 0 and has exactly 10 digits
            var isValid = /^0[0-9]{9}$/.test(value);
            
            if (value.length > 0 && !isValid) {
                phoneError.style.display = 'block';
                phoneInput.style.borderColor = '#ef4444';
                return false;
            } else {
                phoneError.style.display = 'none';
                phoneInput.style.borderColor = '';
                return value.length === 0 || isValid;
            }
        }
        
        function toggleCustomPetType() {
            var select = document.getElementById('petTypeSelect');
            var customRow = document.getElementById('customPetTypeRow');
            var customInput = document.getElementById('customPetType');
            
            if (select.value === 'Khác') {
                customRow.style.display = 'grid';
                customInput.required = true;
            } else {
                customRow.style.display = 'none';
                customInput.required = false;
                customInput.value = '';
            }
        }
        
        function selectService(card, value) {
            // Remove selected from all
            document.querySelectorAll('.service-card').forEach(function(c) {
                c.classList.remove('selected');
            });
            // Add selected to clicked
            card.classList.add('selected');
        }
        
        function initSelectedService() {
            var checked = document.querySelector('input[name="serviceId"]:checked');
            if (checked) {
                checked.closest('.service-card').classList.add('selected');
            } else {
                // Default select first
                var first = document.querySelector('.service-card');
                if (first) {
                    first.classList.add('selected');
                    first.querySelector('input').checked = true;
                }
            }
        }
        
        function resetBookingForm() {
            document.getElementById('bookingForm').reset();
            document.querySelectorAll('.service-card').forEach(function(c) {
                c.classList.remove('selected');
            });
            var first = document.querySelector('.service-card');
            if (first) {
                first.classList.add('selected');
                first.querySelector('input').checked = true;
            }
            document.getElementById('customPetTypeRow').style.display = 'none';
        }
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>