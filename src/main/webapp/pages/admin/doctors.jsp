<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Quản lý Bác sĩ - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Nunito', sans-serif; }
    </style>
    <jsp:include page="/components/admin-styles.jsp" />
</head>
<body>
    <jsp:include page="/components/admin-sidebar.jsp"><jsp:param name="currentPage" value="doctors"/></jsp:include>
    <jsp:include page="/components/admin-toast.jsp" />
    
    <main class="admin-main">
        <div class="page-header-admin">
            <div>
                <h1 class="page-title"><i class='bx bxs-user-badge'></i> Quản lý Bác sĩ</h1>
                <p class="page-subtitle">Thêm, sửa thông tin bác sĩ và lịch làm việc</p>
            </div>
            <jsp:include page="/components/admin-header-dropdown.jsp" />
        </div>

        <!-- Stats -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="stat-card-admin">
                    <div class="stat-icon-admin bg-primary"><i class='bx bxs-user-badge'></i></div>
                    <div class="stat-info">
                        <div class="stat-number-admin">${totalDoctors}</div>
                        <div class="stat-label-admin">Tổng bác sĩ</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Doctors Table -->
        <div class="card-admin">
            <div class="card-header-admin d-flex justify-content-between align-items-center">
                <h5><i class='bx bx-list-ul'></i> Danh sách bác sĩ</h5>
                <button class="btn btn-primary-admin btn-sm" data-bs-toggle="modal" data-bs-target="#doctorModal" onclick="resetForm()">
                    <i class='bx bx-plus'></i> Thêm bác sĩ
                </button>
            </div>
            <div class="card-body-admin">
                <div class="table-responsive">
                    <table class="table-admin">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Ảnh</th>
                                <th>Tên bác sĩ</th>
                                <th>Chuyên khoa</th>
                                <th>Liên hệ</th>
                                <th>Lịch làm việc</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="doctor" items="${doctors}">
                                <tr>
                                    <td>#${doctor.id}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty doctor.image}">
                                                <img src="${pageContext.request.contextPath}/assets/images/aboutUs_pic/${doctor.image}" 
                                                     alt="${doctor.name}" class="avatar-admin">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="avatar-admin avatar-placeholder"><i class='bx bxs-user'></i></div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><strong>${doctor.name}</strong></td>
                                    <td>${doctor.specialty != null ? doctor.specialty : 'Đa khoa'}</td>
                                    <td>
                                        <c:if test="${not empty doctor.phone}">
                                            <div><i class='bx bx-phone'></i> ${doctor.phone}</div>
                                        </c:if>
                                        <c:if test="${not empty doctor.email}">
                                            <div><i class='bx bx-envelope'></i> ${doctor.email}</div>
                                        </c:if>
                                    </td>
                                    <td>${doctor.workSchedule != null ? doctor.workSchedule : 'Chưa cập nhật'}</td>
                                    <td>
                                        <span class="badge-admin ${doctor.active ? 'badge-success' : 'badge-secondary'}">
                                            ${doctor.active ? 'Hoạt động' : 'Nghỉ'}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-action-admin btn-edit" onclick="editDoctor(${doctor.id}, '${doctor.name}', '${doctor.specialty}', '${doctor.phone}', '${doctor.email}', '${doctor.workSchedule}', '${doctor.image}', ${doctor.active})">
                                                <i class='bx bx-edit'></i>
                                            </button>
                                            <button class="btn-action-admin btn-delete" onclick="confirmDelete(${doctor.id}, '${doctor.name}')">
                                                <i class='bx bx-trash'></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty doctors}">
                                <tr><td colspan="8" class="text-center py-4">Chưa có bác sĩ nào</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <!-- Add/Edit Modal -->
    <div class="modal fade" id="doctorModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Thêm bác sĩ mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="${pageContext.request.contextPath}/admin/doctors">
                    <div class="modal-body">
                        <input type="hidden" name="action" id="formAction" value="add">
                        <input type="hidden" name="id" id="doctorId">
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tên bác sĩ *</label>
                                <input type="text" class="form-control" name="name" id="doctorName" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Chuyên khoa</label>
                                <input type="text" class="form-control" name="specialty" id="doctorSpecialty" placeholder="VD: Nội khoa, Ngoại khoa...">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control" name="phone" id="doctorPhone">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" id="doctorEmail">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Lịch làm việc</label>
                            <input type="text" class="form-control" name="workSchedule" id="doctorSchedule" placeholder="VD: Thứ 2-6: 8h-17h">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Ảnh đại diện</label>
                            <input type="text" class="form-control" name="image" id="doctorImage" placeholder="Tên file ảnh">
                        </div>
                        
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" name="isActive" id="doctorActive" checked>
                            <label class="form-check-label" for="doctorActive">Đang hoạt động</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary" id="submitBtn">Thêm bác sĩ</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog modal-sm modal-dialog-centered">
            <div class="modal-content text-center">
                <div class="modal-body py-4">
                    <i class='bx bx-error-circle text-danger' style="font-size:4rem;"></i>
                    <h5 class="mt-3">Xác nhận xóa?</h5>
                    <p class="text-muted">Bạn có chắc muốn xóa bác sĩ <strong id="deleteName"></strong>?</p>
                    <form method="POST" action="${pageContext.request.contextPath}/admin/doctors">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="deleteId">
                        <div class="d-flex gap-2 justify-content-center">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-danger">Xóa</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        <c:if test="${not empty sessionScope.message}">
            showAdminToast('${sessionScope.message}', '${sessionScope.messageType}');
        </c:if>
        <% session.removeAttribute("message"); session.removeAttribute("messageType"); %>
        
        function resetForm() {
            document.getElementById('modalTitle').textContent = 'Thêm bác sĩ mới';
            document.getElementById('submitBtn').textContent = 'Thêm bác sĩ';
            document.getElementById('formAction').value = 'add';
            document.getElementById('doctorId').value = '';
            document.getElementById('doctorName').value = '';
            document.getElementById('doctorSpecialty').value = '';
            document.getElementById('doctorPhone').value = '';
            document.getElementById('doctorEmail').value = '';
            document.getElementById('doctorSchedule').value = '';
            document.getElementById('doctorImage').value = '';
            document.getElementById('doctorActive').checked = true;
        }
        
        function editDoctor(id, name, specialty, phone, email, schedule, image, active) {
            document.getElementById('modalTitle').textContent = 'Chỉnh sửa bác sĩ';
            document.getElementById('submitBtn').textContent = 'Cập nhật';
            document.getElementById('formAction').value = 'edit';
            document.getElementById('doctorId').value = id;
            document.getElementById('doctorName').value = name || '';
            document.getElementById('doctorSpecialty').value = specialty === 'null' ? '' : (specialty || '');
            document.getElementById('doctorPhone').value = phone === 'null' ? '' : (phone || '');
            document.getElementById('doctorEmail').value = email === 'null' ? '' : (email || '');
            document.getElementById('doctorSchedule').value = schedule === 'null' ? '' : (schedule || '');
            document.getElementById('doctorImage').value = image === 'null' ? '' : (image || '');
            document.getElementById('doctorActive').checked = active;
            new bootstrap.Modal(document.getElementById('doctorModal')).show();
        }
        
        function confirmDelete(id, name) {
            document.getElementById('deleteId').value = id;
            document.getElementById('deleteName').textContent = name;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
