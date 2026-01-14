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

<!-- Bootstrap CSS - Load trước -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Boxicons -->
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<!-- Custom CSS - Load sau để override -->
<link href="${pageContext.request.contextPath}/assets/css/home.css" rel="stylesheet">

<style>
/* Backup CSS inline để đảm bảo layout không vỡ */
.hero-section {
    position: relative;
    height: 100vh;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    overflow: hidden;
    color: #fff;
}
.back-video {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: -2;
    object-fit: cover;
}
.hero-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.4);
    z-index: -1;
}
.hero-content {
    z-index: 1;
    max-width: 800px;
    padding: 20px;
}
.hero-content h1 {
    font-size: 60px;
    font-weight: 700;
    margin-bottom: 20px;
    text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
    text-transform: uppercase;
}
.hero-content p {
    font-size: 20px;
    margin-bottom: 30px;
    text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
}

/* Features Section */
.features-section {
    background-color: #FFFAF4;
    padding: 80px 0;
    border-radius: 50px 50px 0 0;
    position: relative;
    margin-top: -50px;
    z-index: 1;
    width: 100%;
}
.section-title {
    color: #1a2e5a;
    font-weight: 700;
    font-size: 2.5rem;
    margin-bottom: 40px;
}
.feature-item {
    padding: 10px;
    text-align: center;
}
.img-box {
    width: 100%;
    height: 200px;
    border-radius: 20px;
    overflow: hidden;
    margin-bottom: 20px;
}
.img-box img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.6s ease;
}
.feature-item:hover .img-box img {
    transform: scale(1.1);
}
.feature-item h5 {
    color: #1a2e5a;
    font-weight: 700;
    font-size: 1.1rem;
    min-height: 50px;
}
.feature-item p {
    color: #555;
    font-size: 0.9rem;
}

/* Services Dark Section */
.services-dark-section {
    background-color: #1a1a1a;
    padding: 100px 0;
    color: #fff;
    position: relative;
    overflow: hidden;
    width: 100%;
}
.service-title {
    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 40px;
    color: #f0f0f0;
}
.service-list {
    list-style: none;
    padding: 0;
    margin: 0;
}
.service-item {
    font-size: 1.1rem;
    padding: 15px 0;
    color: #888;
    cursor: pointer;
    transition: 0.3s;
    border-left: 3px solid transparent;
}
.service-item:hover {
    color: #ccc;
}
.service-item.active {
    color: #fff;
    font-weight: 600;
    padding-left: 15px;
    border-left: 3px solid #8B0000;
}
.service-display {
    position: relative;
    width: 100%;
    height: 400px;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
    background-color: #000;
}
.service-main-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.service-content-overlay {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    padding: 30px;
    background: linear-gradient(to top, rgba(0, 0, 0, 0.9), transparent);
    color: #fff;
}
.service-content-overlay p {
    font-size: 1rem;
    margin-bottom: 20px;
    max-width: 80%;
}
.btn-service-more {
    background-color: #721c24;
    color: #fff;
    padding: 8px 20px;
    border-radius: 5px;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 5px;
}
.btn-service-more:hover {
    background-color: #a71d2a;
    color: #fff;
}
.service-dots {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 15px;
}
.dot {
    width: 8px;
    height: 8px;
    background-color: #555;
    border-radius: 50%;
    display: inline-block;
}
.dot.active {
    background-color: #fff;
    transform: scale(1.2);
}
.decor-bottom-left {
    position: absolute;
    bottom: 0;
    left: 20px;
    width: 150px;
    opacity: 0.3;
    filter: invert(1);
}

/* Button booking */
.btn-booking {
    background-color: #00bfa5;
    color: white !important;
    padding: 10px 25px;
    border-radius: 50px;
    font-weight: 600;
    border: none;
}
.btn-booking:hover {
    background-color: #008f7a;
}
</style>
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
