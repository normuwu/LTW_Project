<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tiêm Phòng Vaccine - Animal Doctors</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vaccine.css">
    
    <style>
        .navbar { background-color: #fff !important; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .navbar .nav-link, .navbar .navbar-brand { color: #333 !important; }
    </style>
</head>
<body>

    <jsp:include page="/header_footer/header.jsp" />

    <section class="vaccine-header">
        <div class="container">
            <span class="sub-heading">Phòng Bệnh Hơn Chữa Bệnh</span>
            <h1>Dịch Vụ Tiêm Phòng Vaccine</h1>
            <p>Lá chắn bảo vệ thú cưng khỏi các bệnh truyền nhiễm nguy hiểm chết người</p>
        </div>
    </section>

    <section class="why-section container mt-5 mb-5">
        <div class="text-center mb-5">
            <h2 class="section-title">Tại Sao Cần Tiêm Vaccine?</h2>
            <p class="text-muted">Vaccine là biện pháp duy nhất để bảo vệ thú cưng khỏi các bệnh không có thuốc đặc trị.</p>
        </div>
        
        <div class="row g-4">
            <div class="col-md-4">
                <div class="why-card">
                    <img src="${pageContext.request.contextPath}/vaccine_pic/vac_dog.jpg" alt="Chó khỏe mạnh">
                    <h4>Ngừa Bệnh Hiểm Nghèo</h4>
                    <p>Ngăn chặn các virus gây tử vong cao như Care, Parvo (ở chó) và Giảm bạch cầu (ở mèo).</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="why-card">
                    <img src="${pageContext.request.contextPath}/vaccine_pic/vac_money.jpg" alt="Tiết kiệm">
                    <h4>Tiết Kiệm Chi Phí</h4>
                    <p>Chi phí tiêm phòng chỉ bằng 1/10 so với chi phí điều trị khi thú cưng mắc bệnh.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="why-card">
                    <img src="${pageContext.request.contextPath}/vaccine_pic/vac_law.jpg" alt="Pháp luật">
                    <h4>Tuân Thủ Pháp Luật</h4>
                    <p>Tiêm phòng Dại là quy định bắt buộc của nhà nước để đảm bảo an toàn cho cộng đồng.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="packages-section">
        <div class="container">
            <h2 class="text-center text-white mb-5">Các Loại Vaccine Phổ Biến</h2>
            
            <div class="row justify-content-center">
                
                <div class="col-md-5 mb-4">
                    <div class="price-card">
                        <div class="price-header dog-header">
                            <i class='bx bxs-dog'></i>
                            <h3>Dành Cho Chó</h3>
                        </div>
                        <ul class="price-list">
                            <li><strong>Vaccine 5 bệnh:</strong> Care, Parvo, Viêm gan, Ho cũi chó, Phó cúm.</li>
                            <li><strong>Vaccine 7 bệnh:</strong> Thêm 2 chủng Leptospira (Xoắn khuẩn).</li>
                            <li><strong>Vaccine Dại:</strong> Tiêm nhắc lại hàng năm.</li>
                        </ul>
                        <div class="text-center mt-4">
                            <a href="${pageContext.request.contextPath}/services.jsp" class="btn-book-dog">Đặt Lịch Tiêm Chó</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-5 mb-4">
                    <div class="price-card">
                        <div class="price-header cat-header">
                            <i class='bx bxs-cat'></i>
                            <h3>Dành Cho Mèo</h3>
                        </div>
                        <ul class="price-list">
                            <li><strong>Vaccine 4 bệnh:</strong> Giảm bạch cầu, Viêm mũi khí quản, Calicivirus, Chlamydia.</li>
                            <li><strong>Vaccine Dại:</strong> Bắt buộc tiêm hàng năm.</li>
                            <li><strong>Tẩy giun:</strong> Thực hiện trước khi tiêm 1 tuần.</li>
                        </ul>
                        <div class="text-center mt-4">
                            <a href="${pageContext.request.contextPath}/services.jsp" class="btn-book-cat">Đặt Lịch Tiêm Mèo</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <section class="schedule-section container mt-5 mb-5">
        <h2 class="section-title text-center mb-5">Lịch Tiêm Chủng Khuyến Nghị</h2>
        
        <div class="row">
            <div class="col-lg-6">
                <h4 class="schedule-head"><i class='bx bxs-dog'></i> Lịch Tiêm Cho Chó Con</h4>
                <div class="timeline-box">
                    <div class="time-item">
                        <span class="time-date">6-8 Tuần</span>
                        <p>Mũi 1: Vaccine 5 bệnh hoặc 7 bệnh.</p>
                    </div>
                    <div class="time-item">
                        <span class="time-date">9-11 Tuần</span>
                        <p>Mũi 2: Nhắc lại mũi đa giá (cách mũi 1 khoảng 3-4 tuần).</p>
                    </div>
                    <div class="time-item">
                        <span class="time-date">12-14 Tuần</span>
                        <p>Mũi 3: Nhắc lại mũi đa giá + Tiêm Dại (1 liều duy nhất).</p>
                    </div>
                    <div class="time-item">
                        <span class="time-date">Hàng Năm</span>
                        <p>Tiêm nhắc lại 1 mũi đa giá và 1 mũi Dại.</p>
                    </div>
                </div>
            </div>

            <div class="col-lg-6 mt-4 mt-lg-0">
                <h4 class="schedule-head"><i class='bx bxs-cat'></i> Lịch Tiêm Cho Mèo Con</h4>
                <div class="timeline-box">
                    <div class="time-item">
                        <span class="time-date">8 Tuần</span>
                        <p>Mũi 1: Vaccine 4 bệnh (Giảm bạch cầu...).</p>
                    </div>
                    <div class="time-item">
                        <span class="time-date">12 Tuần</span>
                        <p>Mũi 2: Nhắc lại mũi 4 bệnh.</p>
                    </div>
                    <div class="time-item">
                        <span class="time-date">16 Tuần</span>
                        <p>Tiêm Vaccine Dại (1 liều duy nhất).</p>
                    </div>
                    <div class="time-item">
                        <span class="time-date">Hàng Năm</span>
                        <p>Tiêm nhắc lại 1 mũi 4 bệnh và 1 mũi Dại.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="note-section">
        <div class="container">
            <div class="alert-box">
                <h3><i class='bx bxs-info-circle'></i> Lưu Ý Quan Trọng</h3>
                <ul>
                    <li>Chỉ tiêm khi thú cưng <strong>hoàn toàn khỏe mạnh</strong> (không sốt, không tiêu chảy, không bỏ ăn).</li>
                    <li>Nên tẩy giun trước khi tiêm phòng khoảng 1 tuần để vaccine đạt hiệu quả cao nhất.</li>
                    <li>Sau khi tiêm, kiêng tắm cho bé trong vòng <strong>5-7 ngày</strong>.</li>
                    <li>Theo dõi sức khỏe trong 24h đầu sau tiêm (sưng mặt, nôn mửa cần đưa đi cấp cứu ngay).</li>
                </ul>
            </div>
        </div>
    </section>

   <jsp:include page="/header_footer/footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>