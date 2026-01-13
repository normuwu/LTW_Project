<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Khách sạn Mèo - Animal Doctors</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        * {
            font-family: 'Montserrat', sans-serif;
        }
        body {
            margin: 0;
            padding: 0;
        }

        /* Hero Section với Video - giống trang home */
        .hero-section {
            position: relative;
            height: 100vh;
            min-height: 600px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .back-video {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        }
        .hero-content {
            text-align: center;
            color: #fff;
            z-index: 1;
            padding: 0 20px;
        }
        .hero-content h1 {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 20px;
            text-shadow: 2px 4px 8px rgba(0,0,0,0.5);
        }
        .hero-content p {
            font-size: 1.3rem;
            margin-bottom: 30px;
            text-shadow: 1px 2px 4px rgba(0,0,0,0.5);
        }
        .btn-hero {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 16px 40px;
            background: linear-gradient(135deg, #00bfa5 0%, #004d40 100%);
            color: #fff;
            font-weight: 700;
            font-size: 1.1rem;
            border-radius: 50px;
            text-decoration: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }
        .btn-hero:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
            color: #fff;
        }
        .scroll-indicator {
            position: absolute;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            color: #fff;
            font-size: 2rem;
            animation: bounce 2s infinite;
        }
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateX(-50%) translateY(0); }
            40% { transform: translateX(-50%) translateY(-10px); }
            60% { transform: translateX(-50%) translateY(-5px); }
        }

        /* Content Section - nền trắng */
        .content-section {
            background: #fff;
            padding: 80px 0;
        }
        .content-section h2 {
            color: #004d40;
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 25px;
        }
        .content-section p {
            color: #555;
            line-height: 1.8;
            font-size: 1.05rem;
        }
        .content-section h4 {
            color: #00bfa5;
            font-weight: 700;
            margin-top: 30px;
            margin-bottom: 20px;
        }

        /* Check List */
        .check-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .check-list li {
            padding: 12px 0;
            display: flex;
            align-items: center;
            font-size: 1rem;
            color: #333;
            border-bottom: 1px solid #f0f0f0;
        }
        .check-list li:last-child {
            border-bottom: none;
        }
        .check-list li i {
            color: #00bfa5;
            font-size: 1.4rem;
            margin-right: 12px;
        }

        /* Price Box */
        .price-box {
            background: linear-gradient(135deg, #e0f7f4 0%, #b2dfdb 100%);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 40px rgba(0, 77, 64, 0.15);
            border: 2px solid #80cbc4;
        }
        .price-box h3 {
            color: #004d40;
            font-weight: 700;
            margin-bottom: 25px;
            text-align: center;
            font-size: 1.4rem;
        }
        .price-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px dashed #80cbc4;
        }
        .price-item:last-of-type {
            border-bottom: none;
        }
        .price-item span {
            color: #555;
            font-size: 0.95rem;
        }
        .price-tag {
            color: #004d40;
            font-weight: 700;
            font-size: 1rem;
        }
        .btn-booking-now {
            display: block;
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #00bfa5 0%, #004d40 100%);
            color: #fff;
            text-align: center;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 700;
            margin-top: 25px;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(0, 77, 64, 0.3);
        }
        .btn-booking-now:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(0, 77, 64, 0.4);
            color: #fff;
        }

        /* Booking Section */
        .booking-section {
            padding: 80px 0;
            background: linear-gradient(135deg, #e8f5e9 0%, #e0f2f1 100%);
        }
        .booking-card {
            background: white;
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0, 77, 64, 0.15);
            overflow: hidden;
        }
        .booking-header {
            background: linear-gradient(135deg, #00bfa5 0%, #004d40 100%);
            padding: 40px;
            text-align: center;
            color: white;
        }
        .booking-header i {
            font-size: 3rem;
            margin-bottom: 15px;
            display: block;
        }
        .booking-header h2 {
            font-size: 1.8rem;
            font-weight: 800;
            margin: 0 0 10px;
        }
        .booking-header p {
            opacity: 0.9;
            margin: 0;
        }
        .booking-form {
            padding: 40px;
        }
        .form-group {
            margin-bottom: 0;
        }
        .form-group label {
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 600;
            color: #004d40;
            margin-bottom: 10px;
            font-size: 0.95rem;
        }
        .form-group label i {
            color: #00bfa5;
            font-size: 1.2rem;
        }
        .form-group .required {
            color: #ef4444;
        }
        .form-control, .form-select {
            padding: 14px 18px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s;
        }
        .form-control:focus, .form-select:focus {
            border-color: #00bfa5;
            box-shadow: 0 0 0 4px rgba(0, 191, 165, 0.15);
        }
        
        /* Room Packages */
        .room-packages {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 15px;
        }
        .room-package {
            cursor: pointer;
        }
        .room-package input {
            display: none;
        }
        .package-content {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 18px;
            border: 2px solid #e0e0e0;
            border-radius: 16px;
            transition: all 0.3s;
            background: #fafafa;
        }
        .room-package:hover .package-content {
            border-color: #80cbc4;
            background: #e0f7f4;
        }
        .room-package input:checked + .package-content {
            border-color: #00bfa5;
            background: linear-gradient(135deg, #e0f7f4 0%, #b2dfdb 100%);
            box-shadow: 0 4px 15px rgba(0, 191, 165, 0.25);
        }
        .package-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            background: linear-gradient(135deg, #00bfa5 0%, #004d40 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.4rem;
            flex-shrink: 0;
        }
        .room-package.vip .package-icon {
            background: linear-gradient(135deg, #ffd700 0%, #ff8c00 100%);
        }
        .package-info h5 {
            margin: 0 0 4px;
            font-size: 0.95rem;
            font-weight: 700;
            color: #004d40;
        }
        .package-info span {
            font-size: 0.8rem;
            color: #666;
        }
        .package-price {
            margin-left: auto;
            font-weight: 800;
            color: #00bfa5;
            font-size: 1rem;
            white-space: nowrap;
        }
        
        /* Submit Button */
        .btn-submit-booking {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #00bfa5 0%, #004d40 100%);
            color: white;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: 0 10px 30px rgba(0, 77, 64, 0.35);
            transition: all 0.3s;
        }
        .btn-submit-booking:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(0, 77, 64, 0.45);
        }
        .btn-submit-booking i {
            font-size: 1.3rem;
        }
        
        /* Date Range Info */
        .date-range-info {
            background: #e0f7f4;
            border-radius: 12px;
            padding: 15px;
            margin-top: 15px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .date-range-info i {
            color: #00bfa5;
            font-size: 1.5rem;
        }
        .date-range-info .info-text {
            font-size: 0.9rem;
            color: #004d40;
        }
        .date-range-info .nights-count {
            font-weight: 700;
            color: #00bfa5;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero-content h1 {
                font-size: 2.2rem;
            }
            .hero-content p {
                font-size: 1rem;
            }
            .content-section {
                padding: 50px 0;
            }
            .content-section h2 {
                font-size: 1.6rem;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/components/navbar.jsp" />

    <!-- Hero Section với Video -->
    <section class="hero-section">
        <video autoplay muted loop playsinline class="back-video">
            <source src="${pageContext.request.contextPath}/assets/video/catHotel_vid.mp4" type="video/mp4">
        </video>

        <div class="hero-content">
            <h1>Khách Sạn Mèo</h1>
            <p>Không gian nghỉ dưỡng 5 sao dành riêng cho các "Hoàng thượng"</p>
            <a href="#content" class="btn-hero">
                <i class='bx bx-down-arrow-alt'></i> Tìm hiểu thêm
            </a>
        </div>

        <div class="scroll-indicator">
            <i class='bx bx-chevron-down'></i>
        </div>
    </section>

    <!-- Content Section - nền trắng -->
    <section class="content-section" id="content">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 mb-5 mb-lg-0">
                    <h2>Tại sao chọn khách sạn mèo của chúng tôi?</h2>
                    <p>
                        Dành cho những người nuôi mèo cần đi du lịch hoặc công tác xa, khách sạn mèo sang trọng của chúng tôi sẽ giữ cho người bạn đồng hành của bạn luôn an toàn, được nuông chiều và khỏe mạnh.
                    </p>
                    <p>
                        Khác với các lồng nhốt thông thường, chúng tôi thiết kế các "phòng riêng" (Cat Condo) rộng rãi, có hệ thống thông gió riêng biệt để tránh lây nhiễm chéo và giảm stress tối đa cho các bé.
                    </p>

                    <h4>Tiện ích bao gồm:</h4>
                    <ul class="check-list">
                        <li><i class='bx bxs-check-circle'></i> Phòng riêng rộng rãi, yên tĩnh</li>
                        <li><i class='bx bxs-check-circle'></i> Chế độ dinh dưỡng cao cấp (Royal Canin / Pate tươi)</li>
                        <li><i class='bx bxs-check-circle'></i> Vui chơi 30 phút mỗi ngày với nhân viên chăm sóc</li>
                        <li><i class='bx bxs-check-circle'></i> Cập nhật hình ảnh/video cho chủ nuôi hàng ngày</li>
                        <li><i class='bx bxs-check-circle'></i> Bác sĩ thú y kiểm tra sức khỏe mỗi sáng</li>
                    </ul>
                </div>

                <div class="col-lg-5">
                    <div class="price-box">
                        <h3>Bảng Giá Dịch Vụ</h3>
                        
                        <div class="price-item">
                            <span>Phòng Tiêu chuẩn (< 5kg)</span>
                            <strong class="price-tag">150.000đ / ngày</strong>
                        </div>
                        
                        <div class="price-item">
                            <span>Phòng VIP (> 5kg)</span>
                            <strong class="price-tag">250.000đ / ngày</strong>
                        </div>
                        
                        <div class="price-item">
                            <span>Phụ thu Lễ/Tết</span>
                            <strong class="price-tag">+ 50.000đ / ngày</strong>
                        </div>
                        
                        <a href="${pageContext.request.contextPath}/booking?service=5" class="btn-booking-now">
                            <i class='bx bxs-calendar-plus'></i> Đặt Phòng Ngay
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Booking Section -->
    <section class="booking-section" id="booking">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="booking-card">
                        <div class="booking-header">
                            <i class='bx bxs-hotel'></i>
                            <h2>Đặt Phòng Khách Sạn Mèo</h2>
                            <p>Điền thông tin để đặt phòng nghỉ dưỡng cho bé cưng của bạn</p>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/booking" method="POST" class="booking-form">
                            <input type="hidden" name="serviceId" value="5">
                            <input type="hidden" name="source" value="hotel">
                            <input type="hidden" name="petType" value="Mèo">
                            
                            <div class="row g-4">
                                <!-- Thông tin khách hàng -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class='bx bx-user'></i> Họ và tên <span class="required">*</span></label>
                                        <input type="text" name="customerName" class="form-control" required 
                                               placeholder="Nhập họ tên của bạn"
                                               value="${sessionScope.user != null ? sessionScope.user.fullname : ''}">
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class='bx bx-phone'></i> Số điện thoại <span class="required">*</span></label>
                                        <input type="tel" name="phone" class="form-control" required 
                                               placeholder="0901234567" pattern="[0-9]{10,11}"
                                               value="${sessionScope.user != null ? sessionScope.user.phone : ''}">
                                    </div>
                                </div>
                                
                                <!-- Thông tin thú cưng -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class='bx bxs-cat'></i> Tên thú cưng <span class="required">*</span></label>
                                        <input type="text" name="petName" class="form-control" required 
                                               placeholder="Tên bé mèo của bạn">
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class='bx bx-ruler'></i> Cân nặng <span class="required">*</span></label>
                                        <select name="petWeight" class="form-select" required id="petWeight">
                                            <option value="">-- Chọn cân nặng --</option>
                                            <option value="Dưới 5kg">🐱 Dưới 5kg</option>
                                            <option value="Trên 5kg">🐈 Trên 5kg</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- Loại phòng -->
                                <div class="col-12">
                                    <div class="form-group">
                                        <label><i class='bx bxs-bed'></i> Chọn loại phòng <span class="required">*</span></label>
                                        <div class="room-packages">
                                            <label class="room-package">
                                                <input type="radio" name="roomType" value="Phòng Tiêu chuẩn (< 5kg) - 150.000đ/ngày" required>
                                                <div class="package-content">
                                                    <div class="package-icon"><i class='bx bxs-home'></i></div>
                                                    <div class="package-info">
                                                        <h5>Phòng Tiêu chuẩn</h5>
                                                        <span>Dưới 5kg • Phòng riêng, yên tĩnh</span>
                                                    </div>
                                                    <div class="package-price">150.000đ/ngày</div>
                                                </div>
                                            </label>
                                            
                                            <label class="room-package vip">
                                                <input type="radio" name="roomType" value="Phòng VIP (> 5kg) - 250.000đ/ngày">
                                                <div class="package-content">
                                                    <div class="package-icon"><i class='bx bxs-crown'></i></div>
                                                    <div class="package-info">
                                                        <h5>Phòng VIP</h5>
                                                        <span>Trên 5kg • Rộng rãi, tiện nghi cao cấp</span>
                                                    </div>
                                                    <div class="package-price">250.000đ/ngày</div>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Ngày nhận/trả phòng -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class='bx bx-log-in-circle'></i> Ngày nhận phòng <span class="required">*</span></label>
                                        <input type="date" name="bookingDate" class="form-control" required id="checkInDate">
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class='bx bx-log-out-circle'></i> Ngày trả phòng <span class="required">*</span></label>
                                        <input type="date" name="checkOutDate" class="form-control" required id="checkOutDate">
                                    </div>
                                </div>
                                
                                <!-- Thông tin số đêm -->
                                <div class="col-12" id="nightsInfoContainer" style="display: none;">
                                    <div class="date-range-info">
                                        <i class='bx bx-moon'></i>
                                        <div class="info-text">
                                            Tổng thời gian lưu trú: <span class="nights-count" id="nightsCount">0</span> đêm
                                            <span id="holidaySurcharge" style="display: none; color: #ff6b6b; margin-left: 10px;">
                                                (Có phụ thu Lễ/Tết: +50.000đ/ngày)
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Dịch vụ bổ sung -->
                                <div class="col-12">
                                    <div class="form-group">
                                        <label><i class='bx bx-plus-circle'></i> Dịch vụ bổ sung</label>
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="extraServices" value="Chế độ ăn cao cấp (+50.000đ/ngày)" id="premiumFood">
                                                    <label class="form-check-label" for="premiumFood">
                                                        🍖 Chế độ ăn cao cấp (Royal Canin / Pate tươi) +50.000đ/ngày
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="extraServices" value="Vui chơi thêm 30 phút (+30.000đ/ngày)" id="extraPlay">
                                                    <label class="form-check-label" for="extraPlay">
                                                        🎾 Vui chơi thêm 30 phút/ngày +30.000đ/ngày
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="extraServices" value="Tắm spa khi trả phòng (+150.000đ)" id="spaBath">
                                                    <label class="form-check-label" for="spaBath">
                                                        🛁 Tắm spa khi trả phòng +150.000đ
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="extraServices" value="Cập nhật video hàng ngày (+20.000đ/ngày)" id="dailyVideo">
                                                    <label class="form-check-label" for="dailyVideo">
                                                        📹 Cập nhật video hàng ngày +20.000đ/ngày
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Ghi chú -->
                                <div class="col-12">
                                    <div class="form-group">
                                        <label><i class='bx bx-note'></i> Ghi chú / Yêu cầu đặc biệt</label>
                                        <textarea name="note" class="form-control" rows="3" 
                                                  placeholder="Ví dụ: Bé nhát người, cần phòng yên tĩnh, có bệnh nền cần theo dõi, thức ăn riêng..."></textarea>
                                    </div>
                                </div>
                                
                                <!-- Submit -->
                                <div class="col-12">
                                    <button type="submit" class="btn-submit-booking">
                                        <i class='bx bxs-calendar-check'></i> Xác nhận đặt phòng
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />
    <jsp:include page="/components/back-button.jsp" />
    <jsp:include page="/components/toast.jsp" />
   
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const checkInDate = document.getElementById('checkInDate');
            const checkOutDate = document.getElementById('checkOutDate');
            const nightsInfoContainer = document.getElementById('nightsInfoContainer');
            const nightsCount = document.getElementById('nightsCount');
            
            // Set min date for check-in (tomorrow)
            const tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            checkInDate.min = tomorrow.toISOString().split('T')[0];
            
            // Set max date (60 days from now)
            const maxDate = new Date();
            maxDate.setDate(maxDate.getDate() + 60);
            checkInDate.max = maxDate.toISOString().split('T')[0];
            
            // Update check-out min date when check-in changes
            checkInDate.addEventListener('change', function() {
                const minCheckOut = new Date(this.value);
                minCheckOut.setDate(minCheckOut.getDate() + 1);
                checkOutDate.min = minCheckOut.toISOString().split('T')[0];
                
                // Set max checkout (30 days from check-in)
                const maxCheckOut = new Date(this.value);
                maxCheckOut.setDate(maxCheckOut.getDate() + 30);
                checkOutDate.max = maxCheckOut.toISOString().split('T')[0];
                
                // Clear checkout if invalid
                if (checkOutDate.value && new Date(checkOutDate.value) <= new Date(this.value)) {
                    checkOutDate.value = '';
                }
                
                calculateNights();
            });
            
            checkOutDate.addEventListener('change', calculateNights);
            
            function calculateNights() {
                if (checkInDate.value && checkOutDate.value) {
                    const start = new Date(checkInDate.value);
                    const end = new Date(checkOutDate.value);
                    const diffTime = Math.abs(end - start);
                    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                    
                    nightsCount.textContent = diffDays;
                    nightsInfoContainer.style.display = 'block';
                } else {
                    nightsInfoContainer.style.display = 'none';
                }
            }
            
            // Auto-select room based on weight
            const petWeight = document.getElementById('petWeight');
            petWeight.addEventListener('change', function() {
                const roomInputs = document.querySelectorAll('input[name="roomType"]');
                if (this.value === 'Dưới 5kg') {
                    roomInputs[0].checked = true;
                } else if (this.value === 'Trên 5kg') {
                    roomInputs[1].checked = true;
                }
            });
            
            // Smooth scroll to booking section if hash is #booking
            if (window.location.hash === '#booking') {
                document.getElementById('booking').scrollIntoView({ behavior: 'smooth' });
            }
        });
        
        // Update booking button to scroll to form
        document.querySelectorAll('.btn-booking-now').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                document.getElementById('booking').scrollIntoView({ behavior: 'smooth' });
            });
        });
    </script>
</body>
</html>
