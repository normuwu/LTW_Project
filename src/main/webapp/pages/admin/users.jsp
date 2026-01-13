<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Quản lý Người dùng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Nunito', sans-serif; }
    </style>
    <jsp:include page="/components/admin-styles.jsp" />
</head>
<body>
    <jsp:include page="/components/admin-sidebar.jsp"><jsp:param name="currentPage" value="users"/></jsp:include>
    <jsp:include page="/components/admin-toast.jsp" />
    
    <main class="admin-main">
        <div class="page-header-admin">
            <div>
                <h1 class="page-title"><i class='bx bxs-group'></i> Quản lý Người dùng</h1>
                <p class="page-subtitle">Xem và quản lý tài khoản người dùng</p>
            </div>
        </div>

        <!-- Stats -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="stat-card-admin">
                    <div class="stat-icon-admin bg-primary"><i class='bx bxs-group'></i></div>
                    <div class="stat-info">
                        <div class="stat-number-admin">${totalUsers}</div>
                        <div class="stat-label-admin">Tổng người dùng</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card-admin">
                    <div class="stat-icon-admin bg-success"><i class='bx bxs-user'></i></div>
                    <div class="stat-info">
                        <div class="stat-number-admin">${totalRegularUsers}</div>
                        <div class="stat-label-admin">Khách hàng</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card-admin">
                    <div class="stat-icon-admin bg-warning"><i class='bx bxs-crown'></i></div>
                    <div class="stat-info">
                        <div class="stat-number-admin">${totalAdmins}</div>
                        <div class="stat-label-admin">Quản trị viên</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter -->
        <div class="card-admin mb-4">
            <div class="card-body-admin py-3">
                <form method="GET" class="d-flex gap-3 align-items-center">
                    <label class="fw-bold">Lọc theo vai trò:</label>
                    <select name="role" class="form-select" style="width:200px;" onchange="this.form.submit()">
                        <option value="">Tất cả</option>
                        <option value="user" ${selectedRole == 'user' ? 'selected' : ''}>Khách hàng</option>
                        <option value="admin" ${selectedRole == 'admin' ? 'selected' : ''}>Quản trị viên</option>
                    </select>
                </form>
            </div>
        </div>

        <!-- Users Table -->
        <div class="card-admin">
            <div class="card-header-admin">
                <h5><i class='bx bx-list-ul'></i> Danh sách người dùng</h5>
            </div>
            <div class="card-body-admin">
                <div class="table-responsive">
                    <table class="table-admin">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Vai trò</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>#${user.id}</td>
                                    <td><strong>${user.username}</strong></td>
                                    <td>${user.fullname}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <span class="badge-admin ${user.role == 'admin' ? 'badge-warning' : 'badge-primary'}">
                                            ${user.role == 'admin' ? 'Admin' : 'User'}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <c:if test="${user.role != 'admin'}">
                                                <button class="btn-action-admin btn-edit" onclick="changeRole(${user.id}, '${user.username}', 'admin')" title="Nâng lên Admin">
                                                    <i class='bx bx-up-arrow-alt'></i>
                                                </button>
                                            </c:if>
                                            <c:if test="${user.role == 'admin' && user.id != sessionScope.user.id}">
                                                <button class="btn-action-admin btn-warning" onclick="changeRole(${user.id}, '${user.username}', 'user')" title="Hạ xuống User">
                                                    <i class='bx bx-down-arrow-alt'></i>
                                                </button>
                                            </c:if>
                                            <c:if test="${user.id != sessionScope.user.id}">
                                                <button class="btn-action-admin btn-delete" onclick="confirmDelete(${user.id}, '${user.username}')">
                                                    <i class='bx bx-trash'></i>
                                                </button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty users}">
                                <tr><td colspan="6" class="text-center py-4">Không có người dùng nào</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <!-- Change Role Modal -->
    <div class="modal fade" id="roleModal" tabindex="-1">
        <div class="modal-dialog modal-sm modal-dialog-centered">
            <div class="modal-content text-center">
                <div class="modal-body py-4">
                    <i class='bx bx-user-check text-primary' style="font-size:4rem;"></i>
                    <h5 class="mt-3">Thay đổi vai trò?</h5>
                    <p class="text-muted">Bạn có chắc muốn thay đổi vai trò của <strong id="roleUsername"></strong>?</p>
                    <form method="POST" action="${pageContext.request.contextPath}/admin/users">
                        <input type="hidden" name="action" value="updateRole">
                        <input type="hidden" name="userId" id="roleUserId">
                        <input type="hidden" name="role" id="newRole">
                        <div class="d-flex gap-2 justify-content-center">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Xác nhận</button>
                        </div>
                    </form>
                </div>
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
                    <p class="text-muted">Bạn có chắc muốn xóa người dùng <strong id="deleteName"></strong>?</p>
                    <form method="POST" action="${pageContext.request.contextPath}/admin/users">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="userId" id="deleteId">
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
        
        function changeRole(userId, username, role) {
            document.getElementById('roleUserId').value = userId;
            document.getElementById('roleUsername').textContent = username;
            document.getElementById('newRole').value = role;
            new bootstrap.Modal(document.getElementById('roleModal')).show();
        }
        
        function confirmDelete(userId, username) {
            document.getElementById('deleteId').value = userId;
            document.getElementById('deleteName').textContent = username;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
