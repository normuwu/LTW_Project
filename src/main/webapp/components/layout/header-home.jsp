<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Header cho trang home - style transparent với dropdown đầy đủ --%>

<style>
    /* CRITICAL: Override navbar background cho trang home */
    #navbar {
        position: fixed !important;
        top: 0 !important;
        left: 0 !important;
        width: 100% !important;
        z-index: 99999 !important;
        background: transparent !important;
        background-color: transparent !important;
        transition: all 0.4s ease !important;
        padding: 15px 0 !important;
    }
    
    #navbar.navbar-scrolled {
        background: #0b1a33 !important;
        background-color: #0b1a33 !important;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1) !important;
    }
    
    #navbar .navbar-brand,
    #navbar .nav-link {
        color: #ffffff !important;
        font-weight: 600 !important;
    }
    
    #navbar .navbar-collapse {
        background: transparent !important;
    }
    
    /* Dropdown Menu cho Home */
    #navbar .dropdown-menu {
        position: absolute !important;
        z-index: 999999 !important;
        border: 1px solid rgba(255,255,255,0.2) !important;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.25) !important;
        border-radius: 12px !important;
        padding: 10px 0 !important;
        margin-top: 10px !important;
        background: rgba(255,255,255,0.98) !important;
        min-width: 220px !important;
        top: 100% !important;
        backdrop-filter: blur(10px) !important;
    }
    #navbar .dropdown-menu-services {
        left: 0 !important;
        right: auto !important;
    }
    #navbar .dropdown-menu-end {
        right: 0 !important;
        left: auto !important;
    }
    #navbar .dropdown-menu.show {
        display: block !important;
    }
    #navbar .dropdown-item {
        padding: 12px 20px !important;
        color: #333333 !important;
        font-size: 0.95rem !important;
        font-weight: 500 !important;
        background: transparent !important;
        transition: background 0.15s ease !important;
        display: flex !important;
        align-items: center !important;
    }
    #navbar .dropdown-item:hover {
        background-color: #f5f7fa !important;
        color: #0b1a33 !important;
    }
    #navbar .dropdown-item i {
        margin-right: 12px !important;
        color: #00bfa5 !important;
        width: 18px !important;
        font-size: 1.1rem !important;
    }
    #navbar .dropdown-divider {
        margin: 8px 12px !important;
        border-color: #e8eaed !important;
    }
    #navbar .btn-user-dropdown {
        background: rgba(255,255,255,0.15) !important;
        border: 2px solid rgba(255,255,255,0.4) !important;
        color: white !important;
        padding: 10px 18px !important;
        border-radius: 50px !important;
        font-weight: 600 !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 8px !important;
        transition: all 0.2s ease !important;
    }
    #navbar .btn-user-dropdown:hover {
        background: rgba(255,255,255,0.25) !important;
    }
    #navbar .btn-nav-cart {
        color: white !important;
        font-size: 1.5rem !important;
        position: relative !important;
        padding: 8px !important;
        transition: all 0.2s ease !important;
    }
    #navbar .btn-nav-cart:hover {
        color: #00ffcc !important;
    }
    #navbar .cart-badge {
        position: absolute !important;
        top: 0px !important;
        right: 0px !important;
        font-size: 0.65rem !important;
        padding: 0.25em 0.5em !important;
        background-color: #dc3545 !important;
        color: white !important;
        border-radius: 50rem !important;
        border: 2px solid rgba(255,255,255,0.8) !important;
        transform: translate(25%, -25%) !important;
    }
    
    /* User Dropdown - style riêng */
    #userDropdown {
        position: relative !important;
    }
    #userDropdownMenu {
        position: absolute !important;
        top: 100% !important;
        right: 0 !important;
        left: auto !important;
        z-index: 999999 !important;
        display: none !important;
        min-width: 220px !important;
        background: rgba(255,255,255,0.98) !important;
        border: 1px solid rgba(255,255,255,0.2) !important;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.25) !important;
        border-radius: 12px !important;
        padding: 10px 0 !important;
        margin-top: 10px !important;
        backdrop-filter: blur(10px) !important;
    }
    #userDropdownMenu.show {
        display: block !important;
    }
