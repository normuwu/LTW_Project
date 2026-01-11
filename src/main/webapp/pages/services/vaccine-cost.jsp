<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tiết Kiệm Chi Phí - Animal Doctors</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #00bfa5;
            --primary-dark: #00897b;
            --dark: #263238;
        }
        
        body {
            font-family: 'Montserrat', sans-serif;
            color: #333;
            line-height: 1.8;
        }
        
        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, #1e88e5 0%, #42a5f5 100%);
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
            font-size: 2.3rem;
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
            color: #1e88e5;
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
            color: #1e88e5;
        }
        
        /* Comparison Section */
        .comparison-section {
            padding: 80px 0;
            background: #f8f9fa;
        }
        .comparison-section h2 {
            color: var(--dark);
            font-weight: 700;
            margin-bottom: 50px;
        }
        .scenario-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            height: 100%;
        }
        .scenario-header {
            padding: 30px;
            text-align: center;
            color: white;
        }
        .scenario-header.good {
            background: linear-gradient(135deg, #10b981, #059669);
        }
        .scenario-header.bad {
            background: linear-gradient(135deg, #ef4444, #dc2626);
        }
        .scenario-header h3 {
            margin: 0 0 10px;
            font-weight: 700;
        }
        .scenario-header .price {
            font-size: 2rem;
            font-weight: 800;
        }
        .scenario-body {
            padding: 30px;
        }
        .scenario-body ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .scenario-body li {
            padding: 12px 0;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .scenario-body li:last-child {
            border-bottom: none;
        }
        .scenario-body li i {
            font-size: 1.3rem;
        }
        .scenario-body li i.bx-check {
            color: #10b981;
        }
        .scenario-body li i.bx-x {
            color: #ef4444;
        }
        
        /* Benefit Section */
        .benefit-section {
            padding: 80px 0;
        }
        .benefit-section h2 {
            color: var(--primary-dark);
            font-weight: 700;
            margin-bottom: 50px;
        }
        .benefit-card {
            background: linear-gradient(135deg, #e0f2f1, #b2dfdb);
            border-radius: 20px;
            padding: 35px;
            height: 100%;
        }
        .benefit-card i {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 20px;
        }
        .benefit-card h4 {
            color: var(--dark);
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        /* Offer Section */
        .offer-section {
            padding: 80px 0;
            background: linear-gradient(135deg, #fef3c7, #fde68a);
        }
        .offer-section h2 {
            color: #92400e;
            font-weight: 700;
            margin-bottom: 20px;
        }
        .offer-box {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }
        .offer-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 0;
            border-bottom: 1px dashed #e5e7eb;
        }
        .offer-item:last-child {
            border-bottom: none;
        }
        .offer-item i {
            font-size: 2rem;
            color: #f59e0b;
        }
        
        /* FAQ Section */
        .faq-section {
            padding: 80px 0;
        }
        .faq-section h2 {
            color: var(--dark);
            font-weight: 700;
            margin-bottom: 50px;
        }
        .faq-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            border-left: 4px solid var(--primary);
        }
        .faq-card h4 {
            color: var(--primary-dark);
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
            <h1><i class='bx bxs-wallet'></i> Tiêm Phòng Không Phải Là Chi Phí - Đó Là Khoản Đầu Tư Bảo Hiểm Rẻ Nhất!</h1>
            <p class="sub-headline">
                Chi phí điều trị một ca bệnh truyền nhiễm <strong>đắt gấp 20 lần</strong> một mũi vaccine. 
                Đừng để ví tiền của bạn "chạm đáy" vì sự chủ quan.
            </p>
            <a href="${pageContext.request.contextPath}/vaccine#packages" class="btn-hero">
                <i class='bx bxs-purchase-tag'></i> XEM BẢNG GIÁ GÓI TIÊM TIẾT KIỆM
            </a>
        </div>
    </section>

    <!-- Comparison Section -->
    <section class="comparison-section">
        <div class="container">
            <h2 class="text-center"><i class='bx bxs-bar-chart-alt-2'></i> So Sánh Kinh Tế</h2>
            
            <div class="row justify-content-center g-4">
                <div class="col-md-5">
                    <div class="scenario-card">
                        <div class="scenario-header good">
                            <h3><i class='bx bxs-injection'></i> Kịch Bản A: Chủ Động Tiêm</h3>
                            <div class="price">Chỉ từ 2xx.000 VNĐ/năm</div>
                        </div>
                        <div class="scenario-body">
                            <ul>
                                <li><i class='bx bx-check'></i> Thú cưng khỏe mạnh quanh năm</li>
                                <li><i class='bx bx-check'></i> Chủ nuôi thảnh thơi, an tâm</li>
                                <li><i class='bx bx-check'></i> Chỉ mất 15 phút tại phòng khám</li>
                                <li><i class='bx bx-check'></i> Không lo lắng về bệnh tật</li>
                                <li><i class='bx bx-check'></i> Tiết kiệm thời gian & tiền bạc</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-5">
                    <div class="scenario-card">
                        <div class="scenario-header bad">
                            <h3><i class='bx bxs-first-aid'></i> Kịch Bản B: Khi Mắc Bệnh</h3>
                            <div class="price">5 - 15 Triệu VNĐ</div>
                        </div>
                        <div class="scenario-body">
                            <ul>
                                <li><i class='bx bx-x'></i> Tiền xét nghiệm: 500k - 800k</li>
                                <li><i class='bx bx-x'></i> Truyền dịch, thuốc: 1-2 triệu/ngày</li>
                                <li><i class='bx bx-x'></i> Nội trú: 5-10 triệu/liệu trình</li>
                                <li><i class='bx bx-x'></i> Mất 10 ngày túc trực bệnh viện</li>
                                <li><i class='bx bx-x'></i> <strong>Chưa chắc cứu được!</strong></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Benefit Section -->
    <section class="benefit-section">
        <div class="container">
            <h2 class="text-center"><i class='bx bxs-gift'></i> Lợi Ích Gia Tăng</h2>
            
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="benefit-card">
                        <i class='bx bxs-time'></i>
                        <h4>Tiết Kiệm Thời Gian</h4>
                        <p>Chỉ mất <strong>15 phút</strong> tại phòng khám mỗi năm, thay vì mất <strong>10 ngày</strong> lo lắng túc trực tại bệnh viện.</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="benefit-card">
                        <i class='bx bxs-heart'></i>
                        <h4>Bảo Vệ Tài Sản Tinh Thần</h4>
                        <p>Niềm vui của gia đình là <strong>vô giá</strong>, đừng để nó bị tổn thương bởi những khoản chi phí phát sinh khổng lồ.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Offer Section -->
    <section class="offer-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-5 mb-4 mb-lg-0">
                    <h2><i class='bx bxs-discount'></i> Chương Trình: "Combo Sức Khỏe Toàn Diện"</h2>
                    <p class="text-muted">Ưu đãi đặc biệt dành cho khách hàng quan tâm đến sức khỏe thú cưng!</p>
                </div>
                <div class="col-lg-7">
                    <div class="offer-box">
                        <div class="offer-item">
                            <i class='bx bxs-badge-check'></i>
                            <div>
                                <strong>Giảm ngay 10%</strong> khi tiêm trọn gói 3 mũi cơ bản + Vaccine dại.
                            </div>
                        </div>
                        <div class="offer-item">
                            <i class='bx bxs-gift'></i>
                            <div>
                                <strong>Tặng kèm 01 lần</strong> tẩy giun/nhỏ gáy ngừa rận miễn phí.
                            </div>
                        </div>
                        <div class="offer-item">
                            <i class='bx bxs-calendar-check'></i>
                            <div>
                                <strong>Nhắc lịch tiêm tự động</strong> qua tin nhắn/Zalo mỗi năm.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FAQ Section -->
    <section class="faq-section">
        <div class="container">
            <h2 class="text-center"><i class='bx bxs-help-circle'></i> Câu Hỏi Thường Gặp</h2>
            
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="faq-card">
                        <h4><i class='bx bx-question-mark'></i> Tiêm vaccine có đắt không?</h4>
                        <p><strong>Trả lời:</strong> Rẻ hơn một bữa ăn tối của bạn nhưng bảo vệ cả năm trời. Chi phí chỉ từ 200.000 - 500.000 VNĐ/mũi.</p>
                    </div>
                    
                    <div class="faq-card">
                        <h4><i class='bx bx-question-mark'></i> Thú cưng ở trong nhà suốt có cần tiêm không?</h4>
                        <p><strong>Trả lời:</strong> Có, vì virus có thể theo quần áo, tay chân của chủ nhân vào nhà. Môi trường bên ngoài luôn tiềm ẩn nguy cơ.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="container">
            <h2>Hãy Là Người Chủ Nuôi Có Kế Hoạch Tài Chính Thông Thái!</h2>
            <p class="mb-4">Đầu tư nhỏ hôm nay, tiết kiệm lớn ngày mai.</p>
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
