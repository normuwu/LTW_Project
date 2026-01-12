<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
    NAVBAR COMPONENT - Dùng chung cho tất cả trang
    Include: <jsp:include page="/components/navbar.jsp" />
--%>

<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<style>
    /* ========================================
       NAVBAR STYLES - Component chung
       ======================================== */
    
    /* Font chung */
    nav#navbar-main {
        font-family: 'Montserrat', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
    }
    nav#navbar-main a,
    nav#navbar-main button,
    nav#navbar-main span,
    nav#navbar-main .nav-link,
    nav#navbar-main .navbar-brand,
    nav#navbar-main .dropdown-item {
        font-family: 'Montserrat', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
    }
    nav#navbar-main i.bx {
        font-family: 'boxicons' !important;
    }
    
    /* Navbar container */
    nav#navbar-main {
        background-color: #ffffff !important;
        box-shadow: 0 2px 20px rgba(0, 0, 0, 0.06) !important;
        position: fixed !important;
        top: 0 !important;
        left: 0 !important;
        width: 100% !important;
        z-index: 99999 !important;
        padding: 16px 0 !important;
        margin: 0 !important;
        border: none !important;
        border-bottom: 1px solid rgba(0,0,0,0.04) !important;
    }
    
    /* Brand Logo */
    nav#navbar-main .navbar-brand {
        color: #0b1a33 !important;
        font-weight: 700 !important;
        font-size: 1.4rem !important;
        letter-spacing: -0.3px !important;
        display: flex !important;
        align-items: center !important;
        gap: 10px !important;
        text-decoration: none !important;
        padding: 0 !important;
        margin: 0 !important;
        transition: opacity 0.2s !important;
    }
    nav#navbar-main .navbar-brand:hover {
        opacity: 0.85 !important;
        text-decoration: none !important;
    }
    nav#navbar-main .navbar-brand i {
        color: #00bfa5 !important;
        font-size: 1.6rem !important;
    }
    
    /* Nav Links */
    nav#navbar-main .nav-link {
        color: #444444 !important;
        font-weight: 500 !important;
        font-size: 0.95rem !important;
        padding: 10px 18px !important;
        margin: 0 3px !important;
        text-decoration: none !important;
        background: transparent !important;
        border: none !important;
        border-radius: 8px !important;
        transition: all 0.2s ease !important;
    }
    nav#navbar-main .nav-link:hover {
        color: #0b1a33 !important;
        background: #f5f7fa !important;
        text-decoration: none !important;
    }
    
    /* Toggler */
    nav#navbar-main .navbar-toggler {
        border: 2px solid #e0e0e0 !important;
        padding: 6px 10px !important;
        background: transparent !important;
        border-radius: 8px !important;
    }
    nav#navbar-main .navbar-toggler:focus {
        box-shadow: none !important;
    }
    nav#navbar-main .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(68, 68, 68, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e") !important;
        filter: none !important;
        width: 24px !important;
        height: 24px !important;
    }
    
    /* --- BUTTONS STYLES --- */
    nav#navbar-main .btn-nav-booking {
        background: linear-gradient(135deg, #00bfa5 0%, #008f7a 100%) !important;
        color: #ffffff !important;
        border: none !important;
        padding: 12px 28px !important;
        border-radius: 50px !important;
        font-weight: 600 !important;
        font-size: 0.95rem !important;
        text-decoration: none !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 6px !important;
        transition: all 0.25s ease !important;
        box-shadow: 0 2px 8px rgba(0, 191, 165, 0.25) !important;
    }
    nav#navbar-main .btn-nav-booking:hover {
        transform: translateY(-2px) !important;
        box-shadow: 0 6px 20px rgba(0, 191, 165, 0.35) !important;
        background: linear-gradient(135deg, #008f7a 0%, #007a66 100%) !important;
        color: #ffffff !important;
    }
    
    nav#navbar-main .btn-nav-login {
        color: #444444 !important;
        border: 2px solid #e0e0e0 !important;
        background: transparent !important;
        padding: 10px 22px !important;
        border-radius: 50px !important;
        font-weight: 600 !important;
        font-size: 0.95rem !important;
        text-decoration: none !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 6px !important;
        transition: all 0.25s ease !important;
    }
    nav#navbar-main .btn-nav-login:hover {
        background-color: #0b1a33 !important;
        border-color: #0b1a33 !important;
        color: #ffffff !important;
    }
    nav#navbar-main .btn-nav-login i {
        font-size: 1.1rem !important;
        color: #00bfa5 !important;
    }
    nav#navbar-main .btn-nav-login:hover i { color: #ffffff !important; }
    
    nav#navbar-main .btn-nav-user {
        background: #f5f7fa !important;
        border: 2px solid #e8eaed !important;
        color: #333333 !important;
        padding: 10px 18px !important;
        border-radius: 50px !important;
        font-weight: 600 !important;
        font-size: 0.95rem !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 8px !important;
        transition: all 0.2s ease !important;
    }
    nav#navbar-main .btn-nav-user:hover {
        background: #ebeef2 !important;
        border-color: #d0d4d9 !important;
    }
    nav#navbar-main .btn-nav-user i {
        font-size: 1.1rem !important;
        color: #00bfa5 !important;
    }

    /* --- CART ICON STYLE (MỚI) --- */
    nav#navbar-main .btn-nav-cart {
        color: #444444 !important;
        font-size: 1.5rem !important; /* Icon to hơn chút */
        text-decoration: none !important;
        position: relative !important;
        padding: 8px !important;
        border-radius: 50% !important;
        transition: all 0.2s ease !important;
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        margin-right: 5px !important;
    }
    nav#navbar-main .btn-nav-cart:hover {
        color: #00bfa5 !important; /* Xanh lá khi hover */
        background-color: #f5f7fa !important;
    }
    nav#navbar-main .cart-badge {
        position: absolute !important;
        top: 0px !important;
        right: 0px !important;
        font-size: 0.65rem !important;
        padding: 0.25em 0.5em !important;
        background-color: #dc3545 !important; /* Màu đỏ */
        color: white !important;
        border-radius: 50rem !important;
        border: 2px solid #fff !important; /* Viền trắng tách icon */
        transform: translate(25%, -25%) !important;
    }
    
    /* Dropdown Menu */
    nav#navbar-main .dropdown-menu {
        z-index: 100000 !important;
        border: 1px solid #e8eaed !important;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12) !important;
        border-radius: 12px !important;
        padding: 10px 0 !important;
        margin-top: 10px !important;
        background: #ffffff !important;
        min-width: 200px !important;
    }
    nav#navbar-main .dropdown-item {
        padding: 12px 20px !important;
        color: #333333 !important;
        font-size: 0.95rem !important;
        font-weight: 500 !important;
        background: transparent !important;
        transition: background 0.15s ease !important;
        display: flex !important;
        align-items: center !important;
    }
    nav#navbar-main .dropdown-item:hover {
        background-color: #f5f7fa !important;
        color: #0b1a33 !important;
    }
    nav#navbar-main .dropdown-item i {
        margin-right: 12px !important;
        color: #00bfa5 !important;
        width: 18px !important;
        font-size: 1.1rem !important;
        display: inline-block !important;
    }
    nav#navbar-main .dropdown-divider {
        margin: 8px 12px !important;
        border-color: #e8eaed !important;
    }
    
    /* Lang Select */
    nav#navbar-main .nav-lang-select {
        color: #666666 !important;
        font-weight: 500 !important;
        font-size: 0.9rem !important;
        cursor: pointer !important;
        display: flex !important;
        align-items: center !important;
        gap: 5px !important;
        padding: 8px 12px !important;
        border-radius: 8px !important;
    }
    
    body { padding-top: 80px !important; margin-top: 0 !important; }
    
    @media (max-width: 991px) {
        nav#navbar-main { padding: 12px 0 !important; }
        nav#navbar-main .navbar-collapse {
            background: #ffffff !important;
            padding: 20px !important;
            border-radius: 16px !important;
            margin-top: 15px !important;
            box-shadow: 0 8px 30px rgba(0,0,0,0.12) !important;
            border: 1px solid #e8eaed !important;
        }
        nav#navbar-main .navbar-nav-buttons {
            flex-direction: column !important;
            gap: 12px !important;
            margin-top: 20px !important;
            width: 100% !important;
        }
        nav#navbar-main .btn-nav-booking,
        nav#navbar-main .btn-nav-login,
        nav#navbar-main .btn-nav-user {
            width: 100% !important;
            justify-content: center !important;
            padding: 14px 24px !important;
        }
        /* Mobile: Giỏ hàng căn giữa */
        nav#navbar-main .btn-nav-cart {
            margin: 10px auto !important;
        }
        nav#navbar-main .nav-lang-select { display: none !important; }
        body { padding-top: 70px !important; }
    }
