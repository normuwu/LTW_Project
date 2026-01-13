<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="/components/meta.jsp" />
    <title>Quên mật khẩu - Animal Doctors</title>
    <jsp:include page="/components/head.jsp" />
    <style>
        body {
            background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .forgot-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            padding: 40px;
            max-width: 420px;
            width: 100%;
        }
        .forgot-title {
            color: #0b1a33;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }
        .btn-submit {
            background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%);
            border: none;
            color: white;
            padding: 12px;
            font-weight: bold;
        }
        .btn-submit:hover {
            opacity: 0.9;
            color: white;
        }
        .form-control:focus {
            border-color: #0b1a33;
            box-shadow: 0 0 0 0.2rem rgba(11, 26, 51, 0.25);
        }
    </style>
</head>
<body>
    <div class="forgot-container">
        <h2 class="forgot-title"><i class='bx bx-lock-open'></i> QUÊN MẬT KHẨU</h2>
        
        <p class="text-muted text-center mb-4">
            Nhập email đã đăng ký, chúng tôi sẽ gửi link đặt lại mật khẩu cho bạn.
        </p>
        
        <jsp:include page="/components/alerts.jsp" />
        
        <form method="post" action="${pageContext.request.contextPath}/forgot-password">
            <div class="mb-4">
                <label class="form-label fw-bold">Email</label>
                <div class="input-group">
                    <span class="input-group-text"><i class='bx bx-envelope'></i></span>
                    <input type="email" class="form-control ${not empty errors.email ? 'is-invalid' : ''}" 
                           name="email" placeholder="Nhập email đã đăng ký" required
                           value="${form.email}">
                </div>
                <c:if test="${not empty errors.email}">
                    <div class="invalid-feedback d-block">${errors.email}</div>
                </c:if>
            </div>
            
            <button type="submit" class="btn btn-submit w-100 mb-3">
                <i class='bx bx-send'></i> Gửi link đặt lại mật khẩu
            </button>
            
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">
                    <i class='bx bx-arrow-back'></i> Quay lại đăng nhập
                </a>
            </div>
        </form>
    </div>
    
    <jsp:include page="/components/scripts.jsp" />
</body>
</html>
