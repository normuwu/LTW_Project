<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Phẫu Thuật Thú Y - Animal Doctors</title>
    
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

        /* Header */
        .surgery-header {
            background: linear-gradient(135deg, #004d40 0%, #00796b 100%);
            padding: 120px 0 80px;
            text-align: center;
            color: #fff;
            position: relative;
        }
        .surgery-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('${pageContext.request.contextPath}/assets/images/surgery_pic/surgery_banner.jpg') center/cover;
            opacity: 0.2;
        }
        .surgery-header .container {
            position: relative;
            z-index: 1;
        }
        .sub-heading {
            text-transform: uppercase;
            letter-spacing: 3px;
            font-size: 0.85rem;
            background: rgba(255,255,255,0.2);
            padding: 8px 20px;
            border-radius: 30px;
            display: inline-block;
            margin-bottom: 20px;
        }
        .surgery-header h1 {
            font-size: 3rem;
            font-weight: 800;
            margin: 0 0 15px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }
        .surgery-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Intro Section */
        .intro-section {
            padding: 80px 0;
            background: #fff;
        }
        .img-frame {
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }
        .img-frame img {
            width: 100%;
            height: auto;
            display: block;
        }
        .section-title {
            color: #004d40;
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 20px;
        }
        .intro-text {
            line-height: 1.8;
            color: #555;
            margin-bottom: 30px;
            font-size: 1.05rem;
        }
        .feature-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .feature-list li {
            margin-bottom: 18px;
            font-size: 1rem;
            display: flex;
            align-items: flex-start;
            padding: 15px;
            background: #f8fffe;
            border-radius: 12px;
            border-left: 4px solid #00bfa5;
        }
        .feature-list li i {
            color: #00bfa5;
            font-size: 1.5rem;
            margin-right: 15px;
            flex-shrink: 0;
        }

        /* Services Grid */
        .services-grid-section {
            background: linear-gradient(135deg, #004d40 0%, #00695c 100%);
            padding: 80px 0;
            color: #fff;
        }
        .services-grid-section h2 {
            font-weight: 800;
            margin-bottom: 10px;
        }
        .service-card {
            background: #fff;
            color: #333;
            padding: 35px 25px;
            border-radius: 20px;
            height: 100%;
            transition: all 0.3s ease;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .service-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }
        .icon-wrapper {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #e0f2f1 0%, #b2dfdb 100%);
            color: #004d40;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 20px;
        }
        .service-card h4 {
            font-weight: 700;
            margin-bottom: 15px;
            color: #004d40;
            font-size: 1.2rem;
        }
        .service-card p {
            font-size: 0.95rem;
            line-height: 1.7;
            color: #666;
            margin: 0;
        }

        /* CTA Section */
        .cta-section {
            padding: 80px 0;
            background: linear-gradient(135deg, #f5f5f5 0%, #e8f5e9 100%);
        }
        .cta-section h2 {
            font-weight: 800;
            color: #004d40;
            margin-bottom: 15px;
        }
        .cta-section p {
            margin-bottom: 30px;
            color: #555;
            font-size: 1.1rem;
        }
        .btn-booking {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 16px 40px;
            background: linear-gradient(135deg, #00bfa5 0%, #00897b 100%);
            color: #fff;
            font-weight: 700;
            font-size: 1.1rem;
            border-radius: 50px;
            text-decoration: none;
            box-shadow: 0 10px 30px rgba(0, 191, 165, 0.4);
            transition: all 0.3s ease;
        }
        .btn-booking:hover {
            background: linear-gradient(135deg, #004d40 0%, #00695c 100%);
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            color: #fff;
        }
        .btn-booking i {
            font-size: 1.3rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .surgery-header {
                padding: 100px 0 60px;
            }
            .surgery-header h1 {
                font-size: 2rem;
            }
            .intro-section {
                padding: 50px 0;
            }
            .section-title {
                font-size: 1.6rem;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/components/navbar.jsp" />

    <section class="surgery-header">
        <div class="container">
            <span class="sub-heading">An Toàn & Chính Xác</span>
            <h1>Phẫu Thuật Thú Y</h1>
            <p>Phòng mổ vô trùng tiêu chuẩn quốc tế với đội ngũ bác sĩ tay nghề cao</p>
        </div>
    </section>

    <section class="intro-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-4 mb-lg-0">
                    <div class="img-frame">
                        <img src="${pageContext.request.contextPath}/assets/images/surgery_pic/surgery_intro.jpg" alt="Phòng mổ">
                    </div>
                </div>
                <div class="col-lg-6">
                    <h3 class="section-title">Tại sao chọn chúng tôi?</h3>
                    <p class="intro-text">
                        Chúng tôi hiểu rằng việc đưa thú cưng đi phẫu thuật là một quyết định lo lắng của chủ nuôi. 
                        Tại Animal Doctors, chúng tôi cam kết mang lại sự an tâm tuyệt đối bằng hệ thống trang thiết bị hiện đại nhất.
                    </p>
                    <ul class="feature-list">
                        <li>
                            <i class='bx bxs-check-shield'></i>
                            <div><strong>Vô trùng tuyệt đối:</strong> Phòng mổ áp lực dương, không khí sạch.</div>
                        </li>
                        <li>
                            <i class='bx bxs-heart-circle'></i>
                            <div><strong>Gây mê an toàn:</strong> Máy gây mê khí dung và theo dõi nhịp tim liên tục.</div>
                        </li>
                        <li>
                            <i class='bx bxs-band-aid'></i>
                            <div><strong>Hậu phẫu chu đáo:</strong> Giảm đau đa phương thức giúp bé hồi phục nhanh.</div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <section class="services-grid-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2>Các Dịch Vụ Phẫu Thuật</h2>
                <p class="text-white-50">Đáp ứng mọi nhu cầu từ cơ bản đến phức tạp</p>
            </div>
            
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="service-card">
                        <div class="icon-wrapper"><i class='bx bxs-cut'></i></div>
                        <h4>Triệt Sản & May Vết Thương</h4>
                        <p>Phẫu thuật triệt sản chó mèo (đực/cái) và xử lý các vết thương phần mềm, khâu thẩm mỹ đảm bảo không để lại sẹo xấu.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="service-card">
                        <div class="icon-wrapper"><i class='bx bxs-capsule'></i></div>
                        <h4>Phẫu Thuật Mô Mềm</h4>
                        <p>Điều trị các khối u, phẫu thuật bàng quang, lấy dị vật đường ruột, mổ đẻ và các can thiệp nội khoa phức tạp khác.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="service-card">
                        <div class="icon-wrapper"><i class='bx bxs-bone'></i></div>
                        <h4>Chỉnh Hình Xương Khớp</h4>
                        <p>Kết hợp xương gãy, phẫu thuật dây chằng, khớp háng bằng đinh nội tủy và nẹp vít chuyên dụng cho thú y.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="cta-section text-center">
        <div class="container">
            <h2>Bạn Cần Tư Vấn Phẫu Thuật?</h2>
            <p>Đừng ngần ngại, hãy đặt lịch ngay để bác sĩ thăm khám và tư vấn phương án tốt nhất cho bé.</p>
            <a href="${pageContext.request.contextPath}/booking?service=3" class="btn-booking">
                <i class='bx bxs-calendar-plus'></i> Đặt Lịch Ngay
            </a>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />
    <jsp:include page="/components/back-button.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