</style>

<nav class="navbar navbar-expand-lg" id="navbar-main">
    <div class="container-fluid px-4 px-lg-5"> 
        
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <i class='bx bxs-plus-medical'></i> Animal Doctors
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMainContent">
            <span class="navbar-toggler-icon"></span> 
        </button>

        <div class="collapse navbar-collapse justify-content-center" id="navbarMainContent">
            <ul class="navbar-nav mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about">Về Chúng Tôi</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/services">Các dịch vụ</a>
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

        <div class="d-flex align-items-center gap-3 navbar-nav-buttons">
            
            <a href="${pageContext.request.contextPath}/booking" class="btn-nav-booking">
                Đặt Hẹn
            </a>

            <a href="${pageContext.request.contextPath}/shopping/cart.jsp" class="btn-nav-cart">
                <i class='bx bx-cart'></i>
                <c:if test="${not empty sessionScope.totalQuantity and sessionScope.totalQuantity > 0}">
                    <span class="cart-badge">
                        ${sessionScope.totalQuantity}
                    </span>
                </c:if>
            </a>
            
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="dropdown">
                        <button class="btn-nav-user dropdown-toggle" type="button" data-bs-toggle="dropdown">
                            <i class='bx bxs-user'></i> ${sessionScope.username}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <c:if test="${sessionScope.role == 'admin'}">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/pages/admin/dashboard">
                                        <i class='bx bxs-dashboard'></i> Admin Panel
                                    </a>
                                </li>
                            </c:if>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/schedule">
                                    <i class='bx bxs-calendar'></i> Lịch hẹn của tôi
                                </a>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                    <i class='bx bx-log-out'></i> Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn-nav-login">
                        <i class='bx bx-log-in'></i> Đăng nhập
                    </a>
                </c:otherwise>
            </c:choose>
            
            <div class="nav-lang-select d-none d-lg-flex">
                <i class='bx bx-globe'></i> Vi <i class='bx bx-chevron-down'></i>
            </div>
        </div>

    </div>
</nav>