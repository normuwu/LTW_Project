<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta class="viewport" content="width=device-width, initial-scale=1.0">

<title>Các Dịch vụ- Animal Doctors</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>

<link href="${pageContext.request.contextPath}/css/service.css"
	rel="stylesheet">

</head>
<body>

	<jsp:include page="/header_footer/header.jsp" />

	<section class="page-header">
		<div class="container">
			<h1>Các Dịch Vụ Của Chúng Tôi</h1>
			<p>Chăm sóc toàn diện, tận tâm và chuyên nghiệp cho thú cưng của
				bạn</p>
		</div>
	</section>

	<section class="service-section">
		<div class="container">
			<div class="row g-4">



				<div class="col-lg-4 col-md-6">
					<div class="service-box">
						<div class="icon-wrapper">
							<i class='bx bx-pulse'></i>
						</div>
						<h4>Khám & Điều Trị</h4>
						<p>Đội ngũ bác sĩ giàu kinh nghiệm chẩn đoán và điều trị các
							bệnh lý nội khoa, ngoại khoa với phác đồ chuẩn quốc tế.</p>
						<a href="${pageContext.request.contextPath}/medical"
							class="read-more-btn">Xem chi tiết <i
							class='bx bx-right-arrow-alt'></i></a>
					</div>
				</div>



				<div class="col-lg-4 col-md-6">
					<div class="service-box">
						<div class="icon-wrapper">
							<i class="bx bx-cut"></i>
						</div>
						<h4>Phẫu Thuật</h4>
						<p>Phòng mổ vô trùng áp lực dương, trang thiết bị gây mê hồi
							sức hiện đại đảm bảo an toàn tối đa cho ca phẫu thuật.</p>
						<a href="${pageContext.request.contextPath}/surgery"
							class="read-more-btn">Xem chi tiết <i
							class='bx bx-right-arrow-alt'></i></a>
					</div>
				</div>



				<div class="col-lg-4 col-md-6">
					<div class="service-box">
						<div class="icon-wrapper">
							<i class="bx bxs-injection"></i>
						</div>
						<h4>Tiêm Phòng Vaccine</h4>
						<p>Cung cấp đầy đủ các loại vaccine nhập khẩu chính hãng để
							phòng ngừa các bệnh truyền nhiễm nguy hiểm.</p>
						<a href="${pageContext.request.contextPath}/vaccine"
							class="read-more-btn">Xem chi tiết <i
							class='bx bx-right-arrow-alt'></i></a>
					</div>
				</div>



				<div class="col-lg-4 col-md-6">
					<div class="service-box">
						<div class="icon-wrapper">
							<i class='bx bxs-spa'></i>
						</div>
						<h4>Làm đẹp</h4>
						<p>Cắt tỉa lông nghệ thuật, tắm rửa và chăm sóc da cho thú
							cưng.</p>
						<a href="${pageContext.request.contextPath}/spa"
							class="read-more-btn">Xem chi tiết <i
							class='bx bx-right-arrow-alt'></i></a>
					</div>
				</div>



				<div class="col-lg-4 col-md-6">
					<div class="service-box">
						<div class="icon-wrapper">
							<i class="bx bxs-hotel"></i>
						</div>
						<h4>Khách Sạn Thú Cưng</h4>
						<p>Không gian lưu trú sạch sẽ, thoáng mát, chế độ dinh dưỡng
							khoa học và được vui chơi giải trí hàng ngày.</p>
						<a href="${pageContext.request.contextPath}/hotel"
							class="read-more-btn"> Xem chi tiết <i
							class='bx bx-right-arrow-alt'></i>
						</a>

					</div>

				</div>

				<div class="col-lg-4 col-md-6">
					<div class="service-box">
						<div class="icon-wrapper">
							<i class='bx bx-shopping-bag'></i>
						</div>
						<h4>Siêu Thị Thú Cưng</h4>
						<p>Cung cấp đa dạng các mặt hàng từ cát vệ sinh, thức ăn dinh
							dưỡng, phụ kiện đến các loại thuốc và vaccine mang về.</p>
						<a href="${pageContext.request.contextPath}/shop"
							class="read-more-btn"> Xem chi tiết <i
							class='bx bx-right-arrow-alt'></i>
						</a>
					</div>
				</div>

			</div>
		</div>
	</section>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<jsp:include page="/header_footer/footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>