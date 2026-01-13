<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="/components/meta.jsp" />
    <title>Đặt lại mật khẩu - Animal Doctors</title>
    <jsp:include page="/components/head.jsp" />
    <style>
        body {
            background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .reset-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            padding: 40px;
            max-width: 420px;
            width: 100%;
        }
        .reset-title {
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
        .invalid-feedback {
            display: block;
        }
    </style>
</head>
<body>
    <div class="reset-container">
        <h2 class="reset-title"><i class='bx bx-key'></i> ĐẶT LẠI MẬT KHẨU</h2>
        
        <jsp:include page="/components/alerts.jsp" />
        
        <c:choose>
            <c:when test="${not empty token}">
                <p class="text-muted text-center mb-4">
                    Nhập mật khẩu mới cho tài khoản: <strong>${email}</strong>
                </p>
                
                <form method="post" action="${pageContext.request.contextPath}/reset-password">
                    <input type="hidden" name="token" value="${token}">
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Mật khẩu mới</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class='bx bx-lock-alt'></i></span>
                            <input type="password" class="form-control ${not empty errors.password ? 'is-invalid' : ''}" 
                                   name="password" placeholder="Nhập mật khẩu mới" required>
                        </div>
                        <c:if test="${not empty errors.password}">
                            <div class="invalid-feedback">${errors.password}</div>
                        </c:if>
                        <small class="text-muted">Tối thiểu 6 ký tự</small>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label fw-bold">Xác nhận mật khẩu</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class='bx bx-lock'></i></span>
                            <input type="password" class="form-control ${not empty errors.confirmPassword ? 'is-invalid' : ''}" 
                                   name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                        </div>
                        <c:if test="${not empty errors.confirmPassword}">
                            <div class="invalid-feedback">${errors.confirmPassword}</div>
                        </c:if>
                    </div>
                    
                    <button type="submit" class="btn btn-submit w-100 mb-3">
                        <i class='bx bx-check'></i> Đặt lại mật khẩu
                    </button>
                </form>
            </c:when>
            <c:otherwise>
                <div class="text-center">
                    <i class='bx bx-error-circle text-danger' style="font-size: 48px;"></i>
                    <p class="mt-3">${error}</p>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="btn btn-outline-primary">
                        Yêu cầu link mới
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
        
        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">
                <i class='bx bx-arrow-back'></i> Quay lại đăng nhập
            </a>
        </div>
    </div>
    
    <jsp:include page="/components/scripts.jsp" />
</body>
</html>
