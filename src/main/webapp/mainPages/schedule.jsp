<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Lịch Hẹn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>

    <jsp:include page="/header_footer/header.jsp" />

    <div class="container mt-5" style="min-height: 60vh;">
        <h2 class="text-center mb-4 text-primary">DANH SÁCH LỊCH HẸN SẮP TỚI</h2>
        
        <div class="card shadow-sm">
            <div class="card-body">
                <table class="table table-hover table-striped align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>#ID</th>
                            <th>Khách Hàng</th>
                            <th>Thú Cưng</th>
                            <th>Dịch Vụ</th>
                            <th>Bác Sĩ</th>
                            <th>Ngày Hẹn</th>
                            <th>Trạng Thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty mySchedule}">
                            <tr>
                                <td colspan="7" class="text-center py-4">Chưa có lịch hẹn nào được đặt.</td>
                            </tr>
                        </c:if>

                        <c:forEach items="${mySchedule}" var="a">
                            <tr>
                                <td><strong>#${a.id}</strong></td>
                                <td>
                                    ${a.customerName}<br>
                                    <small class="text-muted">${a.phone}</small>
                                </td>
                                <td>
                                    <strong>${a.petName}</strong><br>
                                    <small class="text-muted">${a.petType}</small>
                                </td>
                                <td><span class="badge bg-info text-dark">${a.serviceName}</span></td>
                                <td>${a.doctorName}</td>
                                <td>${a.bookingDate}</td>
                                <td>
                                    <span class="badge bg-warning text-dark">${a.status}</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/booking" class="btn btn-success">
                <i class='bx bx-plus-circle'></i> Đặt Thêm Lịch Mới
            </a>
        </div>
    </div>

    <jsp:include page="/header_footer/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>