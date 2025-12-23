<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Về Chúng Tôi - Animal Doctors</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link href="${pageContext.request.contextPath}/css/about.css"
	rel="stylesheet">

<style>
.navbar {
	background-color: #fff !important;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	position: sticky;
	top: 0;
	padding: 12px 0 !important;
}

.navbar .nav-link, .navbar .navbar-brand {
	color: #333 !important;
}
</style>
</head>
<body>

	<jsp:include page="/header_footer/header.jsp" />

	<section class="about-section">
		<div class="container">
			<div class="row align-items-center">

				<div class="col-lg-6 mb-5 mb-lg-0">
					<div class="about-img-wrapper">
						<img
							src="${pageContext.request.contextPath}/homepage_pic/webpic2.jpg"
							class="img-fluid about-img-main" alt="About Main"> <img
							src="${pageContext.request.contextPath}/homepage_pic/webpic6.jpg"
							class="img-fluid about-img-small d-none d-md-block"
							alt="About Small">
					</div>
				</div>

				<div class="col-lg-6">
					<h4 class="sub-title">VỀ CHÚNG TÔI</h4>
					<h2 class="main-title">
						Tiêu chuẩn thú y quốc tế <br> ngay tại Việt Nam
					</h2>
					<p class="about-desc">Tại Animal Doctors, chúng tôi hiểu rằng
						thú cưng không chỉ là động vật, mà là những thành viên yêu quý
						trong gia đình. Sứ mệnh của chúng tôi là mang đến dịch vụ chăm sóc
						sức khỏe tốt nhất với sự tận tâm và chuyên môn hàng đầu.</p>

					<div class="about-features">
						<c:forEach items="${features}" var="f">
							<div class="d-flex align-items-start mb-3">
								<div class="icon-box-small">
									<i class='${f.icon}'></i>
								</div>
								<div class="ms-3">
									<h5>${f.title}</h5>
									<p>${f.description}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>

			</div>
		</div>
	</section>

	<section class="team-section">
		<div class="container">
			<div class="text-center mb-5">
				<h2 class="team-title">Đội Ngũ Y Khoa</h2>
				<p class="team-desc">Đội ngũ của chúng tôi bao gồm những chuyên
					gia từ nhiều quốc gia, nhiều chuyên môn khác nhau gắn kết bằng tất
					cả đam mê, nhiệt huyết và tình yêu dành cho động vật.</p>
				<h3 class="team-subtitle">Bác Sĩ Thú Y</h3>
			</div>

			<div class="row justify-content-center">
				<c:forEach items="${doctors}" var="d">
					<div class="col-lg-4 col-md-6 mb-4">
						<div class="doctor-card">
							<div class="doctor-img-box">
								<img
									src="${pageContext.request.contextPath}/aboutUs_pic/${d.image}"
									alt="${d.name}">
							</div>
							<div class="doctor-info">
								<h4>${d.name}</h4>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<section class="care-section">
		<div class="container">
			<h2 class="care-title">Chăm sóc sức khỏe toàn diện</h2>

			<div class="row">
				<div class="col-lg-4 mb-4">
					<ul class="care-list">
						<c:forEach items="${careItems}" var="item" varStatus="status">
							<li class="care-item ${status.first ? 'active' : ''}"
								onclick="openTab(event, 'tab${status.count}')">
								${item.title}</li>
						</c:forEach>
					</ul>
				</div>

				<div class="col-lg-8">
					<div class="care-content-box">
						<c:forEach items="${careItems}" var="item" varStatus="status">
							<div id="tab${status.count}"
								class="tab-content ${status.first ? 'active-content' : ''}"
								style="${status.first ? 'display: block;' : ''}">

								<c:out value="${item.content}" escapeXml="false" />
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		function openTab(evt, tabName) {
			var i, tabContent, tabLinks;
			// 1. Ẩn tất cả nội dung tab
			tabContent = document.getElementsByClassName("tab-content");
			for (i = 0; i < tabContent.length; i++) {
				tabContent[i].style.display = "none";
				tabContent[i].classList.remove("active-content");
			}

			// 2. Xóa active ở menu
			tabLinks = document.getElementsByClassName("care-item");
			for (i = 0; i < tabLinks.length; i++) {
				tabLinks[i].className = tabLinks[i].className.replace(
						" active", "");
			}

			// 3. Hiện tab được chọn
			document.getElementById(tabName).style.display = "block";
			document.getElementById(tabName).classList.add("active-content");
			evt.currentTarget.className += " active";
		}
	</script>
	
	
	<jsp:include page="/header_footer/footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
