<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Lịch Của Tôi - Animal Doctors</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/spa.css">

<style>
/* CSS riêng cho bảng lịch */
.schedule-container {
	background: rgba(255, 255, 255, 0.95);
	border-radius: 15px;
	padding: 40px;
	margin-top: 100px; /* Cách top để không đè header */
	margin-bottom: 50px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
	min-height: 400px;
}

/* Style cho thông báo trống */
.empty-state {
	text-align: center;
	padding: 50px 0;
}

.empty-state i {
	font-size: 80px;
	color: #ddd;
	margin-bottom: 20px;
}

.empty-state h4 {
	color: #555;
	font-weight: 600;
}

/* Style cho bảng */
.table-custom thead {
	background-color: #00bfa5;
	color: white;
}

.badge-status {
	padding: 5px 10px;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 600;
}

.status-confirmed {
	background-color: #e3fcef;
	color: #00bfa5;
}

.status-pending {
	background-color: #fff8e1;
	color: #ff9800;
}

.status-done {
	background-color: #eee;
	color: #777;
}
</style>
</head>
<body>

	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-10">
				<div class="schedule-container">

					<h2 class="text-center mb-4"
						style="color: #005f52; font-weight: 800;">Lịch Hẹn Của Bạn</h2>

					<c:if test="${empty mySchedule}">
						<div class="empty-state">
							<i class='bx bx-calendar-x'></i>
							<h4>Bạn chưa có lịch hẹn nào</h4>
							<p class="text-muted">Hãy đặt lịch ngay để chăm sóc sức khỏe
								cho Boss nhé!</p>
							<a href="${pageContext.request.contextPath}/services.jsp"
								class="btn btn-success mt-3"
								style="background: #00bfa5; border: none; border-radius: 50px; padding: 10px 30px;">Đặt
								lịch ngay</a>
						</div>
					</c:if>

					<c:if test="${not empty mySchedule}">
						<div class="table-responsive">
							<table class="table table-hover table-custom align-middle">
								<thead>
									<tr>
										<th>Mã Hẹn</th>
										<th>Thời Gian</th>
										<th>Dịch Vụ</th>
										<th>Thú Cưng</th>
										<th>Bác Sĩ</th>
										<th>Trạng Thái</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${mySchedule}" var="s">
										<tr>
											<td><strong>#${s.id}</strong></td>
											<td>
												<div class="d-flex flex-column">
													<span style="font-weight: 600; color: #333;">${s.date}</span>
													<span style="font-size: 0.9rem; color: #666;">${s.time}</span>
												</div>
											</td>
											<td>${s.serviceName}</td>
											<td>${s.petName}</td>
											<td style="color: #008f7a; font-weight: 600;">
												${s.doctor.name}</td>
											<td><c:choose>
													<c:when test="${s.status == 'Đã xác nhận'}">
														<span class="badge-status status-confirmed">Đã xác
															nhận</span>
													</c:when>
													<c:when test="${s.status == 'Chờ duyệt'}">
														<span class="badge-status status-pending">Chờ duyệt</span>
													</c:when>
													<c:otherwise>
														<span class="badge-status status-done">${s.status}</span>
													</c:otherwise>
												</c:choose></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</c:if>

				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>