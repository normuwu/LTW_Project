<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- PRG: Đọc success message từ session (sau redirect) --%>
<c:if test="${not empty sessionScope.success}">
    <c:set var="success" value="${sessionScope.success}" scope="request"/>
    <c:remove var="success" scope="session"/>
</c:if>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="/components/meta.jsp" />
    <title>Đăng nhập - Animal Doctors</title>
    <jsp:include page="/components/head.jsp" />
    <style>
        body {
            background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            padding: 40px;
            max-width: 420px;
            width: 100%;
        }
        .login-title {
            color: #0b1a33;
            font-weight: bold;
            margin-bottom: 30px;
            text-align: center;
        }
        .btn-login {
            background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%);
            border: none;
            color: white;
            padding: 12px;
            font-weight: bold;
        }
        .btn-login:hover {
            opacity: 0.9;
            color: white;
        }
        .form-control:focus {
            border-color: #0b1a33;
            box-shadow: 0 0 0 0.2rem rgba(11, 26, 51, 0.25);
        }
        .form-control.is-invalid {
            border-color: #dc3545;
        }
        .invalid-feedback {
            display: block;
            color: #dc3545;
            font-size: 0.85rem;
            margin-top: 4px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2 class="login-title"><i class='bx bxs-dog'></i> ĐĂNG NHẬP</h2>
        
        <jsp:include page="/components/alerts.jsp" />
        
        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="mb-3">
                <label class="form-label fw-bold">Tên đăng nhập</label>
                <div class="input-group">
                    <span class="input-group-text"><i class='bx bx-user'></i></span>
                    <input type="text" class="form-control ${not empty errors.username ? 'is-invalid' : ''}" 
                           name="username" placeholder="Nhập tên đăng nhập" required
                           value="${form.username}">
                </div>
                <c:if test="${not empty errors.username}">
                    <div class="invalid-feedback">${errors.username}</div>
                </c:if>
            </div>
            
            <div class="mb-4">
                <label class="form-label fw-bold">Mật khẩu</label>
                <div class="input-group">
                    <span class="input-group-text"><i class='bx bx-lock-alt'></i></span>
                    <input type="password" class="form-control ${not empty errors.password ? 'is-invalid' : ''}" 
                           name="password" placeholder="Nhập mật khẩu" required>
                </div>
                <c:if test="${not empty errors.password}">
                    <div class="invalid-feedback">${errors.password}</div>
                </c:if>
            </div>
            
            <button type="submit" class="btn btn-login w-100 mb-3">
                <i class='bx bx-log-in'></i> Đăng nhập
            </button>
            
            <div class="text-center">
                <p class="mb-2">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="text-decoration-none">Đăng ký ngay</a></p>
                <p><a href="${pageContext.request.contextPath}/home" class="text-muted"><i class='bx bx-arrow-back'></i> Quay về trang chủ</a></p>
            </div>
        </form>
        
        <hr>
        <div class="text-muted small text-center">
            <strong>Tài khoản demo:</strong><br>
            Admin: admin / 123456<br>
            User: user1 / 123456
        </div>
    </div>
    
    <jsp:include page="/components/scripts.jsp" />
</body>
</html>
