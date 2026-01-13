<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Quản lý Tiêm chủng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <jsp:include page="/components/admin-styles.jsp" />
    <style>
        * { font-family: 'Nunito', sans-serif; }
        .record-card { background: white; border-radius: 14px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.06); }
        .record-header { background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%); color: white; padding: 16px 20px; display: flex; justify-content: space-between; align-items: center; }
        .record-header h5 { margin: 0; font-weight: 700; display: flex; align-items: center; gap: 10px; }
        
        .record-table { width: 100%; border-collapse: collapse; }
        .record-table th { background: #f8fafc; padding: 12px 16px; text-align: left; font-size: 0.75rem; font-weight: 700; color: #64748b; text-transform: uppercase; border-bottom: 2px solid #e2e8f0; }
        .record-table td { padding: 14px 16px; border-bottom: 1px solid #f1f5f9; vertical-align: middle; }
        .record-table tr:hover { background: #f8fafc; }
        
        .pet-info { display: flex; align-items: center; gap: 10px; }
        .pet-avatar { width: 40px; height: 40px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; }
        .pet-avatar.dog { background: #fef3c7; color: #92400e; }
        .pet-avatar.cat { background: #fce7f3; color: #9d174d; }
        
        .dose-badge { display: inline-flex; align-items: center; justify-content: center; width: 28px; height: 28px; border-radius: 50%; background: #dbeafe; color: #2563eb; font-weight: 700; font-size: 0.85rem; }
        
        .date-info { font-size: 0.9rem; }
        .date-info .next-due { font-size: 0.8rem; padding: 2px 8px; border-radius: 4px; margin-top: 4px; display: inline-block; }
        .date-info .next-due.overdue { background: #fee2e2; color: #dc2626; }
        .date-info .next-due.soon { background: #fef3c7; color: #d97706; }
        .date-info .next-due.normal { background: #dcfce7; color: #16a34a; }
        
        .btn-action { padding: 6px 10px; border-radius: 6px; border: none; cursor: pointer; transition: all 0.2s; margin: 0 2px; }
        .btn-action.edit { background: #dbeafe; color: #2563eb; }
        .btn-action.edit:hover { background: #bfdbfe; }
        .btn-action.delete { background: #fee2e2; color: #dc2626; }
        .btn-action.delete:hover { background: #fecaca; }
        
        .filter-bar { background: white; border-radius: 12px; padding: 16px 20px; margin-bottom: 20px; display: flex; gap: 12px; align-items: center; flex-wrap: wrap; }
        .filter-bar input, .filter-bar select { padding: 8px 12px; border: 1px solid #e2e8f0; border-radius: 8px; }
        
        .btn-add { background: linear-gradient(135deg, #10b981, #059669); color: white; border: none; padding: 10px 20px; border-radius: 10px; font-weight: 600; display: flex; align-items: center; gap: 8px; cursor: pointer; transition: all 0.2s; }
        .btn-add:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3); color: white; }
        
        /* Modal styles */
        .modal-content { border-radius: 16px; border: none; }
        .modal-header { background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%); color: white; border-radius: 16px 16px 0 0; }
        .modal-header .btn-close { filter: brightness(0) invert(1); }
        .form-label { font-weight: 600; color: #374151; margin-bottom: 6px; }
        .form-control, .form-select { border-radius: 10px; padding: 10px 14px; border: 1px solid #e2e8f0; }
        .form-control:focus, .form-select:focus { border-color: #7c3aed; box-shadow: 0 0 0 3px rgba(124, 58, 237, 0.1); }
        .btn-submit { background: linear-gradient(135deg, #7c3aed, #6d28d9); color: white; border: none; padding: 12px 24px; border-radius: 10px; font-weight: 600; }
        .btn-submit:hover { background: linear-gradient(135deg, #6d28d9, #5b21b6); color: white; }
        
        .appointment-link { background: #f0fdf4; border: 1px solid #bbf7d0; border-radius: 8px; padding: 10px; margin-bottom: 15px; }
        .appointment-link small { color: #16a34a; }
    </style>
</head>
<body>
    <jsp:include page="/components/admin-sidebar.jsp"><jsp:param name="currentPage" value="vaccination-records"/></jsp:include>
    <jsp:include page="/components/admin-toast.jsp" />
    
    <main class="admin-main">
        <div class="page-header-admin">
            <div>
                <h1 class="page-title"><i class='bx bx-injection'></i> Quản lý Tiêm chủng</h1>
                <p class="page-subtitle">Ghi nhận và theo dõi lịch sử tiêm chủng của thú cưng</p>
            </div>
            <jsp:include page="/components/admin-header-dropdown.jsp" />
        </div>

        <!-- Filter & Add Button -->
        <div class="filter-bar">
            <input type="text" id="searchInput" placeholder="Tìm theo tên thú cưng, chủ..." onkeyup="filterTable()">
            <select id="filterVaccine" onchange="filterTable()">
                <option value="">Tất cả vaccine</option>
                <c:forEach var="v" items="${vaccines}">
                    <option value="${v.name}">${v.name}</option>
                </c:forEach>
            </select>
            <span class="text-muted">${totalRecords} bản ghi</span>
            <button class="btn-add ms-auto" data-bs-toggle="modal" data-bs-target="#addRecordModal">
                <i class='bx bx-plus'></i> Thêm bản ghi tiêm
            </button>
        </div>

        <!-- Records Table -->
        <div class="record-card">
            <div class="record-header">
                <h5><i class='bx bx-list-ul'></i> Danh sách Tiêm chủng</h5>
            </div>
            <c:choose>
                <c:when test="${empty records}">
                    <div class="text-center py-5">
                        <i class='bx bx-injection' style="font-size:4rem;color:#cbd5e1;"></i>
                        <p class="text-muted mt-2">Chưa có lịch sử tiêm chủng nào</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="record-table" id="recordsTable">
                            <thead>
                                <tr>
                                    <th>Thú cưng</th>
                                    <th>Chủ sở hữu</th>
                                    <th>Vaccine</th>
                                    <th>Mũi</th>
                                    <th>Ngày tiêm</th>
                                    <th>Bác sĩ</th>
                                    <th>Số lô</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="r" items="${records}">
                                    <tr>
                                        <td>
                                            <div class="pet-info">
                                                <div class="pet-avatar ${r.petSpecies == 'Chó' ? 'dog' : 'cat'}">
                                                    <i class='bx ${r.petSpecies == "Chó" ? "bxs-dog" : "bxs-cat"}'></i>
                                                </div>
                                                <div>
                                                    <div style="font-weight:600;">${r.petName}</div>
                                                    <small class="text-muted">${r.petSpecies}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>${r.ownerName != null ? r.ownerName : '-'}</td>
                                        <td><strong>${r.vaccineName}</strong></td>
                                        <td><span class="dose-badge">${r.doseNumber}</span></td>
                                        <td>
                                            <div class="date-info">
                                                <div><fmt:formatDate value="${r.vaccinationDate}" pattern="dd/MM/yyyy"/></div>
                                                <c:if test="${r.nextDueDate != null}">
                                                    <c:choose>
                                                        <c:when test="${r.due}">
                                                            <span class="next-due overdue">Quá hạn: <fmt:formatDate value="${r.nextDueDate}" pattern="dd/MM"/></span>
                                                        </c:when>
                                                        <c:when test="${r.comingSoon}">
                                                            <span class="next-due soon">Sắp đến: <fmt:formatDate value="${r.nextDueDate}" pattern="dd/MM"/></span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="next-due normal">Tiếp: <fmt:formatDate value="${r.nextDueDate}" pattern="dd/MM"/></span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>${r.doctorName != null ? r.doctorName : '-'}</td>
                                        <td><small class="text-muted">${r.batchNumber != null ? r.batchNumber : '-'}</small></td>
                                        <td>
                                            <button class="btn-action edit" onclick="openEditModal(${r.id}, ${r.vaccineId}, ${r.doctorId != null ? r.doctorId : 0}, '${r.vaccinationDate}', ${r.doseNumber}, '${r.batchNumber != null ? r.batchNumber : ""}', '${r.nextDueDate != null ? r.nextDueDate : ""}', '${r.notes != null ? r.notes : ""}')" title="Sửa">
                                                <i class='bx bx-edit'></i>
                                            </button>
                                            <button class="btn-action delete" onclick="confirmDelete(${r.id})" title="Xóa">
                                                <i class='bx bx-trash'></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <!-- Add Record Modal -->
    <div class="modal fade" id="addRecordModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class='bx bx-plus-medical'></i> Thêm bản ghi tiêm chủng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="${pageContext.request.contextPath}/admin/vaccination-records">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-body">
                        <!-- Liên kết với lịch hẹn -->
                        <c:if test="${not empty vaccineAppointments}">
                            <div class="appointment-link">
                                <label class="form-label"><i class='bx bx-calendar-check'></i> Liên kết với lịch hẹn (tùy chọn)</label>
                                <select class="form-select" name="appointmentId" id="appointmentSelect" onchange="fillFromAppointment()">
                                    <option value="">-- Không liên kết --</option>
                                    <c:forEach var="apt" items="${vaccineAppointments}">
                                        <option value="${apt.id}" data-pet="${apt.petName}" data-date="${apt.bookingDate}" data-doctor="${apt.doctorId}">
                                            #${apt.id} - ${apt.customerName} - ${apt.petName} (${apt.petType}) - <fmt:formatDate value="${apt.bookingDate}" pattern="dd/MM/yyyy"/>
                                        </option>
                                    </c:forEach>
                                </select>
                                <small>Chọn lịch hẹn để tự động điền thông tin và đánh dấu hoàn thành</small>
                            </div>
                        </c:if>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Thú cưng <span class="text-danger">*</span></label>
                                <select class="form-select" name="petId" id="petSelect" required>
                                    <option value="">-- Chọn thú cưng --</option>
                                    <c:forEach var="pet" items="${allPets}">
                                        <option value="${pet.id}">${pet.name} (${pet.species}) - ${pet.ownerName != null ? pet.ownerName : 'Chưa có chủ'}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Vaccine <span class="text-danger">*</span></label>
                                <select class="form-select" name="vaccineId" id="vaccineSelect" required onchange="updateNextDueDate()">
                                    <option value="">-- Chọn vaccine --</option>
                                    <c:forEach var="v" items="${vaccines}">
                                        <option value="${v.id}" data-interval="${v.intervalDays}">${v.name} (${v.targetSpecies})</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Ngày tiêm <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" name="vaccinationDate" id="vaccinationDate" required onchange="updateNextDueDate()">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số mũi <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="doseNumber" id="doseNumber" value="1" min="1" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Bác sĩ thực hiện</label>
                                <select class="form-select" name="doctorId" id="doctorSelect">
                                    <option value="0">-- Chọn bác sĩ --</option>
                                    <c:forEach var="d" items="${doctors}">
                                        <option value="${d.id}">${d.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số lô vaccine</label>
                                <input type="text" class="form-control" name="batchNumber" placeholder="VD: LOT2024-001">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Ngày tiêm mũi tiếp theo</label>
                                <input type="date" class="form-control" name="nextDueDate" id="nextDueDate">
                                <small class="text-muted">Tự động tính dựa trên vaccine</small>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Ghi chú</label>
                                <textarea class="form-control" name="notes" rows="2" placeholder="Ghi chú thêm..."></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn-submit">
                            <i class='bx bx-check'></i> Lưu bản ghi
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Record Modal -->
    <div class="modal fade" id="editRecordModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class='bx bx-edit'></i> Sửa bản ghi tiêm chủng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="${pageContext.request.contextPath}/admin/vaccination-records">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" id="editId">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Vaccine <span class="text-danger">*</span></label>
                            <select class="form-select" name="vaccineId" id="editVaccineId" required>
                                <c:forEach var="v" items="${vaccines}">
                                    <option value="${v.id}">${v.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Bác sĩ</label>
                            <select class="form-select" name="doctorId" id="editDoctorId">
                                <option value="0">-- Chọn bác sĩ --</option>
                                <c:forEach var="d" items="${doctors}">
                                    <option value="${d.id}">${d.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="row">
                            <div class="col-6 mb-3">
                                <label class="form-label">Ngày tiêm <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" name="vaccinationDate" id="editVaccinationDate" required>
                            </div>
                            <div class="col-6 mb-3">
                                <label class="form-label">Số mũi <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="doseNumber" id="editDoseNumber" min="1" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số lô vaccine</label>
                            <input type="text" class="form-control" name="batchNumber" id="editBatchNumber">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ngày tiêm mũi tiếp theo</label>
                            <input type="date" class="form-control" name="nextDueDate" id="editNextDueDate">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ghi chú</label>
                            <textarea class="form-control" name="notes" id="editNotes" rows="2"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn-submit">
                            <i class='bx bx-check'></i> Cập nhật
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Form -->
    <form id="deleteForm" method="POST" action="${pageContext.request.contextPath}/admin/vaccination-records" style="display:none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="id" id="deleteId">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set default date to today
        document.addEventListener('DOMContentLoaded', function() {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById('vaccinationDate').value = today;
        });
        
        function filterTable() {
            var search = document.getElementById('searchInput').value.toLowerCase();
            var vaccine = document.getElementById('filterVaccine').value.toLowerCase();
            var rows = document.querySelectorAll('#recordsTable tbody tr');
            
            rows.forEach(function(row) {
                var text = row.textContent.toLowerCase();
                var matchSearch = text.includes(search);
                var matchVaccine = !vaccine || text.includes(vaccine);
                row.style.display = (matchSearch && matchVaccine) ? '' : 'none';
            });
        }
        
        function updateNextDueDate() {
            var vaccineSelect = document.getElementById('vaccineSelect');
            var vaccinationDate = document.getElementById('vaccinationDate').value;
            var nextDueDateInput = document.getElementById('nextDueDate');
            
            if (vaccineSelect.value && vaccinationDate) {
                var selectedOption = vaccineSelect.options[vaccineSelect.selectedIndex];
                var intervalDays = parseInt(selectedOption.getAttribute('data-interval')) || 0;
                
                if (intervalDays > 0) {
                    var date = new Date(vaccinationDate);
                    date.setDate(date.getDate() + intervalDays);
                    nextDueDateInput.value = date.toISOString().split('T')[0];
                }
            }
        }
        
        function fillFromAppointment() {
            var select = document.getElementById('appointmentSelect');
            if (!select) return;
            
            var selectedOption = select.options[select.selectedIndex];
            if (selectedOption.value) {
                var doctorId = selectedOption.getAttribute('data-doctor');
                var date = selectedOption.getAttribute('data-date');
                
                if (doctorId && doctorId !== 'null') {
                    document.getElementById('doctorSelect').value = doctorId;
                }
                if (date) {
                    document.getElementById('vaccinationDate').value = date;
                    updateNextDueDate();
                }
            }
        }
        
        function openEditModal(id, vaccineId, doctorId, vaccinationDate, doseNumber, batchNumber, nextDueDate, notes) {
            document.getElementById('editId').value = id;
            document.getElementById('editVaccineId').value = vaccineId;
            document.getElementById('editDoctorId').value = doctorId || 0;
            document.getElementById('editVaccinationDate').value = vaccinationDate;
            document.getElementById('editDoseNumber').value = doseNumber;
            document.getElementById('editBatchNumber').value = batchNumber;
            document.getElementById('editNextDueDate').value = nextDueDate;
            document.getElementById('editNotes').value = notes;
            
            var modal = new bootstrap.Modal(document.getElementById('editRecordModal'));
            modal.show();
        }
        
        function confirmDelete(id) {
            if (confirm('Bạn có chắc muốn xóa bản ghi này?')) {
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
