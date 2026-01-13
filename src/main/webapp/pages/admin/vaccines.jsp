<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Quản lý Vaccine - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <jsp:include page="/components/admin-styles.jsp" />
    <style>
        * { font-family: 'Nunito', sans-serif; }
        .stats-row { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 24px; }
        .stat-box { background: white; border-radius: 12px; padding: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); display: flex; align-items: center; gap: 16px; }
        .stat-box .icon { width: 50px; height: 50px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; }
        .stat-box .icon.primary { background: #dbeafe; color: #2563eb; }
        .stat-box .icon.warning { background: #fef3c7; color: #d97706; }
        .stat-box .icon.danger { background: #fee2e2; color: #dc2626; }
        .stat-box .icon.success { background: #dcfce7; color: #16a34a; }
        .stat-box h3 { margin: 0; font-size: 1.5rem; font-weight: 700; }
        .stat-box p { margin: 0; color: #64748b; font-size: 0.85rem; }
        
        .vaccine-card { background: white; border-radius: 14px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.06); }
        .vaccine-header { background: linear-gradient(135deg, #0d9488 0%, #14b8a6 100%); color: white; padding: 16px 20px; display: flex; justify-content: space-between; align-items: center; }
        .vaccine-header h5 { margin: 0; font-weight: 700; display: flex; align-items: center; gap: 10px; }
        
        .vaccine-table { width: 100%; border-collapse: collapse; }
        .vaccine-table th { background: #f8fafc; padding: 12px 16px; text-align: left; font-size: 0.75rem; font-weight: 700; color: #64748b; text-transform: uppercase; border-bottom: 2px solid #e2e8f0; }
        .vaccine-table td { padding: 14px 16px; border-bottom: 1px solid #f1f5f9; vertical-align: middle; }
        .vaccine-table tr:hover { background: #f8fafc; }
        
        .vaccine-name { font-weight: 700; color: #1e293b; }
        .vaccine-species { display: inline-flex; align-items: center; gap: 4px; padding: 4px 10px; border-radius: 20px; font-size: 0.75rem; font-weight: 600; }
        .vaccine-species.dog { background: #fef3c7; color: #92400e; }
        .vaccine-species.cat { background: #fce7f3; color: #9d174d; }
        .vaccine-species.all { background: #dbeafe; color: #1e40af; }
        
        .stock-badge { padding: 4px 10px; border-radius: 6px; font-size: 0.75rem; font-weight: 600; }
        .stock-badge.in-stock { background: #dcfce7; color: #16a34a; }
        .stock-badge.low-stock { background: #fef3c7; color: #d97706; }
        .stock-badge.out-of-stock { background: #fee2e2; color: #dc2626; }
        
        .btn-action { padding: 6px 10px; border-radius: 6px; border: none; cursor: pointer; transition: all 0.2s; }
        .btn-action.edit { background: #dbeafe; color: #2563eb; }
        .btn-action.edit:hover { background: #bfdbfe; }
        .btn-action.delete { background: #fee2e2; color: #dc2626; }
        .btn-action.delete:hover { background: #fecaca; }
        .btn-action.stock { background: #dcfce7; color: #16a34a; }
        .btn-action.stock:hover { background: #bbf7d0; }
    </style>
</head>
<body>
    <jsp:include page="/components/admin-sidebar.jsp"><jsp:param name="currentPage" value="vaccines"/></jsp:include>
    <jsp:include page="/components/admin-toast.jsp" />
    
    <main class="admin-main">
        <div class="page-header-admin">
            <div>
                <h1 class="page-title"><i class='bx bxs-injection'></i> Quản lý Vaccine</h1>
                <p class="page-subtitle">Quản lý danh mục vaccine và tồn kho</p>
            </div>
            <div class="d-flex gap-2">
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addVaccineModal">
                    <i class='bx bx-plus'></i> Thêm Vaccine
                </button>
                <jsp:include page="/components/admin-header-dropdown.jsp" />
            </div>
        </div>

        <!-- Stats -->
        <div class="stats-row">
            <div class="stat-box">
                <div class="icon primary"><i class='bx bxs-injection'></i></div>
                <div><h3>${totalVaccines}</h3><p>Loại vaccine</p></div>
            </div>
            <div class="stat-box">
                <div class="icon success"><i class='bx bx-check-circle'></i></div>
                <div><h3>${totalVaccines - lowStockCount - outOfStockCount}</h3><p>Còn hàng</p></div>
            </div>
            <div class="stat-box">
                <div class="icon warning"><i class='bx bx-error'></i></div>
                <div><h3>${lowStockCount}</h3><p>Sắp hết</p></div>
            </div>
            <div class="stat-box">
                <div class="icon danger"><i class='bx bx-x-circle'></i></div>
                <div><h3>${outOfStockCount}</h3><p>Hết hàng</p></div>
            </div>
        </div>

        <!-- Vaccine Table -->
        <div class="vaccine-card">
            <div class="vaccine-header">
                <h5><i class='bx bx-list-ul'></i> Danh sách Vaccine</h5>
                <span class="badge bg-white text-dark">${vaccines.size()} vaccine</span>
            </div>
            <c:choose>
                <c:when test="${empty vaccines}">
                    <div class="text-center py-5">
                        <i class='bx bx-injection' style="font-size:4rem;color:#cbd5e1;"></i>
                        <p class="text-muted mt-2">Chưa có vaccine nào</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="vaccine-table">
                        <thead>
                            <tr>
                                <th>Vaccine</th>
                                <th>Đối tượng</th>
                                <th>Giá</th>
                                <th>Số mũi</th>
                                <th>Tồn kho</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="v" items="${vaccines}">
                                <tr>
                                    <td>
                                        <div class="vaccine-name">${v.name}</div>
                                        <small class="text-muted">${v.manufacturer}</small>
                                    </td>
                                    <td>
                                        <span class="vaccine-species ${v.targetSpecies == 'Chó' ? 'dog' : v.targetSpecies == 'Mèo' ? 'cat' : 'all'}">
                                            <i class='bx ${v.targetIcon}'></i> ${v.targetSpecies}
                                        </span>
                                    </td>
                                    <td><strong>${v.formattedPrice}</strong></td>
                                    <td>${v.dosesRequired} mũi</td>
                                    <td>
                                        <span class="stock-badge ${v.stockStatusClass}">${v.stockQuantity}</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${v.active}">
                                                <span class="badge bg-success">Hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Tạm ngưng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn-action stock" onclick="openStockModal(${v.id}, '${v.name}', ${v.stockQuantity})" title="Cập nhật tồn kho">
                                            <i class='bx bx-package'></i>
                                        </button>
                                        <button class="btn-action edit" onclick="openEditModal(${v.id})" title="Sửa">
                                            <i class='bx bx-edit'></i>
                                        </button>
                                        <button class="btn-action delete" onclick="confirmDelete(${v.id}, '${v.name}')" title="Xóa">
                                            <i class='bx bx-trash'></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <!-- Add Vaccine Modal -->
    <div class="modal fade" id="addVaccineModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class='bx bx-plus-circle'></i> Thêm Vaccine mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="${pageContext.request.contextPath}/admin/vaccines">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Tên vaccine <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="name" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Nhà sản xuất</label>
                                <input type="text" class="form-control" name="manufacturer">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Mô tả</label>
                            <textarea class="form-control" name="description" rows="2"></textarea>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Đối tượng</label>
                                <select class="form-select" name="targetSpecies">
                                    <option value="Chó">Chó</option>
                                    <option value="Mèo">Mèo</option>
                                    <option value="Tất cả">Tất cả</option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Giá (VNĐ) <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="price" required min="0">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Số lượng tồn</label>
                                <input type="number" class="form-control" name="stockQuantity" value="0" min="0">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Số mũi cần tiêm</label>
                                <input type="number" class="form-control" name="dosesRequired" value="1" min="1">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Khoảng cách (ngày)</label>
                                <input type="number" class="form-control" name="intervalDays" value="21" min="0">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Tuổi tối thiểu (tuần)</label>
                                <input type="number" class="form-control" name="minAgeWeeks" value="8" min="0">
                            </div>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="isActive" id="addIsActive" checked>
                            <label class="form-check-label" for="addIsActive">Đang hoạt động</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-success"><i class='bx bx-plus'></i> Thêm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Vaccine Modal -->
    <div class="modal fade" id="editVaccineModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class='bx bx-edit'></i> Chỉnh sửa Vaccine</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="${pageContext.request.contextPath}/admin/vaccines">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" id="editId">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Tên vaccine <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="name" id="editName" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Nhà sản xuất</label>
                                <input type="text" class="form-control" name="manufacturer" id="editManufacturer">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Mô tả</label>
                            <textarea class="form-control" name="description" id="editDescription" rows="2"></textarea>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Đối tượng</label>
                                <select class="form-select" name="targetSpecies" id="editTargetSpecies">
                                    <option value="Chó">Chó</option>
                                    <option value="Mèo">Mèo</option>
                                    <option value="Tất cả">Tất cả</option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Giá (VNĐ) <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="price" id="editPrice" required min="0">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Số lượng tồn</label>
                                <input type="number" class="form-control" name="stockQuantity" id="editStockQuantity" min="0">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Số mũi cần tiêm</label>
                                <input type="number" class="form-control" name="dosesRequired" id="editDosesRequired" min="1">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Khoảng cách (ngày)</label>
                                <input type="number" class="form-control" name="intervalDays" id="editIntervalDays" min="0">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Tuổi tối thiểu (tuần)</label>
                                <input type="number" class="form-control" name="minAgeWeeks" id="editMinAgeWeeks" min="0">
                            </div>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="isActive" id="editIsActive">
                            <label class="form-check-label" for="editIsActive">Đang hoạt động</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary"><i class='bx bx-save'></i> Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Stock Modal -->
    <div class="modal fade" id="stockModal" tabindex="-1">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class='bx bx-package'></i> Cập nhật tồn kho</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="${pageContext.request.contextPath}/admin/vaccines">
                    <input type="hidden" name="action" value="updateStock">
                    <input type="hidden" name="id" id="stockId">
                    <div class="modal-body">
                        <p class="mb-2">Vaccine: <strong id="stockName"></strong></p>
                        <p class="mb-3">Tồn kho hiện tại: <span id="stockCurrent" class="badge bg-info"></span></p>
                        <label class="form-label fw-bold">Số lượng thêm/bớt</label>
                        <input type="number" class="form-control" name="quantity" placeholder="VD: 10 hoặc -5">
                        <small class="text-muted">Nhập số dương để thêm, số âm để bớt</small>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-success"><i class='bx bx-check'></i> Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Form -->
    <form id="deleteForm" method="POST" action="${pageContext.request.contextPath}/admin/vaccines" style="display:none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="id" id="deleteId">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Vaccine data for editing
        var vaccinesData = {
            <c:forEach var="v" items="${vaccines}" varStatus="status">
            ${v.id}: {
                name: "${v.name}",
                description: "${v.description}",
                targetSpecies: "${v.targetSpecies}",
                manufacturer: "${v.manufacturer}",
                price: ${v.price},
                dosesRequired: ${v.dosesRequired},
                intervalDays: ${v.intervalDays},
                minAgeWeeks: ${v.minAgeWeeks},
                stockQuantity: ${v.stockQuantity},
                isActive: ${v.active}
            }${!status.last ? ',' : ''}
            </c:forEach>
        };
        
        function openEditModal(id) {
            var v = vaccinesData[id];
            if (!v) return;
            
            document.getElementById('editId').value = id;
            document.getElementById('editName').value = v.name;
            document.getElementById('editDescription').value = v.description || '';
            document.getElementById('editTargetSpecies').value = v.targetSpecies;
            document.getElementById('editManufacturer').value = v.manufacturer || '';
            document.getElementById('editPrice').value = v.price;
            document.getElementById('editDosesRequired').value = v.dosesRequired;
            document.getElementById('editIntervalDays').value = v.intervalDays;
            document.getElementById('editMinAgeWeeks').value = v.minAgeWeeks;
            document.getElementById('editStockQuantity').value = v.stockQuantity;
            document.getElementById('editIsActive').checked = v.isActive;
            
            new bootstrap.Modal(document.getElementById('editVaccineModal')).show();
        }
        
        function openStockModal(id, name, current) {
            document.getElementById('stockId').value = id;
            document.getElementById('stockName').textContent = name;
            document.getElementById('stockCurrent').textContent = current;
            new bootstrap.Modal(document.getElementById('stockModal')).show();
        }
        
        function confirmDelete(id, name) {
            if (confirm('Bạn có chắc muốn xóa vaccine "' + name + '"?')) {
                document.getElementById('deleteId').value = id;
                document.getElementById('deleteForm').submit();
            }
        }
        
        <c:if test="${not empty sessionScope.message}">
            showAdminToast('${sessionScope.message}', '${sessionScope.messageType}');
        </c:if>
        <% session.removeAttribute("message"); session.removeAttribute("messageType"); %>
    </script>
</body>
</html>
