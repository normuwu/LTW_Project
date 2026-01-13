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
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/service.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/spa.css">
    
    <style>
        /* Header trang con nền trắng */
        .navbar { 
            background-color: #ffffff !important; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); 
            position: sticky; 
            top: 0; 
            padding: 12px 0 !important;
        }
        .navbar .nav-link, .navbar .navbar-brand { color: #333 !important; }
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

    <section class="detail-content container mb-5">
        <div class="row">
            <div class="col-lg-7">
                <h2>Quy trình Spa 7 bước chuẩn quốc tế</h2>
                <p>Tại Animal Doctors, chúng tôi không chỉ tắm rửa đơn thuần. Mỗi bé khi đến Spa sẽ được kiểm tra da lông, tư vấn kiểu cắt tỉa phù hợp và trải nghiệm quy trình thư giãn toàn diện giúp giảm stress và kích thích mọc lông.</p>
                <p>Chúng tôi sử dụng các dòng sữa tắm cao cấp nhập khẩu, an toàn tuyệt đối cho da nhạy cảm, giúp lông mềm mượt và lưu hương lâu từ 3-5 ngày.</p>
                
                <h4 class="mt-4 mb-3" style="color: #00bfa5;">Dịch vụ bao gồm:</h4>
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
                    <div class="price-row border-0">
                        <span>Nhuộm lông nghệ thuật</span>
                        <strong>Liên hệ</strong>
                    </div>

                    <a href="#" class="btn-booking-spa">Đặt Lịch Ngay</a>
                </div>
            </div>
        </div>
    </section>

    <section class="gallery-section container">
        <h2 class="gallery-title">Các Khách Hàng Đáng Yêu</h2>
        
        <div class="gallery-grid">
            <div class="gallery-item tall">
                <img src="${pageContext.request.contextPath}/assets/images/spa_pic/webpic26.jpg" alt="Grooming 1">
                <div class="overlay"></div>
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
            <a href="#" class="btn-main-booking mx-auto">Đặt hẹn ngay</a>
        </div>
    </section>

    
	
	
	<jsp:include page="/components/footer.jsp" />
	<jsp:include page="/components/back-button.jsp" />
	
	<!-- Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

