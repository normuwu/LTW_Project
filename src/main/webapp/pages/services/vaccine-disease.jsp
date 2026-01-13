<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Ngừa Bệnh Hiểm Nghèo - Animal Doctors</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #00bfa5;
            --primary-dark: #00897b;
            --dark: #263238;
            --accent: #00897b;
        }
        
        body {
            font-family: 'Montserrat', sans-serif;
            color: #333;
            line-height: 1.8;
        }
        
        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, #00897b 0%, #00bfa5 100%);
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
            color: #00897b;
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
            color: #00897b;
        }
        
        /* Pain Points Section */
        .pain-section {
            padding: 80px 0;
            background: #e0f2f1;
        }
        .pain-section h2 {
            color: #00897b;
            font-weight: 700;
            margin-bottom: 40px;
        }
        .pain-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 5px 30px rgba(0,0,0,0.08);
            border-left: 4px solid #00bfa5;
            margin-bottom: 20px;
        }
        .pain-card i {
            color: #00897b;
            font-size: 1.5rem;
            margin-right: 10px;
        }
        
        /* Solution Section */
        .solution-section {
            padding: 80px 0;
        }
        .solution-section h2 {
            color: var(--primary-dark);
            font-weight: 700;
            margin-bottom: 30px;
        }
        .vaccine-package {
            background: linear-gradient(135deg, #e0f2f1, #b2dfdb);
            border-radius: 20px;
            padding: 35px;
            margin-bottom: 25px;
        }
        .vaccine-package h4 {
            color: var(--primary-dark);
            font-weight: 700;
            margin-bottom: 15px;
        }
        .vaccine-package i {
            font-size: 2.5rem;
            color: var(--primary);
            margin-bottom: 15px;
        }
        
        /* Trust Section */
        .trust-section {
            padding: 80px 0;
            background: linear-gradient(135deg, #1e3a5f, #2d5a87);
            color: white;
        }
        .trust-section h2 {
            color: white;
            font-weight: 700;
            margin-bottom: 50px;
        }
        .trust-card {
            background: rgba(255,255,255,0.1);
            border-radius: 16px;
            padding: 30px;
            text-align: center;
            backdrop-filter: blur(10px);
            height: 100%;
        }
        .trust-card i {
            font-size: 3rem;
            color: #00bfa5;
            margin-bottom: 20px;
        }
        .trust-card h4 {
            font-weight: 700;
            margin-bottom: 15px;
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
        .cta-section p {
            font-size: 1.1rem;
            margin-bottom: 30px;
            opacity: 0.95;
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
            <h1><i class='bx bxs-shield-x'></i> Đừng Để Một Mũi Tiêm Nhỏ Trở Thành Nỗi Hối Tiếc Suốt Đời!</h1>
            <p class="sub-headline">
                <strong>80% thú cưng chưa tiêm phòng không thể qua khỏi</strong> khi mắc bệnh truyền nhiễm. 
                Hãy bảo vệ "người bạn nhỏ" của bạn ngay hôm nay bằng lá chắn vaccine 5-7 bệnh.
            </p>
            <a href="${pageContext.request.contextPath}/booking?service=2" class="btn-hero">
                <i class='bx bxs-calendar-plus'></i> ĐẶT LỊCH TIÊM NGAY - BẢO VỆ CON YÊU
            </a>
        </div>
    </section>

    <!-- Pain Points Section -->
    <section class="pain-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-5 mb-4 mb-lg-0">
                    <img src="${pageContext.request.contextPath}/assets/images/vaccine_pic/vac_dog.jpg" alt="Thú cưng ốm" class="img-fluid content-img">
                </div>
                <div class="col-lg-7">
                    <h2><i class='bx bxs-error-circle'></i> Bạn Có Biết?</h2>
                    
                    <div class="pain-card">
                        <p><i class='bx bxs-virus'></i> <strong>Virus Care, Parvo (ở chó) và Giảm bạch cầu (ở mèo)</strong> có thể lấy đi mạng sống của thú cưng chỉ trong vòng <strong>48-72 giờ</strong>.</p>
                    </div>
                    
                    <div class="pain-card">
                        <p><i class='bx bxs-bug'></i> Các mầm bệnh này <strong>luôn tồn tại trong môi trường</strong>, giày dép, và không khí - bạn không thể nhìn thấy chúng bằng mắt thường.</p>
                    </div>
                    
                    <div class="pain-card">
                        <p><i class='bx bxs-heart-circle'></i> Khi thú cưng phát bệnh, <strong>tỉ lệ cứu sống cực thấp</strong> và quá trình điều trị vô cùng đau đớn.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Solution Section -->
    <section class="solution-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2><i class='bx bxs-shield-plus'></i> Vaccine - "Áo Giáp" Sinh Học Vững Chắc Nhất</h2>
                <p class="text-muted" style="max-width: 700px; margin: 0 auto;">
                    Thay vì đối mặt với rủi ro, hãy trang bị hệ miễn dịch chủ động cho thú cưng. 
                    Vaccine giúp cơ thể nhận diện và tiêu diệt virus ngay khi chúng vừa xâm nhập.
                </p>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="vaccine-package text-center">
                        <i class='bx bxs-dog'></i>
                        <h4>Gói Vaccine Cho Chó</h4>
                        <p>Ngừa <strong>Care, Parvo, Viêm gan, Ho cũi chó, Phó cúm</strong> và các bệnh nguy hiểm khác.</p>
                        <a href="${pageContext.request.contextPath}/booking?service=2" class="btn btn-success btn-lg mt-3">
                            <i class='bx bxs-calendar'></i> Đặt Lịch Tiêm Chó
                        </a>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="vaccine-package text-center">
                        <i class='bx bxs-cat'></i>
                        <h4>Gói Vaccine Cho Mèo</h4>
                        <p>Ngừa <strong>Giảm bạch cầu, Viêm mũi - Khí quản truyền nhiễm, Calicivirus</strong> và các bệnh khác.</p>
                        <a href="${pageContext.request.contextPath}/booking?service=2" class="btn btn-success btn-lg mt-3">
                            <i class='bx bxs-calendar'></i> Đặt Lịch Tiêm Mèo
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Trust Section -->
    <section class="trust-section">
        <div class="container">
            <h2 class="text-center"><i class='bx bxs-badge-check'></i> Tại Sao Chọn Chúng Tôi?</h2>
            
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="trust-card">
                        <i class='bx bxs-certification'></i>
                        <h4>100% Vaccine Chính Hãng</h4>
                        <p>Vaccine nhập khẩu từ Mỹ, Pháp. Bảo quản chuẩn lạnh 2-8°C.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="trust-card">
                        <i class='bx bxs-user-check'></i>
                        <h4>Khám Sàng Lọc Miễn Phí</h4>
                        <p>Bác sĩ thú y thăm khám sức khỏe miễn phí trước khi tiêm.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="trust-card">
                        <i class='bx bxs-phone-call'></i>
                        <h4>Hỗ Trợ 24/7</h4>
                        <p>Theo dõi phản ứng sau tiêm và hỗ trợ tư vấn 24/7.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="container">
            <h2>Một Phút Chủ Động - Một Đời An Tâm</h2>
            <p>Đừng để sự chủ quan lấy đi người bạn nhỏ của bạn. Hành động ngay hôm nay!</p>
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
