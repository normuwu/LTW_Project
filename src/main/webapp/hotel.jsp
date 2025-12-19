<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khách sạn Mèo - Animal Doctors</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/service.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hotel.css">
    
    <style>
        /* Navbar mặc định nền trắng */
        .navbar { 
            background-color: #ffffff !important; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

    <video autoplay muted loop playsinline class="back-video">
        <source src="${pageContext.request.contextPath}/video/catHotel_vid.mp4" type="video/mp4">
    </video>

    <div class="video-overlay"></div>

    <div class="content-wrapper">
        
        <jsp:include page="header.jsp" />

        <section class="page-header-transparent">
            <div class="container">
                <h1>Khách Sạn Mèo</h1>
                <p>Không gian nghỉ dưỡng 5 sao dành riêng cho các "Hoàng thượng"</p>
            </div>
        </section>

        <section class="detail-content">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7 mb-5 mb-lg-0 text-white-section">
                        <h2>Tại sao chọn khách sạn mèo của chúng tôi?</h2>
                        <p>
                            Dành cho những người nuôi mèo cần đi du lịch hoặc công tác xa, khách sạn mèo sang trọng của chúng tôi sẽ giữ cho người bạn đồng hành của bạn luôn an toàn, được nuông chiều và khỏe mạnh.
                        </p>
                        <p>
                            Khác với các lồng nhốt thông thường, chúng tôi thiết kế các "phòng riêng" (Cat Condo) rộng rãi, có hệ thống thông gió riêng biệt để tránh lây nhiễm chéo và giảm stress tối đa cho các bé.
                        </p>

                        <h4 class="mt-4 mb-3 text-warning">Tiện ích bao gồm:</h4>
                        <ul class="list-unstyled check-list">
                            <li><i class='bx bxs-check-circle'></i> Phòng riêng rộng rãi, yên tĩnh</li>
                            <li><i class='bx bxs-check-circle'></i> Chế độ dinh dưỡng cao cấp (Royal Canin / Pate tươi)</li>
                            <li><i class='bx bxs-check-circle'></i> Vui chơi 30 phút mỗi ngày với nhân viên chăm sóc</li>
                            <li><i class='bx bxs-check-circle'></i> Cập nhật hình ảnh/video cho chủ nuôi hàng ngày</li>
                            <li><i class='bx bxs-check-circle'></i> Bác sĩ thú y kiểm tra sức khỏe mỗi sáng</li>
                        </ul>
                    </div>

                    <div class="col-lg-5">
                        <div class="price-box">
                            <h3 class="text-center mb-4 text-primary-custom">Bảng Giá Dịch Vụ</h3>
                            
                            <div class="price-item">
                                <span>Phòng Tiêu chuẩn (< 5kg)</span>
                                <strong class="price-tag">150.000đ / ngày</strong>
                            </div>
                            
                            <div class="price-item">
                                <span>Phòng VIP (> 5kg)</span>
                                <strong class="price-tag">250.000đ / ngày</strong>
                            </div>
                            
                            <div class="price-item border-0">
                                <span>Phụ thu Lễ/Tết</span>
                                <strong class="price-tag">+ 50.000đ / ngày</strong>
                            </div>
                            
                            <a href="#" class="btn-booking-now">Đặt Phòng Ngay</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>