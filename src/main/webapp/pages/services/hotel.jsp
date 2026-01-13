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

    <jsp:include page="/components/footer.jsp" />
    <jsp:include page="/components/back-button.jsp" />
   
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
