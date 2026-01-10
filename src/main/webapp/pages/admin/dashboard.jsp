<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="/components/meta.jsp" />
    <title>Admin Dashboard - PetCare</title>
    <jsp:include page="/components/head.jsp" />
    <style>
        body {
            background: #f1f5f9;
            margin: 0;
        }
        
        /* Main Content */
        .admin-main {
            margin-left: 250px;
            padding: 28px 32px;
            min-height: 100vh;
        }
        
        /* Page Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
        }
        .page-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #0f172a;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .page-title i {
            color: #3b82f6;
        }
        .admin-badge {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 18px;
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            font-size: 0.9rem;
            color: #334155;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .admin-badge i {
            color: #3b82f6;
            font-size: 1.2rem;
        }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 28px;
        }
        .stat-card {
            border-radius: 14px;
            padding: 24px;
            color: white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none;
            display: block;
        }
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .stat-card h3 {
            font-size: 2.2rem;
            margin: 0 0 8px 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .stat-card p {
            margin: 0;
            opacity: 0.9;
            font-size: 0.95rem;
        }
        .stat-card.blue { background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%); }
        .stat-card.green { background: linear-gradient(135deg, #059669 0%, #10b981 100%); }
        .stat-card.orange { background: linear-gradient(135deg, #ea580c 0%, #f97316 100%); }
        .stat-card.purple { background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%); }
        
        /* Card */
        .card {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            overflow: hidden;
        }
        .card-header {
            padding: 18px 24px;
            border-bottom: 1px solid #e2e8f0;
            background: #f8fafc;
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
        .card-header h5 i {
            color: #64748b;
        }
        .card-body {
            padding: 0;
        }
        
        /* Table */
        .table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
        }
        .table th {
            text-align: left;
            padding: 14px 20px;
            font-size: 0.8rem;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
        }
        .table td {
            padding: 16px 20px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.9rem;
            color: #334155;
        }
        .table tr:hover {
            background: #f8fafc;
        }
        .table tr:last-child td {
            border-bottom: none;
        }
        
        /* Badge */
        .badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .badge.success { background: #dcfce7; color: #15803d; }
        .badge.warning { background: #fef3c7; color: #b45309; }
        .badge.info { background: #dbeafe; color: #1d4ed8; }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <jsp:include page="/components/admin-sidebar.jsp">
        <jsp:param name="currentPage" value="dashboard"/>
    </jsp:include>

    <!-- Main Content -->
    <main class="admin-main">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">
                <i class='bx bxs-dashboard'></i> Dashboard
            </h1>
            <div class="admin-badge">
                <i class='bx bxs-user-circle'></i>
                <span>Admin: ${sessionScope.user.fullname}</span>
            </div>
        </div>
        
        <jsp:include page="/components/alerts.jsp" />
        
        <!-- Statistics -->
        <div class="stats-grid">
            <div class="stat-card blue">
                <h3><i class='bx bxs-user'></i> ${totalUsers != null ? totalUsers : 0}</h3>
                <p>Tổng người dùng</p>
            </div>
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
        
        <!-- Recent Activities -->
        <div class="card">
            <div class="card-header">
                <h5><i class='bx bx-history'></i> Hoạt động gần đây</h5>
            </div>
            <div class="card-body">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Thời gian</th>
                            <th>Người dùng</th>
                            <th>Hoạt động</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>10:30 AM</td>
                            <td>Nguyễn Văn A</td>
                            <td>Đặt lịch tiêm vaccine</td>
                            <td><span class="badge success">Hoàn thành</span></td>
                        </tr>
                        <tr>
                            <td>09:15 AM</td>
                            <td>Trần Thị B</td>
                            <td>Mua sản phẩm</td>
                            <td><span class="badge warning">Đang xử lý</span></td>
                        </tr>
                        <tr>
                            <td>08:00 AM</td>
                            <td>Lê Văn C</td>
                            <td>Đăng ký tài khoản</td>
                            <td><span class="badge info">Mới</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
    
    <jsp:include page="/components/scripts.jsp" />
</body>
</html>

