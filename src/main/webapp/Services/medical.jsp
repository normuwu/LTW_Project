<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khám & Điều Trị - Animal Doctors</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/medical.css">
    
    <style>
        .navbar { background-color: #fff !important; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .navbar .nav-link, .navbar .navbar-brand { color: #333 !important; }
    </style>
</head>
<body>

    <jsp:include page="/header_footer/header.jsp" />

    <section class="medical-header">
        <div class="container">
            <span class="sub-heading">Chẩn Đoán Chính Xác - Điều Trị Hiệu Quả</span>
            <h1>Khám & Chữa Bệnh Nội Khoa</h1>
            <p>Phác đồ điều trị chuẩn y khoa được cá nhân hóa cho từng thú cưng</p>
        </div>
    </section>

    <section class="process-section container mt-5">
        <div class="text-center mb-5">
            <h2 class="section-title">Quy Trình Thăm Khám</h2>
            <p class="text-muted">Mọi chỉ định y khoa đều dựa trên bằng chứng khoa học</p>
        </div>
        
        <div class="row text-center process-row">
            <div class="col-md-3 col-6 mb-4">
                <div class="step-box">
                    <div class="step-icon"><i class='bx bxs-user-voice'></i></div>
                    <h5>1. Khám Lâm Sàng</h5>
                    <p>Bác sĩ kiểm tra tổng quát: nghe tim phổi, đo thân nhiệt, sờ nắn.</p>
                </div>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <div class="step-box">
                    <div class="step-icon"><i class='bx bxs-vial'></i></div>
                    <h5>2. Xét Nghiệm</h5>
                    <p>Thực hiện xét nghiệm máu, siêu âm, X-quang nếu cần thiết.</p>
                </div>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <div class="step-box">
                    <div class="step-icon"><i class='bx bxs-report'></i></div>
                    <h5>3. Chẩn Đoán</h5>
                    <p>Đọc kết quả và kết luận bệnh án chính xác nhất.</p>
                </div>
            </div>
            <div class="col-md-3 col-6 mb-4">
                <div class="step-box">
                    <div class="step-icon"><i class='bx bxs-capsule'></i></div>
                    <h5>4. Phác Đồ Điều Trị</h5>
                    <p>Kê đơn thuốc hoặc nhập viện điều trị nội trú.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="services-section">
        <div class="container">
            <div class="row align-items-center mb-5">
                <div class="col-lg-6">
                    <h2 class="section-title text-white">Các Chuyên Khoa</h2>
                    <p class="text-white-50">Chúng tôi tiếp nhận điều trị đa dạng các mặt bệnh</p>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-md-6 col-lg-4">
                    <div class="med-card">
                        <img src="${pageContext.request.contextPath}/medical_pic/med_internal.jpg" alt="Nội khoa">
                        <div class="med-card-body">
                            <h4>Nội Khoa Tổng Quát</h4>
                            <p>Điều trị các bệnh lý về tiêu hóa (tiêu chảy, nôn mửa), hô hấp (viêm phổi), tiết niệu và tim mạch.</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-4">
                    <div class="med-card">
                        <img src="${pageContext.request.contextPath}/medical_pic/med_skin.jpg" alt="Da liễu">
                        <div class="med-card-body">
                            <h4>Da Liễu (Da & Lông)</h4>
                            <p>Chuyên trị nấm, ghẻ (Demodex, Sarcoptes), viêm da dị ứng và các bệnh ký sinh trùng ngoài da.</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-4">
                    <div class="med-card">
                        <img src="${pageContext.request.contextPath}/medical_pic/med_eyes.jpg" alt="Nhãn khoa">
                        <div class="med-card-body">
                            <h4>Ngũ Quan & Răng Hàm Mặt</h4>
                            <p>Điều trị viêm tai, loét giác mạc mắt và lấy cao răng, nhổ răng sữa tồn dư.</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-4">
                    <div class="med-card">
                        <img src="${pageContext.request.contextPath}/medical_pic/med_infectious.jpg" alt="Truyền nhiễm">
                        <div class="med-card-body">
                            <h4>Bệnh Truyền Nhiễm</h4>
                            <p>Phác đồ cứu chữa tích cực cho các bệnh nguy hiểm như Parvo, Carré (ở chó) và Giảm bạch cầu (ở mèo).</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-4">
                    <div class="med-card">
                        <img src="${pageContext.request.contextPath}/medical_pic/med_test.jpg" alt="Xét nghiệm">
                        <div class="med-card-body">
                            <h4>Xét Nghiệm & Hình Ảnh</h4>
                            <p>Hệ thống máy xét nghiệm sinh lý/sinh hóa máu IDEXX (Mỹ) và máy siêu âm màu 4D.</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-4">
                    <div class="med-card-contact">
                        <i class='bx bx-phone-call'></i>
                        <h4>Trường Hợp Cấp Cứu?</h4>
                        <p>Chúng tôi luôn sẵn sàng hỗ trợ 24/7 cho các ca bệnh khẩn cấp.</p>
                        <a href="tel:0123456789" class="btn-emergency">Gọi Ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <div class="container text-center my-5">
        <h3>Bé đang có dấu hiệu mệt mỏi?</h3>
        <p>Đặt lịch khám ngay để phát hiện bệnh sớm nhất</p>
        <a href="${pageContext.request.contextPath}/services.jsp" class="btn-main">Đặt Lịch Khám</a>
    </div>

   <jsp:include page="/header_footer/footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>