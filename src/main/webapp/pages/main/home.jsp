<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Animal Doctors - Trang chủ</title>

<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/favicon/favicon.ico">
<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/assets/images/favicon/favicon-32x32.png">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>

<link href="${pageContext.request.contextPath}/assets/css/home.css"
	rel="stylesheet">
</head>
<body>

	<jsp:include page="/components/layout/header-home.jsp" />

	<section class="hero-section">
		<video autoplay muted loop playsinline class="back-video">
			<source src="${pageContext.request.contextPath}/assets/video/catvid.mp4"
				type="video/mp4">
		</video>

		<div class="hero-overlay"></div>

		<div class="hero-content">
			<h1>CÂU CHUYỆN CỦA ADI</h1>
			<p>Nơi động vật luôn được đặt lên hàng đầu</p>
			<button class="btn btn-booking">Tìm hiểu thêm</button>
		</div>
	</section>

	<section class="features-section">
		<div class="container">
			<div class="text-center mb-5">
				<h2 class="section-title">Sự chăm sóc tốt nhất dành cho thú
					cưng</h2>
			</div>

			<div class="row">
				<div class="col-lg-3 col-md-6 mb-4">
					<div class="feature-item">
						<div class="img-box">
							<img
								src="${pageContext.request.contextPath}/assets/images/homepage_pic/webpic2.jpg"
								alt="Bác sĩ">
						</div>
						<h5>Các bác sĩ được đào tạo và có bằng cấp quốc tế</h5>
						<p>Thú cưng của bạn xứng đáng nhận được sự chăm sóc tốt nhất.</p>
					</div>
				</div>

				<div class="col-lg-3 col-md-6 mb-4">
					<div class="feature-item">
						<div class="img-box">
							<img
								src="${pageContext.request.contextPath}/assets/images/homepage_pic/webpic5.jpg"
								alt="Công nghệ">
						</div>
						<h5>Công Nghệ Y Học cao cấp và hiện đại</h5>
						<p>Chúng tôi đầu tư vào cơ sở vật chất để đưa ra chẩn đoán
							nhanh chóng và chính xác.</p>
					</div>
				</div>

				<div class="col-lg-3 col-md-6 mb-4">
					<div class="feature-item">
						<div class="img-box">
							<img
								src="${pageContext.request.contextPath}/assets/images/homepage_pic/webpic3.jpg"
								alt="Chuyên gia">
						</div>
						<h5>Những chuyên gia bạn có thể trông cậy</h5>
						<p>Mọi thứ chúng tôi làm đều phù hợp hoặc vượt qua các tiêu
							chuẩn quốc tế.</p>
					</div>
				</div>

				<div class="col-lg-3 col-md-6 mb-4">
					<div class="feature-item">
						<div class="img-box">
							<img
								src="${pageContext.request.contextPath}/assets/images/homepage_pic/webpic4.jpg"
								alt="Khách hàng">
						</div>
						<h5>Chăm sóc khách hàng tận tâm</h5>
						<p>Chúng tôi hỗ trợ bạn bằng cách làm cho trải nghiệm của bạn
							trở nên thoải mái nhất.</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="services-dark-section">
		<div class="container">
			<div class="row align-items-center">

				<div class="col-lg-4 mb-5 mb-lg-0">
					<h2 class="service-title">Các Dịch Vụ</h2>

					<ul class="service-list">
						<li class="service-item active" onclick="changeService(0)">Khám
							và Điều Trị</li>
						<li class="service-item" onclick="changeService(1)">Phẫu
							thuật</li>
						<li class="service-item" onclick="changeService(2)">Tiêm
							phòng Vaccine</li>
						<li class="service-item" onclick="changeService(3)">Siêu Thị
							thú cưng</li>
						<li class="service-item" onclick="changeService(4)">Khách sạn
							mèo</li>
						<li class="service-item" onclick="changeService(5)">Làm đẹp</li>
					</ul>
				</div>

				<div class="col-lg-8 position-relative">
					<div class="service-display">
						<img id="service-img"
							src="${pageContext.request.contextPath}/assets/images/homepage_pic/webpic11.jpg"
							class="img-fluid service-main-img" alt="Service Image">

						<div class="service-content-overlay">
							<p id="service-desc">Đội ngũ bác sĩ thú y giàu kinh nghiệm
								của chúng tôi luôn sẵn sàng chẩn đoán và điều trị mọi vấn đề sức
								khỏe cho thú cưng của bạn.</p>
							<a href="#" class="btn btn-service-more">Tìm hiểu thêm <i
								class='bx bx-right-arrow-alt'></i></a>
						</div>
					</div>

					<div class="service-dots mt-3">
						<span class="dot active"></span> <span class="dot"></span> <span
							class="dot"></span> <span class="dot"></span> <span class="dot"></span>
						<span class="dot"></span>
					</div>
				</div>
			</div>
		</div>

		<img src="https://cdn-icons-png.flaticon.com/512/3048/3048122.png"
			class="decor-bottom-left" alt="Decor">
	</section>

	<script>
        const contextPath = "${pageContext.request.contextPath}";

        const servicesData = [
            {
                img: contextPath + "/homepage_pic/webpic11.jpg",
                desc: "Đội ngũ bác sĩ thú y giàu kinh nghiệm của chúng tôi luôn sẵn sàng chẩn đoán và điều trị mọi vấn đề sức khỏe cho thú cưng của bạn.",
                pos: "center center",
                link: contextPath + "/medical"
            },
            {
                img: contextPath + "/homepage_pic/webpic10.jpg",
                desc: "Phòng phẫu thuật vô trùng hiện đại với đầy đủ trang thiết bị hỗ trợ sự sống, đảm bảo an toàn tuyệt đối cho các ca phẫu thuật.",
                pos: "50% 80%",
                link: contextPath + "/surgery"
            },
            {
                img: contextPath + "/homepage_pic/webpic8.jpg",
                desc: "Ngăn chặn các virus gây tử vong cao như Care, Parvo (ở chó) và Giảm bạch cầu (ở mèo).",
                pos: "center center",
                link: contextPath + "/vaccine"
            },
            {
                img: contextPath + "/homepage_pic/webpic7.jpg",
                desc: "Cung cấp đa dạng các mặt hàng từ cát vệ sinh, thức ăn dinh dưỡng, phụ kiện đến các loại thuốc và vaccine mang về.",
                pos: "50% 70%",
                link: contextPath + "/shop"
            },
            {
                img: contextPath + "/homepage_pic/webpic6.jpg", 
                desc: "Dành cho những người nuôi mèo cần đi du lịch, khách sạn mèo sang trọng của chúng tôi sẽ giữ cho người bạn đồng hành luôn an toàn.",
                pos: "50% 80%",
                link: contextPath + "/hotel"
            },
            {
                img: contextPath + "/homepage_pic/webpic12.jpg",
                desc: "Dịch vụ Spa, cắt tỉa lông và làm đẹp giúp thú cưng của bạn luôn sạch sẽ, thơm tho và đáng yêu.",
                pos: "50% 70%",
                link: contextPath + "/spa"
            }
        ];

        function changeService(index) {
            let imgElement = document.getElementById('service-img');
            let btnMore = document.querySelector('.btn-service-more');

            imgElement.src = servicesData[index].img;
            document.getElementById('service-desc').textContent = servicesData[index].desc;
            imgElement.style.objectPosition = servicesData[index].pos || "center center";

            if (servicesData[index].link) {
                btnMore.href = servicesData[index].link;
            } else {
                btnMore.href = "#";
            }

            let items = document.querySelectorAll('.service-item');
            items.forEach(item => item.classList.remove('active'));
            items[index].classList.add('active');

            let dots = document.querySelectorAll('.dot');
            dots.forEach(dot => dot.classList.remove('active'));
            dots[index].classList.add('active');
        }

        	window.addEventListener('scroll', function() {
            var nav = document.getElementById('navbar');
            if (window.scrollY > 50) {
                nav.classList.add('navbar-scrolled'); 
            } else {
                nav.classList.remove('navbar-scrolled'); 
            }
        });
    </script>
    
    
	<jsp:include page="/components/footer.jsp" />

	<!-- Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
