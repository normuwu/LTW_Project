<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - PetVaccine</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 15px 20px;
            display: block;
            transition: 0.3s;
        }
        .sidebar a:hover {
            background: rgba(255,255,255,0.1);
        }
        .main-content {
            padding: 30px;
        }
        .stat-card {
            border-radius: 10px;
            padding: 20px;
            color: white;
            margin-bottom: 20px;
        }
        .stat-card.blue { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .stat-card.green { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); }
        .stat-card.orange { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); }
        .stat-card.purple { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 sidebar p-0">
                <div class="p-4">
                    <h4>🐾 Admin Panel</h4>
                    <hr>
                </div>
                <a href="${pageContext.request.contextPath}/admin/dashboard"><i class='bx bxs-dashboard'></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/shop"><i class='bx bxs-shopping-bag'></i> Quản lý sản phẩm</a>
                <a href="${pageContext.request.contextPath}/community"><i class='bx bxs-news'></i> Quản lý bài viết</a>
                <a href="${pageContext.request.contextPath}/schedule"><i class='bx bxs-calendar'></i> Lịch hẹn</a>
                <hr>
                <a href="${pageContext.request.contextPath}/home"><i class='bx bx-home'></i> Về trang chủ</a>
                <a href="${pageContext.request.contextPath}/logout"><i class='bx bx-log-out'></i> Đăng xuất</a>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-10 main-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Dashboard</h2>
                    <div>
                        <span class="badge bg-primary">Admin: <%= user.getFullname() %></span>
                    </div>
                </div>
                
                <!-- Statistics -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="stat-card blue">
                            <h3><i class='bx bxs-user'></i> 150</h3>
                            <p>Tổng người dùng</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card green">
                            <h3><i class='bx bxs-shopping-bag'></i> 45</h3>
                            <p>Sản phẩm</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card orange">
                            <h3><i class='bx bxs-calendar'></i> 28</h3>
                            <p>Lịch hẹn hôm nay</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card purple">
                            <h3><i class='bx bxs-news'></i> 12</h3>
                            <p>Bài viết</p>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Activities -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h5>Hoạt động gần đây</h5>
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
                                    <td><span class="badge bg-success">Hoàn thành</span></td>
                                </tr>
                                <tr>
                                    <td>09:15 AM</td>
                                    <td>Trần Thị B</td>
                                    <td>Mua sản phẩm</td>
                                    <td><span class="badge bg-warning">Đang xử lý</span></td>
                                </tr>
                                <tr>
                                    <td>08:00 AM</td>
                                    <td>Lê Văn C</td>
                                    <td>Đăng ký tài khoản</td>
                                    <td><span class="badge bg-info">Mới</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
