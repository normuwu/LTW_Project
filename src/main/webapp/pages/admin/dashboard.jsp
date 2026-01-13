<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="/components/meta.jsp" />
    <title>Admin Dashboard - Animal Doctors</title>
    <jsp:include page="/components/head.jsp" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <jsp:include page="/components/admin-styles.jsp" />
    <style>
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 24px;
        }
        .stat-card {
            border-radius: 14px;
            padding: 22px;
            color: white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none;
            display: block;
        }
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            color: white;
        }
        .stat-card h3 {
            font-size: 2rem;
            margin: 0 0 6px 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .stat-card p { margin: 0; opacity: 0.9; font-size: 0.9rem; }
        .stat-card.blue { background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%); }
        .stat-card.green { background: linear-gradient(135deg, #059669 0%, #10b981 100%); }
        .stat-card.orange { background: linear-gradient(135deg, #ea580c 0%, #f97316 100%); }
        .stat-card.purple { background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%); }
        .stat-card.teal { background: linear-gradient(135deg, #0d9488 0%, #14b8a6 100%); }
        .stat-card.pink { background: linear-gradient(135deg, #db2777 0%, #ec4899 100%); }
        .stat-card.indigo { background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%); }
        .stat-card.amber { background: linear-gradient(135deg, #d97706 0%, #f59e0b 100%); }
        
        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
            margin-bottom: 24px;
        }
        .quick-action-btn {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 14px 18px;
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            text-decoration: none;
            color: #334155;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.2s;
        }
        .quick-action-btn:hover {
            background: #f8fafc;
            border-color: #0d9488;
            color: #0d9488;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        .quick-action-btn i { font-size: 1.3rem; }
        
        /* Card */
        .card {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            overflow: hidden;
            margin-bottom: 24px;
        }
        .card-header {
            padding: 16px 20px;
            border-bottom: 1px solid #e2e8f0;
            background: #f8fafc;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .card-header h5 {
            margin: 0;
            font-size: 1rem;
            font-weight: 600;
            color: #0f172a;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .card-header h5 i { color: #64748b; }
        .card-body { padding: 0; }
        
        /* Table */
        .table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
        }
        .table th {
            text-align: left;
            padding: 12px 16px;
            font-size: 0.75rem;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
        }
        .table td {
            padding: 14px 16px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.875rem;
            color: #334155;
        }
        .table tr:hover { background: #f8fafc; }
        .table tr:last-child td { border-bottom: none; }
        
        /* Badge */
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .badge.success { background: #dcfce7; color: #15803d; }
        .badge.warning { background: #fef3c7; color: #b45309; }
        .badge.info { background: #dbeafe; color: #1d4ed8; }
        .badge.danger { background: #fee2e2; color: #dc2626; }
        
        /* Two Column Layout */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #94a3b8;
        }
        .empty-state i { font-size: 3rem; margin-bottom: 12px; opacity: 0.5; }
    </style>
</head>
<body>
    <jsp:include page="/components/admin-sidebar.jsp">
        <jsp:param name="currentPage" value="dashboard"/>
    </jsp:include>

    <main class="admin-main">
        <div class="page-header-admin">
            <div>
                <h1 class="page-title"><i class='bx bxs-dashboard'></i> Dashboard</h1>
                <p class="page-subtitle">Tổng quan hệ thống Animal Doctors</p>
            </div>
            <jsp:include page="/components/admin-header-dropdown.jsp" />
        </div>
        
        <jsp:include page="/components/alerts.jsp" />
        
        <!-- Main Stats -->
        <div class="stats-grid">
            <a href="${pageContext.request.contextPath}/admin/users" class="stat-card blue">
                <h3><i class='bx bxs-user'></i> ${totalUsers != null ? totalUsers : 0}</h3>
                <p>Người dùng</p>
            </a>
            <a href="${pageContext.request.contextPath}/pages/admin/appointments" class="stat-card orange">
                <h3><i class='bx bxs-time'></i> ${pendingAppointments != null ? pendingAppointments : 0}</h3>
                <p>Lịch hẹn chờ duyệt</p>
            </a>
            <a href="${pageContext.request.contextPath}/pages/admin/appointments" class="stat-card green">
                <h3><i class='bx bxs-calendar-check'></i> ${confirmedAppointments != null ? confirmedAppointments : 0}</h3>
                <p>Lịch hẹn đã duyệt</p>
            </a>
            <div class="stat-card purple">
                <h3><i class='bx bxs-calendar'></i> ${todayAppointments != null ? todayAppointments : 0}</h3>
                <p>Lịch hẹn hôm nay</p>
            </div>
        </div>
        
        <!-- Secondary Stats -->
        <div class="stats-grid">
            <div class="stat-card teal">
                <h3><i class='bx bxs-dog'></i> ${totalPets != null ? totalPets : 0}</h3>
                <p>Thú cưng đăng ký</p>
            </div>
            <a href="${pageContext.request.contextPath}/pages/admin/products" class="stat-card pink">
                <h3><i class='bx bxs-shopping-bag'></i> ${totalProducts != null ? totalProducts : 0}</h3>
                <p>Sản phẩm</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/services" class="stat-card indigo">
                <h3><i class='bx bxs-injection'></i> ${totalServices != null ? totalServices : 0}</h3>
                <p>Dịch vụ</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/doctors" class="stat-card amber">
                <h3><i class='bx bxs-user-badge'></i> ${totalDoctors != null ? totalDoctors : 0}</h3>
                <p>Bác sĩ</p>
            </a>
        </div>
        
        <!-- Quick Actions -->
        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/pages/admin/appointments" class="quick-action-btn">
                <i class='bx bx-calendar-plus' style="color:#ea580c;"></i> Duyệt lịch hẹn
            </a>
            <a href="${pageContext.request.contextPath}/admin/hotel-bookings" class="quick-action-btn">
                <i class='bx bx-hotel' style="color:#0d9488;"></i> Quản lý khách sạn
            </a>
            <a href="${pageContext.request.contextPath}/admin/spa-bookings" class="quick-action-btn">
                <i class='bx bx-spa' style="color:#db2777;"></i> Quản lý spa
            </a>
            <a href="${pageContext.request.contextPath}/pages/admin/products" class="quick-action-btn">
                <i class='bx bx-plus-circle' style="color:#7c3aed;"></i> Thêm sản phẩm
            </a>
        </div>
        
        <!-- Two Column Content -->
        <div class="dashboard-grid">
            <!-- Today's Appointments -->
            <div class="card">
                <div class="card-header">
                    <h5><i class='bx bx-calendar-event'></i> Lịch hẹn hôm nay</h5>
                    <span class="badge info">${todayAppointments} lịch</span>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty todayAppointmentsList}">
                            <div class="empty-state">
                                <i class='bx bx-calendar-x'></i>
                                <p>Không có lịch hẹn nào hôm nay</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Khách hàng</th>
                                        <th>Dịch vụ</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="apt" items="${todayAppointmentsList}" end="4">
                                        <tr>
                                            <td>
                                                <div style="font-weight:600;">${apt.customerName}</div>
                                                <small class="text-muted">${apt.petName}</small>
                                            </td>
                                            <td>${apt.serviceName}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${apt.status == 'Pending'}">
                                                        <span class="badge warning">Chờ duyệt</span>
                                                    </c:when>
                                                    <c:when test="${apt.status == 'Confirmed'}">
                                                        <span class="badge success">Đã duyệt</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge info">${apt.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <c:if test="${todayAppointments > 5}">
                                <div class="text-center py-2">
                                    <a href="${pageContext.request.contextPath}/pages/admin/appointments" class="btn btn-sm btn-outline-primary">
                                        Xem tất cả
                                    </a>
                                </div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <!-- Recent Appointments -->
            <div class="card">
                <div class="card-header">
                    <h5><i class='bx bx-history'></i> Lịch hẹn gần đây</h5>
                    <a href="${pageContext.request.contextPath}/pages/admin/appointments" class="btn btn-sm btn-outline-primary">
                        Xem tất cả
                    </a>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty recentAppointments}">
                            <div class="empty-state">
                                <i class='bx bx-calendar-x'></i>
                                <p>Chưa có lịch hẹn nào</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Khách hàng</th>
                                        <th>Ngày hẹn</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="apt" items="${recentAppointments}">
                                        <tr>
                                            <td><strong>#${apt.id}</strong></td>
                                            <td>
                                                <div style="font-weight:600;">${apt.customerName}</div>
                                                <small class="text-muted">
                                                    <c:choose>
                                                        <c:when test="${apt.petType == 'Chó'}">
                                                            <i class='bx bxs-dog' style="color:#f59e0b;"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class='bx bxs-cat' style="color:#ec4899;"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    ${apt.petName}
                                                </small>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${apt.bookingDate}" pattern="dd/MM"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${apt.status == 'Pending'}">
                                                        <span class="badge warning">Chờ</span>
                                                    </c:when>
                                                    <c:when test="${apt.status == 'Confirmed'}">
                                                        <span class="badge success">Duyệt</span>
                                                    </c:when>
                                                    <c:when test="${apt.status == 'Completed'}">
                                                        <span class="badge info">Xong</span>
                                                    </c:when>
                                                    <c:when test="${apt.status == 'Cancelled'}">
                                                        <span class="badge danger">Hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge">${apt.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </main>
    
    <jsp:include page="/components/scripts.jsp" />
    <jsp:include page="/components/admin-toast.jsp" />
</body>
</html>