</style>

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
                
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Các dịch vụ <i class='bx bx-chevron-down'></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-services">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/services">
                                <i class='bx bx-grid-alt'></i> Tất cả dịch vụ
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/medical">
                                <i class='bx bx-pulse'></i> Khám & Điều Trị
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/surgery">
                                <i class='bx bx-cut'></i> Phẫu Thuật
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/vaccine">
                                <i class='bx bxs-injection'></i> Tiêm Phòng Vaccine
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/spa">
                                <i class='bx bxs-spa'></i> Làm Đẹp
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/hotel">
                                <i class='bx bxs-hotel'></i> Khách Sạn Thú Cưng
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/shop">
                                <i class='bx bx-shopping-bag'></i> Siêu Thị Thú Cưng
                            </a>
                        </li>
                    </ul>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/shop">Siêu thị</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/community">Cộng đồng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/schedule">Đặt Hẹn</a>
                </li>
            </ul>
        </div>

        <div class="d-flex align-items-center gap-3">
            <a href="${pageContext.request.contextPath}/booking" class="btn btn-booking text-decoration-none">Đặt Hẹn</a>
            
            <a href="${pageContext.request.contextPath}/shopping/cart.jsp" class="btn-nav-cart text-decoration-none">
                <i class='bx bx-cart'></i>
                <c:if test="${not empty sessionScope.totalQuantity and sessionScope.totalQuantity > 0}">
                    <span class="cart-badge">${sessionScope.totalQuantity}</span>
                </c:if>
            </a>
            
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="dropdown" id="userDropdown">
                        <button class="btn-user-dropdown" type="button" id="userDropdownBtn">
                            <i class='bx bxs-user'></i> ${sessionScope.username} <i class='bx bx-chevron-down'></i>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" id="userDropdownMenu">
                            <c:if test="${sessionScope.role == 'admin'}">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/pages/admin/dashboard">
                                        <i class='bx bxs-dashboard'></i> Admin Panel
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                            </c:if>
                            <c:if test="${sessionScope.role != 'admin'}">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/my-pets">
                                        <i class='bx bxs-dog'></i> Thú cưng của tôi
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/vaccination-history">
                                        <i class='bx bx-injection'></i> Lịch sử tiêm chủng
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/schedule">
                                        <i class='bx bxs-calendar'></i> Lịch hẹn của tôi
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                            </c:if>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                    <i class='bx bx-log-out'></i> Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light ms-2" style="color: white; border-color: rgba(255,255,255,0.5);">
                        <i class='bx bx-log-in'></i> Đăng nhập
                    </a>
                </c:otherwise>
            </c:choose>
            
            <div class="lang-select ms-2 text-white d-none d-lg-flex" style="cursor: pointer; font-weight: 600; align-items: center; gap: 5px;">
                <i class='bx bx-globe'></i> Vi <i class='bx bx-chevron-down'></i>
            </div>
        </div>

    </div>
</nav>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Dropdown toggle cho services menu
    var servicesDropdown = document.querySelector('#navbar .nav-item.dropdown .dropdown-toggle');
    if (servicesDropdown) {
        servicesDropdown.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            var menu = this.nextElementSibling;
            if (menu) {
                var isOpen = menu.classList.contains('show');
                closeAllDropdowns();
                if (!isOpen) menu.classList.add('show');
            }
        });
    }
    
    // User dropdown toggle - xử lý riêng
    var userBtn = document.getElementById('userDropdownBtn');
    var userMenu = document.getElementById('userDropdownMenu');
    
    if (userBtn && userMenu) {
        userBtn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            var isOpen = userMenu.classList.contains('show');
            closeAllDropdowns();
            if (!isOpen) {
                userMenu.classList.add('show');
            }
        });
    }
    
    // Đóng tất cả dropdown
    function closeAllDropdowns() {
        document.querySelectorAll('.dropdown-menu.show').forEach(function(menu) {
            menu.classList.remove('show');
        });
    }
    
    // Đóng dropdown khi click ra ngoài
    document.addEventListener('click', function(e) {
        if (!e.target.closest('.dropdown') && !e.target.closest('.nav-item.dropdown')) {
            closeAllDropdowns();
        }
    });
});
</script>
