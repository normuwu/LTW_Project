<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Quản lý Dịch vụ & Vaccine - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Nunito', sans-serif; }
    </style>
    <jsp:include page="/components/admin-styles.jsp" />
</head>
<body>
    <jsp:include page="/components/admin-sidebar.jsp"><jsp:param name="currentPage" value="services"/></jsp:include>
    <jsp:include page="/components/admin-toast.jsp" />
    
    <main class="admin-main">
        <div class="page-header-admin">
            <div>
                <h1 class="page-title"><i class='bx bxs-injection'></i> Quản lý Dịch vụ & Vaccine</h1>
                <p class="page-subtitle">Quản lý các gói dịch vụ và vaccine tiêm chủng</p>
            </div>
            <jsp:include page="/components/admin-header-dropdown.jsp" />
        </div>

        <!-- Stats -->
        <div class="row g-4 mb-4">
            <div class="col-md-6">
                <div class="stat-card-admin">
                    <div class="stat-icon-admin bg-primary"><i class='bx bxs-briefcase'></i></div>
                    <div class="stat-info">
                        <div class="stat-number-admin">${totalServices}</div>
                        <div class="stat-label-admin">Dịch vụ</div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="stat-card-admin">
                    <div class="stat-icon-admin bg-success"><i class='bx bx-injection'></i></div>
                    <div class="stat-info">
                        <div class="stat-number-admin">${totalVaccines}</div>
                        <div class="stat-label-admin">Loại Vaccine</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tabs -->
        <ul class="nav nav-tabs mb-4" role="tablist">
            <li class="nav-item">
                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#servicesTab">
                    <i class='bx bxs-briefcase'></i> Dịch vụ
                </button>
            </li>
            <li class="nav-item">
                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#vaccinesTab">
                    <i class='bx bx-injection'></i> Vaccine
                </button>
            </li>
        </ul>

        <div class="tab-content">
            <!-- Services Tab -->
            <div class="tab-pane fade show active" id="servicesTab">
                <div class="card-admin">
                    <div class="card-header-admin d-flex justify-content-between align-items-center">
                        <h5><i class='bx bx-list-ul'></i> Danh sách dịch vụ</h5>
                        <button class="btn btn-primary-admin btn-sm" data-bs-toggle="modal" data-bs-target="#serviceModal" onclick="resetServiceForm()">
                            <i class='bx bx-plus'></i> Thêm dịch vụ
                        </button>
                    </div>
                    <div class="card-body-admin">
                        <div class="table-responsive">
                            <table class="table-admin">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên dịch vụ</th>
                                        <th>Danh mục</th>
                                        <th>Giá</th>
                                        <th>Thời gian</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="service" items="${services}">
                                        <tr>
                                            <td>#${service.id}</td>
                                            <td><strong>${service.name}</strong></td>
                                            <td>${service.category}</td>
                                            <td>${service.price}</td>
                                            <td>${service.durationMinutes} phút</td>
                                            <td>
                                                <span class="badge-admin ${service.active ? 'badge-success' : 'badge-secondary'}">
                                                    ${service.active ? 'Hoạt động' : 'Tạm ngưng'}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <button class="btn-action-admin btn-edit" onclick="editService(${service.id}, '${service.name}', '${service.price}', '${service.description}', '${service.category}', ${service.durationMinutes}, ${service.active})">
                                                        <i class='bx bx-edit'></i>
                                                    </button>
                                                    <button class="btn-action-admin btn-delete" onclick="confirmDeleteService(${service.id}, '${service.name}')">
                                                        <i class='bx bx-trash'></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Vaccines Tab -->
            <div class="tab-pane fade" id="vaccinesTab">
                <div class="card-admin">
                    <div class="card-header-admin d-flex justify-content-between align-items-center">
                        <h5><i class='bx bx-list-ul'></i> Danh sách Vaccine</h5>
                        <button class="btn btn-primary-admin btn-sm" data-bs-toggle="modal" data-bs-target="#vaccineModal" onclick="resetVaccineForm()">
                            <i class='bx bx-plus'></i> Thêm vaccine
                        </button>
                    </div>
                    <div class="card-body-admin">
                        <div class="table-responsive">
                            <table class="table-admin">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên vaccine</th>
                                        <th>Đối tượng</th>
                                        <th>Giá</th>
                                        <th>Số mũi</th>
                                        <th>Tồn kho</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="vaccine" items="${vaccines}">
                                        <tr>
                                            <td>#${vaccine.id}</td>
                                            <td><strong>${vaccine.name}</strong></td>
                                            <td>${vaccine.targetSpecies}</td>
                                            <td><fmt:formatNumber value="${vaccine.price}" pattern="#,###"/>đ</td>
                                            <td>${vaccine.dosesRequired} mũi</td>
                                            <td>
                                                <span class="badge-admin ${vaccine.stockQuantity > 10 ? 'badge-success' : vaccine.stockQuantity > 0 ? 'badge-warning' : 'badge-danger'}">
                                                    ${vaccine.stockQuantity}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge-admin ${vaccine.active ? 'badge-success' : 'badge-secondary'}">
                                                    ${vaccine.active ? 'Hoạt động' : 'Tạm ngưng'}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <button class="btn-action-admin btn-edit" onclick="editVaccine(${vaccine.id}, '${vaccine.name}', '${vaccine.description}', '${vaccine.targetSpecies}', '${vaccine.manufacturer}', ${vaccine.price}, ${vaccine.dosesRequired}, ${vaccine.intervalDays}, ${vaccine.stockQuantity}, ${vaccine.active})">
                                                        <i class='bx bx-edit'></i>
                                                    </button>
                                                    <button class="btn-action-admin btn-delete" onclick="confirmDeleteVaccine(${vaccine.id}, '${vaccine.name}')">
                                                        <i class='bx bx-trash'></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Service Modal -->
    <div class="modal fade" id="serviceModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="serviceModalTitle">Thêm dịch vụ</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="${pageContext.request.contextPath}/admin/services">
                    <div class="modal-body">
                        <input type="hidden" name="type" value="service">
                        <input type="hidden" name="action" id="serviceAction" value="add">
                        <input type="hidden" name="id" id="serviceId">
                        
                        <div class="mb-3">
                            <label class="form-label">Tên dịch vụ *</label>
                            <input type="text" class="form-control" name="name" id="serviceName" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Giá</label>
                                <input type="text" class="form-control" name="price" id="servicePrice" placeholder="VD: 200,000đ">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Thời gian (phút)</label>
                                <input type="number" class="form-control" name="duration" id="serviceDuration" value="30">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Danh mục</label>
                            <select class="form-select" name="category" id="serviceCategory">
                                <option value="Khám chữa bệnh">Khám chữa bệnh</option>
                                <option value="Tiêm chủng">Tiêm chủng</option>
                                <option value="Phẫu thuật">Phẫu thuật</option>
                                <option value="Spa & Grooming">Spa & Grooming</option>
                                <option value="Xét nghiệm">Xét nghiệm</option>
                                <option value="Lưu trú">Lưu trú</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="description" id="serviceDesc" rows="2"></textarea>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" name="isActive" id="serviceActive" checked>
                            <label class="form-check-label" for="serviceActive">Đang hoạt động</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary" id="serviceSubmitBtn">Thêm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Vaccine Modal -->
    <div class="modal fade" id="vaccineModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="vaccineModalTitle">Thêm vaccine</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="${pageContext.request.contextPath}/admin/services">
                    <div class="modal-body">
                        <input type="hidden" name="type" value="vaccine">
                        <input type="hidden" name="action" id="vaccineAction" value="add">
                        <input type="hidden" name="id" id="vaccineId">
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tên vaccine *</label>
                                <input type="text" class="form-control" name="name" id="vaccineName" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Nhà sản xuất</label>
                                <input type="text" class="form-control" name="manufacturer" id="vaccineManufacturer">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Đối tượng</label>
                                <select class="form-select" name="targetSpecies" id="vaccineTarget">
                                    <option value="Tất cả">Tất cả</option>
                                    <option value="Chó">Chó</option>
                                    <option value="Mèo">Mèo</option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Giá (VNĐ)</label>
                                <input type="number" class="form-control" name="price" id="vaccinePrice" value="0">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Tồn kho</label>
                                <input type="number" class="form-control" name="stockQuantity" id="vaccineStock" value="0">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số mũi cần tiêm</label>
                                <input type="number" class="form-control" name="dosesRequired" id="vaccineDoses" value="1">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Khoảng cách giữa các mũi (ngày)</label>
                                <input type="number" class="form-control" name="intervalDays" id="vaccineInterval" value="21">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="description" id="vaccineDesc" rows="2"></textarea>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" name="isActive" id="vaccineActive" checked>
                            <label class="form-check-label" for="vaccineActive">Đang hoạt động</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary" id="vaccineSubmitBtn">Thêm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Modals -->
    <div class="modal fade" id="deleteServiceModal" tabindex="-1">
        <div class="modal-dialog modal-sm modal-dialog-centered">
            <div class="modal-content text-center">
                <div class="modal-body py-4">
                    <i class='bx bx-error-circle text-danger' style="font-size:4rem;"></i>
                    <h5 class="mt-3">Xác nhận xóa?</h5>
                    <p class="text-muted">Xóa dịch vụ <strong id="deleteServiceName"></strong>?</p>
                    <form method="POST" action="${pageContext.request.contextPath}/admin/services">
                        <input type="hidden" name="type" value="service">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="deleteServiceId">
                        <div class="d-flex gap-2 justify-content-center">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-danger">Xóa</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteVaccineModal" tabindex="-1">
        <div class="modal-dialog modal-sm modal-dialog-centered">
            <div class="modal-content text-center">
                <div class="modal-body py-4">
                    <i class='bx bx-error-circle text-danger' style="font-size:4rem;"></i>
                    <h5 class="mt-3">Xác nhận xóa?</h5>
                    <p class="text-muted">Xóa vaccine <strong id="deleteVaccineName"></strong>?</p>
                    <form method="POST" action="${pageContext.request.contextPath}/admin/services">
                        <input type="hidden" name="type" value="vaccine">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="deleteVaccineId">
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
        
        // Service functions
        function resetServiceForm() {
            document.getElementById('serviceModalTitle').textContent = 'Thêm dịch vụ';
            document.getElementById('serviceSubmitBtn').textContent = 'Thêm';
            document.getElementById('serviceAction').value = 'add';
            document.getElementById('serviceId').value = '';
            document.getElementById('serviceName').value = '';
            document.getElementById('servicePrice').value = '';
            document.getElementById('serviceDesc').value = '';
            document.getElementById('serviceCategory').value = 'Khám chữa bệnh';
            document.getElementById('serviceDuration').value = '30';
            document.getElementById('serviceActive').checked = true;
        }
        
        function editService(id, name, price, desc, category, duration, active) {
            document.getElementById('serviceModalTitle').textContent = 'Chỉnh sửa dịch vụ';
            document.getElementById('serviceSubmitBtn').textContent = 'Cập nhật';
            document.getElementById('serviceAction').value = 'edit';
            document.getElementById('serviceId').value = id;
            document.getElementById('serviceName').value = name;
            document.getElementById('servicePrice').value = price === 'null' ? '' : price;
            document.getElementById('serviceDesc').value = desc === 'null' ? '' : desc;
            document.getElementById('serviceCategory').value = category || 'Khám chữa bệnh';
            document.getElementById('serviceDuration').value = duration || 30;
            document.getElementById('serviceActive').checked = active;
            new bootstrap.Modal(document.getElementById('serviceModal')).show();
        }
        
        function confirmDeleteService(id, name) {
            document.getElementById('deleteServiceId').value = id;
            document.getElementById('deleteServiceName').textContent = name;
            new bootstrap.Modal(document.getElementById('deleteServiceModal')).show();
        }
        
        // Vaccine functions
        function resetVaccineForm() {
            document.getElementById('vaccineModalTitle').textContent = 'Thêm vaccine';
            document.getElementById('vaccineSubmitBtn').textContent = 'Thêm';
            document.getElementById('vaccineAction').value = 'add';
            document.getElementById('vaccineId').value = '';
            document.getElementById('vaccineName').value = '';
            document.getElementById('vaccineDesc').value = '';
            document.getElementById('vaccineTarget').value = 'Tất cả';
            document.getElementById('vaccineManufacturer').value = '';
            document.getElementById('vaccinePrice').value = '0';
            document.getElementById('vaccineDoses').value = '1';
            document.getElementById('vaccineInterval').value = '21';
            document.getElementById('vaccineStock').value = '0';
            document.getElementById('vaccineActive').checked = true;
        }
        
        function editVaccine(id, name, desc, target, manufacturer, price, doses, interval, stock, active) {
            document.getElementById('vaccineModalTitle').textContent = 'Chỉnh sửa vaccine';
            document.getElementById('vaccineSubmitBtn').textContent = 'Cập nhật';
            document.getElementById('vaccineAction').value = 'edit';
            document.getElementById('vaccineId').value = id;
            document.getElementById('vaccineName').value = name;
            document.getElementById('vaccineDesc').value = desc === 'null' ? '' : desc;
            document.getElementById('vaccineTarget').value = target || 'Tất cả';
            document.getElementById('vaccineManufacturer').value = manufacturer === 'null' ? '' : manufacturer;
            document.getElementById('vaccinePrice').value = price;
            document.getElementById('vaccineDoses').value = doses;
            document.getElementById('vaccineInterval').value = interval;
            document.getElementById('vaccineStock').value = stock;
            document.getElementById('vaccineActive').checked = active;
            new bootstrap.Modal(document.getElementById('vaccineModal')).show();
        }
        
        function confirmDeleteVaccine(id, name) {
            document.getElementById('deleteVaccineId').value = id;
            document.getElementById('deleteVaccineName').textContent = name;
            new bootstrap.Modal(document.getElementById('deleteVaccineModal')).show();
        }
    </script>
</body>
</html>
