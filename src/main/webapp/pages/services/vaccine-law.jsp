<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Tuân Thủ Pháp Luật - Animal Doctors</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #00bfa5;
            --primary-dark: #00897b;
            --dark: #263238;
            --navy: #1e3a5f;
            --navy-light: #2d5a87;
        }
        
        body {
            font-family: 'Montserrat', sans-serif;
            color: #333;
            line-height: 1.8;
        }
        
        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, #1e3a5f 0%, #2d5a87 100%);
            padding: 120px 0 100px;
            color: white;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .hero-section::before {
            content: '';
            position: absolute;
            top: -50%; right: -20%;
            width: 600px; height: 600px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
        }
        .hero-section h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 25px;
            position: relative;
        }
        .hero-section .sub-headline {
            font-size: 1.15rem;
            opacity: 0.95;
            max-width: 750px;
            margin: 0 auto 30px;
            line-height: 1.8;
        }
        .btn-hero {
            background: white;
            color: #1e3a5f;
            padding: 18px 40px;
            border-radius: 50px;
            font-weight: 700;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
            font-size: 1.05rem;
        }
        .btn-hero:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            color: #1e3a5f;
        }
        
        /* Regulatory Section */
        .regulatory-section {
            padding: 80px 0;
            background: #e8f4fc;
        }
        .regulatory-section h2 {
            color: #1e3a5f;
            font-weight: 700;
            margin-bottom: 40px;
        }
        .law-card {
            background: white;
            border-radius: 20px;
            padding: 35px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            border-top: 5px solid #2d5a87;
            margin-bottom: 25px;
        }
        .law-card .law-badge {
            background: #dbeafe;
            color: #1e3a5f;
            padding: 8px 16px;
            border-radius: 8px;
            font-weight: 700;
            display: inline-block;
            margin-bottom: 15px;
            font-size: 0.9rem;
        }
        .law-card h4 {
            color: var(--dark);
            font-weight: 700;
            margin-bottom: 15px;
        }
        .fine-amount {
            background: #fef2f2;
            color: #dc2626;
            padding: 15px 20px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.2rem;
            display: inline-block;
            margin-top: 10px;
        }
        
        /* Family Safety Section */
        .safety-section {
            padding: 80px 0;
        }
        .safety-section h2 {
            color: var(--primary-dark);
            font-weight: 700;
            margin-bottom: 30px;
        }
        .danger-box {
            background: linear-gradient(135deg, #fef2f2, #fecaca);
            border-radius: 20px;
            padding: 35px;
            border-left: 5px solid #ef4444;
            margin-bottom: 30px;
        }
        .danger-box h4 {
            color: #dc2626;
            font-weight: 700;
            margin-bottom: 15px;
        }
        .safety-benefit {
            display: flex;
            align-items: flex-start;
            gap: 15px;
            padding: 20px 0;
            border-bottom: 1px solid #e5e7eb;
        }
        .safety-benefit:last-child {
            border-bottom: none;
        }
        .safety-benefit i {
            font-size: 2rem;
            color: var(--primary);
            flex-shrink: 0;
        }
        .safety-benefit h5 {
            color: var(--dark);
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        /* Service Section */
        .service-section {
            padding: 80px 0;
            background: linear-gradient(135deg, #1e3a5f, #2d5a87);
            color: white;
        }
        .service-section h2 {
            color: white;
            font-weight: 700;
            margin-bottom: 50px;
        }
        .service-card {
            background: rgba(255,255,255,0.1);
            border-radius: 16px;
            padding: 30px;
            text-align: center;
            backdrop-filter: blur(10px);
            height: 100%;
        }
        .service-card i {
            font-size: 3rem;
            color: #00bfa5;
            margin-bottom: 20px;
        }
        .service-card h4 {
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        /* Testimonial Section */
        .testimonial-section {
            padding: 80px 0;
            background: #f0fdf4;
        }
        .testimonial-section h2 {
            color: var(--dark);
            font-weight: 700;
            margin-bottom: 50px;
        }
        .testimonial-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            position: relative;
        }
        .testimonial-card::before {
            content: '"';
            font-size: 6rem;
            color: #e0f2f1;
            position: absolute;
            top: 10px;
            left: 20px;
            font-family: Georgia, serif;
            line-height: 1;
        }
        .testimonial-card p {
            font-style: italic;
            font-size: 1.1rem;
            position: relative;
            z-index: 1;
        }
        .testimonial-author {
            margin-top: 20px;
            font-weight: 700;
            color: var(--primary-dark);
        }
        
        /* CTA Section */
        .cta-section {
            background: var(--primary);
            padding: 80px 0;
            text-align: center;
            color: white;
        }
        .cta-section h2 {
            color: white;
            font-weight: 700;
            margin-bottom: 15px;
            font-size: 2rem;
        }
        .btn-cta {
            background: white;
            color: var(--primary-dark);
            padding: 18px 45px;
            border-radius: 50px;
            font-weight: 700;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
            font-size: 1.05rem;
        }
        .btn-cta:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            color: var(--primary-dark);
        }
        
        .content-img {
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0,0,0,0.15);
        }
    </style>
</head>
<body>

    <jsp:include page="/components/navbar.jsp" />

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <h1><i class='bx bxs-home-heart'></i> Bảo Vệ "Boss", Giữ An Toàn Cho Cả Gia Đình</h1>
            <p class="sub-headline">
                Tiêm phòng Dại không chỉ là tình yêu dành cho thú cưng, đó còn là <strong>trách nhiệm với cộng đồng</strong> và tuân thủ pháp luật.
            </p>
            <a href="${pageContext.request.contextPath}/booking?service=2" class="btn-hero">
                <i class='bx bxs-book-bookmark'></i> ĐĂNG KÝ TIÊM DẠI & NHẬN SỔ THEO DÕI NGAY
            </a>
        </div>
    </section>

    <!-- Regulatory Section -->
    <section class="regulatory-section">
        <div class="container">
            <h2 class="text-center"><i class='bx bxs-book-content'></i> Bạn Có Biết Quy Định Của Nhà Nước?</h2>
            
            <div class="row">
                <div class="col-lg-4">
                    <div class="law-card">
                        <span class="law-badge">Quy định bắt buộc</span>
                        <h4><i class='bx bxs-injection'></i> Tiêm Phòng Định Kỳ</h4>
                        <p>Chủ nuôi chó, mèo <strong>bắt buộc</strong> phải tiêm phòng bệnh Dại định kỳ hàng năm.</p>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="law-card">
                        <span class="law-badge">Nghị định 04/2020/NĐ-CP</span>
                        <h4><i class='bx bxs-error'></i> Mức Phạt Vi Phạm</h4>
                        <p>Mức phạt hành chính đối với hành vi không tiêm phòng Dại:</p>
                        <div class="fine-amount">Lên đến 2.000.000 VNĐ</div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="law-card">
                        <span class="law-badge">Giấy tờ quan trọng</span>
                        <h4><i class='bx bxs-id-card'></i> Sổ Tiêm Phòng</h4>
                        <p>Sổ tiêm phòng là <strong>"giấy thông hành" bắt buộc</strong> khi muốn vận chuyển thú cưng đi tỉnh hoặc ra nước ngoài.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Family Safety Section -->
    <section class="safety-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-4 mb-lg-0">
                    <img src="${pageContext.request.contextPath}/assets/images/vaccine_pic/vac_law.jpg" alt="An toàn gia đình" class="img-fluid content-img">
                </div>
                <div class="col-lg-6">
                    <h2><i class='bx bxs-shield-alt-2'></i> An Toàn Cho Gia Đình</h2>
                    
                    <div class="danger-box">
                        <h4><i class='bx bxs-error-circle'></i> Cảnh Báo Nguy Hiểm!</h4>
                        <p>Bệnh Dại lây truyền qua vết cắn, vết liếm của động vật sang người. <strong>Một khi đã phát bệnh trên người, tỉ lệ tử vong là 100%.</strong></p>
                    </div>
                    
                    <div class="safety-benefit">
                        <i class='bx bxs-check-shield'></i>
                        <div>
                            <h5>Triệt Tiêu Mầm Bệnh</h5>
                            <p>Tiêm phòng giúp triệt tiêu mầm bệnh ngay từ nguồn, bảo vệ cả gia đình.</p>
                        </div>
                    </div>
                    
                    <div class="safety-benefit">
                        <i class='bx bxs-happy-heart-eyes'></i>
                        <div>
                            <h5>Tự Tin Giao Lưu</h5>
                            <p>Giúp bạn tự tin hơn khi cho thú cưng giao lưu với các bạn thú khác tại công viên.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Service Section -->
    <section class="service-section">
        <div class="container">
            <h2 class="text-center"><i class='bx bxs-star'></i> Dịch Vụ Của Chúng Tôi</h2>
            
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="service-card">
                        <i class='bx bxs-book-bookmark'></i>
                        <h4>Sổ Tiêm Chuẩn Quốc Tế</h4>
                        <p>Cấp sổ tiêm phòng chuẩn quốc tế, có chữ ký bác sĩ và đóng dấu phòng khám.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="service-card">
                        <i class='bx bxs-bell-ring'></i>
                        <h4>Nhắc Lịch Tự Động</h4>
                        <p>Hệ thống nhắc lịch tiêm tự động qua tin nhắn/Zalo mỗi năm - bạn không bao giờ sợ quên.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="service-card">
                        <i class='bx bxs-phone-call'></i>
                        <h4>Tư Vấn Xử Lý</h4>
                        <p>Tư vấn cách xử lý khi thú cưng vô tình cắn người, hỗ trợ 24/7.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonial Section -->
    <section class="testimonial-section">
        <div class="container">
            <h2 class="text-center"><i class='bx bxs-quote-left'></i> Khách Hàng Nói Gì?</h2>
            
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="testimonial-card">
                        <p>"Từ ngày tiêm phòng đầy đủ và có sổ theo dõi, mình đưa cún đi đâu cũng tự tin, hàng xóm xung quanh cũng quý mến vì mình nuôi chó văn minh."</p>
                        <div class="testimonial-author">
                            <i class='bx bxs-user-circle'></i> Chị Lan - Khách hàng thân thiết
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="container">
            <h2>Đừng Để Sự Thiếu Hiểu Biết Dẫn Đến Những Hậu Quả Đáng Tiếc!</h2>
            <p class="mb-4">Nuôi thú cưng văn minh - An toàn cho gia đình và cộng đồng.</p>
            <a href="${pageContext.request.contextPath}/booking?service=2" class="btn-cta">
                <i class='bx bxs-calendar-check'></i> ĐĂNG KÝ TIÊM PHÒNG & NHẬN ƯU ĐÃI
            </a>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />
    <jsp:include page="/components/back-button.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
