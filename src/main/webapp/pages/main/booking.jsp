<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="/components/meta.jsp" />
    <title>Đặt Lịch Hẹn - Animal Doctors</title>
    <jsp:include page="/components/head.jsp" />
    <jsp:include page="/components/navbar-styles.jsp" />
</head>
<body>
    <jsp:include page="/components/layout/header-home.jsp" />

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <jsp:include page="/components/alerts.jsp" />
                
                <div class="card shadow border-0">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h3 class="mb-0"><i class='bx bx-calendar-plus'></i> ĐẶT LỊCH KHÁM TRỰC TUYẾN</h3>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/booking" method="post">

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Họ tên chủ nuôi (*)</label> 
                                    <input type="text" name="customerName" class="form-control" 
                                           placeholder="Nguyễn Văn A" required
                                           value="${currentUser != null ? currentUser.fullname : ''}">
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
                                    <label class="form-label fw-bold">Loại thú cưng (*)</label> 
                                    <select name="petType" id="petTypeSelect" class="form-select" required onchange="toggleCustomPetType()">
                                        <option value="">-- Chọn loại thú cưng --</option>
                                        <option value="Chó">🐕 Chó</option>
                                        <option value="Mèo">🐱 Mèo</option>
                                        <option value="Chim">🐦 Chim</option>
                                        <option value="Thỏ">🐰 Thỏ</option>
                                        <option value="Hamster">🐹 Hamster</option>
                                        <option value="Khác">🐾 Khác (Nhập bên dưới)</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="row mb-3" id="customPetTypeRow" style="display: none;">
                                <div class="col-md-6 offset-md-6">
                                    <label class="form-label fw-bold">Nhập loại thú cưng của bạn (*)</label>
                                    <input type="text" name="customPetType" id="customPetType" class="form-control" placeholder="Ví dụ: Rùa, Cá, Bò sát...">
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Ngày muốn đặt (*)</label> 
                                    <input type="date" name="bookingDate" class="form-control" required>
                                </div>
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
                            </div>

                            <div class="row mb-3">
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
                                <button type="submit" class="btn btn-primary btn-lg shadow-sm">
                                    <i class='bx bx-check-circle'></i> Xác Nhận Đặt Lịch
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/components/footer.jsp" />
    <jsp:include page="/components/scripts.jsp" />
    
    <script>
        function toggleCustomPetType() {
            var select = document.getElementById('petTypeSelect');
            var customRow = document.getElementById('customPetTypeRow');
            var customInput = document.getElementById('customPetType');
            
            if (select.value === 'Khác') {
                customRow.style.display = 'flex';
                customInput.required = true;
            } else {
                customRow.style.display = 'none';
                customInput.required = false;
                customInput.value = '';
            }
        }
    </script>
</body>
</html>

