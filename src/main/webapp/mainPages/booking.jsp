<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt Lịch Hẹn - Animal Doctors</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <jsp:include page="/header_footer/header.jsp" />

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow border-0">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h3 class="mb-0">ĐẶT LỊCH KHÁM TRỰC TUYẾN</h3>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/booking" method="post">

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Họ tên chủ nuôi (*)</label> 
                                    <input type="text" name="customerName" class="form-control" placeholder="Nguyễn Văn A" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Số điện thoại (*)</label> 
                                    <input type="tel" name="phone" class="form-control" placeholder="0912..." required>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Tên thú cưng</label> 
                                    <input type="text" name="petName" class="form-control" placeholder="Mimi, Lu...">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Ngày muốn đặt (*)</label> 
                                    <input type="date" name="bookingDate" class="form-control" required>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Chọn Dịch vụ</label> 
                                    <select name="serviceId" class="form-select">
                                        <option value="1">Khám & Điều trị (150k)</option>
                                        <option value="2">Phẫu thuật (Theo ca)</option>
                                        <option value="3">Tiêm phòng Vaccine (Tùy loại)</option>
                                        <option value="4">Spa & Làm đẹp (350k)</option>
                                        <option value="5">Khách Sạn Thú Cưng (200k/ngày)</option>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Chọn Bác sĩ (Không bắt buộc)</label>
                                    <select name="doctorId" class="form-select">
                                        <option value="0">-- Bác sĩ chỉ định --</option>

                                        <c:forEach items="${listDoctors}" var="d">
                                            <option value="${d.id}">${d.name}</option>
                                        </c:forEach>

                                    </select>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold">Triệu chứng / Ghi chú thêm</label>
                                <textarea name="note" class="form-control" rows="3" placeholder="Ví dụ: Bé bỏ ăn 2 ngày nay, cần khám gấp..."></textarea>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg shadow-sm">Xác Nhận Đặt Lịch</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/header_footer/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>