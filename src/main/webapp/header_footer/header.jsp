<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-lg" id="navbar">
    <div class="container-fluid px-5"> 
        
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <i class='bx bxs-plus-medical'></i> Animal Doctors
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon" style="filter: invert(1);"></span> 
        </button>

        <div class="collapse navbar-collapse justify-content-center" id="navbarContent">
            <ul class="navbar-nav mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about">Về Chúng Tôi</a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/services">Các dịch vụ</a>
                </li>
                
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/community">Cộng đồng</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/schedule">Đặt Hẹn</a></li>
            </ul>
        </div>

        <div class="d-flex align-items-center">
            <a href="#" class="btn btn-booking text-decoration-none">Đặt Hẹn</a>
            
            <%-- Hiển thị nút đăng nhập/đăng xuất --%>
            <% if (session.getAttribute("user") != null) { %>
                <div class="dropdown ms-3">
                    <button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                        <i class='bx bxs-user'></i> <%= session.getAttribute("username") %>
                    </button>
                    <ul class="dropdown-menu">
                        <% if ("admin".equals(session.getAttribute("role"))) { %>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class='bx bxs-dashboard'></i> Admin Panel
                            </a></li>
                        <% } %>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/schedule">
                            <i class='bx bxs-calendar'></i> Lịch hẹn của tôi
                        </a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                            <i class='bx bx-log-out'></i> Đăng xuất
                        </a></li>
                    </ul>
                </div>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light ms-3">
                    <i class='bx bx-log-in'></i> Đăng nhập
                </a>
            <% } %>
            
            <div class="lang-select ms-3 text-white" style="cursor: pointer; font-weight: 600;">
                <i class='bx bx-world'></i> Vi <i class='bx bx-chevron-down'></i>
            </div>
        </div>

    </div>
</nav>
<script s
rc="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
