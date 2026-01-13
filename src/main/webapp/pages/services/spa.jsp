<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Dịch vụ Làm đẹp & Spa - Animal Doctors</title>
    
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
            background: #fff;
        }

        /* Header - Màu xanh ngọc project */
        .page-header {
            background: linear-gradient(135deg, #00bfa5 0%, #004d40 100%);
            padding: 120px 0 80px;
            text-align: center;
            color: #fff;
        }
        .page-header h1 {
            font-size: 3rem;
            font-weight: 800;
            margin: 0 0 15px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }
        .page-header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        /* Content Section */
        .detail-content {
            padding: 60px 0;
        }
        .detail-content h2 {
            color: #004d40;
            font-weight: 700;
            font-size: 1.8rem;
            margin-bottom: 20px;
        }
        .detail-content p {
            color: #555;
            line-height: 1.8;
            font-size: 1.05rem;
        }

        /* Service List */
        .service-list-check {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .service-list-check li {
            padding: 12px 0;
            display: flex;
            align-items: center;
            font-size: 1rem;
            color: #333;
            border-bottom: 1px solid #f0f0f0;
        }
        .service-list-check li:last-child {
            border-bottom: none;
        }
        .service-list-check li i {
            color: #00bfa5;
            font-size: 1.5rem;
            margin-right: 12px;
        }

        /* Price Box - Màu xanh ngọc */
        .price-box {
            background: linear-gradient(135deg, #e0f7f4 0%, #b2dfdb 100%);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 77, 64, 0.15);
            border: 2px solid #80cbc4;
        }
        .price-box h3 {
            color: #004d40;
            font-weight: 700;
            margin-bottom: 25px;
            text-align: center;
            font-size: 1.4rem;
        }
        .price-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px dashed #80cbc4;
        }
        .price-row span {
            color: #555;
            font-size: 0.95rem;
        }
        .price-row strong {
            color: #004d40;
            font-weight: 700;
            font-size: 1.1rem;
        }
        .btn-booking-spa {
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
        .btn-booking-spa:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(0, 77, 64, 0.4);
            color: #fff;
        }

        /* Gallery Section */
        .gallery-section {
            padding: 60px 0 80px;
            background: #f5f5f5;
        }
        .gallery-title {
            text-align: center;
            color: #004d40;
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 40px;
        }
        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            grid-auto-rows: 200px;
            gap: 15px;
        }
        .gallery-item {
            border-radius: 15px;
            overflow: hidden;
            position: relative;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        .gallery-item:hover {
            transform: scale(1.02);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .gallery-item.tall {
            grid-row: span 2;
        }
        .gallery-item.wide {
            grid-column: span 2;
        }
        .gallery-item.big {
            grid-column: span 2;
            grid-row: span 2;
        }

        /* Main Booking Button */
        .btn-main-booking {
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
            box-shadow: 0 10px 30px rgba(0, 77, 64, 0.4);
            transition: all 0.3s ease;
        }
        .btn-main-booking:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(0, 77, 64, 0.5);
            color: #fff;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .gallery-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 768px) {
            .page-header {
                padding: 100px 0 60px;
            }
            .page-header h1 {
                font-size: 2rem;
            }
            .gallery-grid {
                grid-template-columns: 1fr;
                grid-auto-rows: 250px;
            }
            .gallery-item.tall,
            .gallery-item.wide,
            .gallery-item.big {
                grid-column: span 1;
                grid-row: span 1;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/components/navbar.jsp" />

    <section class="page-header">
        <div class="container">
            <h1>Spa & Grooming</h1>
            <p>Đánh thức vẻ đẹp tiềm ẩn của thú cưng</p>
        </div>
    </section>

    <section class="detail-content container">
        <div class="row">
            <div class="col-lg-7 mb-4 mb-lg-0">
                <h2>Quy trình Spa 7 bước chuẩn quốc tế</h2>
                <p>Tại Animal Doctors, chúng tôi không chỉ tắm rửa đơn thuần. Mỗi bé khi đến Spa sẽ được kiểm tra da lông, tư vấn kiểu cắt tỉa phù hợp và trải nghiệm quy trình thư giãn toàn diện giúp giảm stress và kích thích mọc lông.</p>
                <p>Chúng tôi sử dụng các dòng sữa tắm cao cấp nhập khẩu, an toàn tuyệt đối cho da nhạy cảm, giúp lông mềm mượt và lưu hương lâu từ 3-5 ngày.</p>
                
                <h4 class="mt-4 mb-3" style="color: #004d40; font-weight: 700;">Dịch vụ bao gồm:</h4>
                <ul class="service-list-check">
                    <li><i class='bx bx-check'></i> Cắt tỉa lông tạo kiểu nghệ thuật</li>
                    <li><i class='bx bx-check'></i> Tắm massage, sấy bông, chải tơi lông</li>
                    <li><i class='bx bx-check'></i> Vệ sinh tai, cắt mài móng</li>
                    <li><i class='bx bx-check'></i> Vắt tuyến hôi (miễn phí)</li>
                </ul>
            </div>

            <div class="col-lg-5">
                <div class="price-box">
                    <h3>Bảng Giá Spa</h3>
                    
                    <div class="price-row">
                        <span>Tắm vệ sinh (< 5kg)</span>
                        <strong>150.000đ</strong>
                    </div>
                    <div class="price-row">
                        <span>Tắm vệ sinh (> 5kg)</span>
                        <strong>250.000đ</strong>
                    </div>
                    <div class="price-row">
                        <span>Cắt tỉa toàn thân (< 5kg)</span>
                        <strong>350.000đ</strong>
                    </div>
                    <div class="price-row">
                        <span>Cắt tỉa toàn thân (> 5kg)</span>
                        <strong>500.000đ</strong>
                    </div>
                    <div class="price-row" style="border-bottom: none;">
                        <span>Nhuộm lông nghệ thuật</span>
                        <strong>Liên hệ</strong>
                    </div>

                    <a href="${pageContext.request.contextPath}/booking?service=4" class="btn-booking-spa">
                        <i class='bx bxs-calendar-plus'></i> Đặt Lịch Ngay
                    </a>
                </div>
            </div>
        </div>
    </section>

    <section class="gallery-section">
        <div class="container">
            <h2 class="gallery-title">Các Khách Hàng Đáng Yêu</h2>
            
            <div class="gallery-grid">
                <div class="gallery-item tall">
                    <img src="${pageContext.request.contextPath}/assets/images/spa_pic/webpic26.jpg" alt="Grooming 1">
                </div>
                <div class="gallery-item big">
                    <img src="${pageContext.request.contextPath}/assets/images/spa_pic/webpic27.jpg" alt="Grooming 2">
                </div>
                <div class="gallery-item tall">
                    <img src="${pageContext.request.contextPath}/assets/images/spa_pic/webpic28.jpg" alt="Grooming 3">
                </div>
                <div class="gallery-item wide">
                    <img src="${pageContext.request.contextPath}/assets/images/spa_pic/webpic29.jpg" alt="Grooming 4">
                </div>
                <div class="gallery-item big">
                    <img src="${pageContext.request.contextPath}/assets/images/spa_pic/webpic30.jpg" alt="Grooming 5">
                </div>
                <div class="gallery-item">
                    <img src="${pageContext.request.contextPath}/assets/images/spa_pic/webpic31.jpg" alt="Grooming 6">
                </div>
                <div class="gallery-item">
                    <img src="${pageContext.request.contextPath}/assets/images/spa_pic/webpic32.jpg" alt="Grooming 7">
                </div>
            </div>

            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/booking?service=4" class="btn-main-booking">
                    <i class='bx bxs-calendar-plus'></i> Đặt hẹn ngay
                </a>
            </div>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />
    <jsp:include page="/components/back-button.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
