<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phẫu Thuật Thú Y - Animal Doctors</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/surgery.css">
    
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

    <section class="intro-section container mt-5 mb-5">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <div class="img-frame">
                    <img src="${pageContext.request.contextPath}/assets/images/surgery_pic/surgery_intro.jpg" alt="Phòng mổ">
                </div>
            </div>
            <div class="col-lg-6 mt-4 mt-lg-0">
                <h3 class="section-title">Tại sao chọn chúng tôi?</h3>
                <p class="intro-text">
                    Chúng tôi hiểu rằng việc đưa thú cưng đi phẫu thuật là một quyết định lo lắng của chủ nuôi. 
                    Tại Animal Doctors, chúng tôi cam kết mang lại sự an tâm tuyệt đối bằng hệ thống trang thiết bị hiện đại nhất.
                </p>
                <ul class="feature-list">
                    <li><i class='bx bxs-check-shield'></i> <strong>Vô trùng tuyệt đối:</strong> Phòng mổ áp lực dương, không khí sạch.</li>
                    <li><i class='bx bxs-heart-circle'></i> <strong>Gây mê an toàn:</strong> Máy gây mê khí dung và theo dõi nhịp tim liên tục.</li>
                    <li><i class='bx bxs-band-aid'></i> <strong>Hậu phẫu chu đáo:</strong> Giảm đau đa phương thức giúp bé hồi phục nhanh.</li>
                </ul>
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
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

