<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Gửi Thông báo - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Nunito', sans-serif; }
    </style>
    <jsp:include page="/components/admin-styles.jsp" />
</head>
<body>
    <jsp:include page="/components/admin-sidebar.jsp"><jsp:param name="currentPage" value="notifications"/></jsp:include>
    <jsp:include page="/components/admin-toast.jsp" />
    
    <main class="admin-main">
        <div class="page-header-admin">
            <div>
                <h1 class="page-title"><i class='bx bxs-bell-ring'></i> Gửi Thông báo</h1>
                <p class="page-subtitle">Nhắc lịch tiêm chủng cho khách hàng</p>
            </div>
            <form method="POST" action="${pageContext.request.contextPath}/admin/notifications" class="d-flex gap-2">
                <input type="hidden" name="action" value="sendAll">
                <input type="hidden" name="days" value="${selectedDays}">
                <button type="submit" class="btn btn-primary-admin" ${empty reminders ? 'disabled' : ''}>
                    <i class='bx bx-send'></i> Gửi tất cả (${totalReminders})
                </button>
            </form>
        </div>

        <!-- Filter -->
        <div class="card-admin mb-4">
            <div class="card-body-admin py-3">
                <form method="GET" class="d-flex gap-3 align-items-center">
                    <label class="fw-bold">Lọc theo thời gian:</label>
                    <select name="days" class="form-select" style="width:200px;" onchange="this.form.submit()">
                        <option value="3" ${selectedDays == 3 ? 'selected' : ''}>Trong 3 ngày tới</option>
                        <option value="7" ${selectedDays == 7 ? 'selected' : ''}>Trong 7 ngày tới</option>
                        <option value="14" ${selectedDays == 14 ? 'selected' : ''}>Trong 14 ngày tới</option>
                        <option value="30" ${selectedDays == 30 ? 'selected' : ''}>Trong 30 ngày tới</option>
                    </select>
                </form>
            </div>
        </div>

        <!-- Stats -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="stat-card-admin">
                    <div class="stat-icon-admin bg-warning"><i class='bx bx-bell'></i></div>
                    <div class="stat-info">
                        <div class="stat-number-admin">${totalReminders}</div>
                        <div class="stat-label-admin">Cần nhắc nhở</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Reminders Table -->
        <div class="card-admin">
            <div class="card-header-admin">
                <h5><i class='bx bx-list-ul'></i> Danh sách cần nhắc nhở tiêm chủng</h5>
            </div>
            <div class="card-body-admin">
                <c:choose>
                    <c:when test="${empty reminders}">
                        <div class="text-center py-5">
                            <i class='bx bx-check-circle text-success' style="font-size:4rem;"></i>
                            <h5 class="mt-3">Không có lịch tiêm nào cần nhắc nhở</h5>
                            <p class="text-muted">Tất cả khách hàng đã được thông báo hoặc chưa đến hạn tiêm</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table-admin">
                                <thead>
                                    <tr>
                                        <th>Khách hàng</th>
                                        <th>Email</th>
                                        <th>Thú cưng</th>
                                        <th>Vaccine</th>
                                        <th>Ngày tiêm tiếp</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="reminder" items="${reminders}">
                                        <tr>
                                            <td><strong>${reminder.fullname}</strong></td>
                                            <td>${reminder.email}</td>
                                            <td>${reminder.petName}</td>
                                            <td>${reminder.vaccineName}</td>
                                            <td>
                                                <span class="badge-admin badge-warning">
                                                    <fmt:formatDate value="${reminder.nextDueDate}" pattern="dd/MM/yyyy"/>
                                                </span>
                                            </td>
                                            <td>
                                                <form method="POST" action="${pageContext.request.contextPath}/admin/notifications" style="display:inline;">
                                                    <input type="hidden" name="action" value="sendReminder">
                                                    <input type="hidden" name="email" value="${reminder.email}">
                                                    <input type="hidden" name="petName" value="${reminder.petName}">
                                                    <input type="hidden" name="vaccineName" value="${reminder.vaccineName}">
                                                    <input type="hidden" name="dueDate" value="${reminder.nextDueDate}">
                                                    <button type="submit" class="btn-action-admin btn-edit" title="Gửi nhắc nhở">
                                                        <i class='bx bx-send'></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        <c:if test="${not empty sessionScope.message}">
            showAdminToast('${sessionScope.message}', '${sessionScope.messageType}');
        </c:if>
        <% session.removeAttribute("message"); session.removeAttribute("messageType"); %>
    </script>
</body>
</html>
