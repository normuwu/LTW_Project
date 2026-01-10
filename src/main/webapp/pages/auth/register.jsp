<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="/components/meta.jsp" />
    <title>Đăng ký - Animal Doctors</title>
    <jsp:include page="/components/head.jsp" />
    <style>
        body {
            background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 0;
        }
        .register-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            padding: 40px;
            max-width: 500px;
            width: 100%;
        }
        .register-title {
            color: #0b1a33;
            font-weight: bold;
            margin-bottom: 30px;
            text-align: center;
        }
        .btn-register {
            background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%);
            border: none;
            color: white;
            padding: 12px;
            font-weight: bold;
        }
        .btn-register:hover {
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
    <div class="register-container">
        <h2 class="register-title"><i class='bx bxs-dog'></i> ĐĂNG KÝ TÀI KHOẢN</h2>
        
        <jsp:include page="/components/alerts.jsp" />
        
        <form method="post" action="${pageContext.request.contextPath}/register">
            <div class="mb-3">
                <label class="form-label fw-bold">Tên đăng nhập (*)</label>
                <div class="input-group">
                    <span class="input-group-text"><i class='bx bx-user'></i></span>
                    <input type="text" class="form-control" name="username" placeholder="Nhập tên đăng nhập" required>
                </div>
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold">Email (*)</label>
                <div class="input-group">
                    <span class="input-group-text"><i class='bx bx-envelope'></i></span>
                    <input type="email" class="form-control" name="email" placeholder="example@email.com" required>
                </div>
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold">Họ và tên (*)</label>
                <div class="input-group">
                    <span class="input-group-text"><i class='bx bx-id-card'></i></span>
                    <input type="text" class="form-control" name="fullName" placeholder="Nguyễn Văn A" required>
                </div>
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold">Số điện thoại</label>
                <div class="input-group">
                    <span class="input-group-text"><i class='bx bx-phone'></i></span>
                    <input type="tel" class="form-control" name="phone" placeholder="0912345678">
                </div>
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold">Mật khẩu (*)</label>
                <div class="input-group">
                    <span class="input-group-text"><i class='bx bx-lock-alt'></i></span>
                    <input type="password" class="form-control" name="password" placeholder="Tối thiểu 6 ký tự" required minlength="6">
                </div>
            </div>
            
            <div class="mb-4">
                <label class="form-label fw-bold">Xác nhận mật khẩu (*)</label>
                <div class="input-group">
                    <span class="input-group-text"><i class='bx bx-lock'></i></span>
                    <input type="password" class="form-control" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                </div>
            </div>
            
            <button type="submit" class="btn btn-register w-100 mb-3">
                <i class='bx bx-user-plus'></i> Đăng ký
            </button>
            
            <div class="text-center">
                <p class="mb-2">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">Đăng nhập</a></p>
                <p><a href="${pageContext.request.contextPath}/home" class="text-muted"><i class='bx bx-arrow-back'></i> Quay về trang chủ</a></p>
            </div>
        </form>
    </div>
    
    <jsp:include page="/components/scripts.jsp" />
</body>
</html>
