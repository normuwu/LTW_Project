<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - PetVaccine</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .register-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            padding: 40px;
            max-width: 450px;
            width: 100%;
        }
        .register-title {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 30px;
            text-align: center;
        }
        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 12px;
            font-weight: bold;
        }
        .btn-register:hover {
            opacity: 0.9;
            color: white;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2 class="register-title">🐾 ĐĂNG KÝ TÀI KHOẢN</h2>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger" role="alert">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <form method="post" action="${pageContext.request.contextPath}/register">
            <div class="mb-3">
                <label class="form-label">Tên đăng nhập *</label>
                <input type="text" class="form-control" name="username" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Mật khẩu *</label>
                <input type="password" class="form-control" name="password" required minlength="6">
            </div>
            
            <div class="mb-3">
                <label class="form-label">Họ và tên *</label>
                <input type="text" class="form-control" name="fullname" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Email *</label>
                <input type="email" class="form-control" name="email" required>
            </div>
            
            <button type="submit" class="btn btn-register w-100 mb-3">Đăng ký</button>
            
            <div class="text-center">
                <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
                <p><a href="${pageContext.request.contextPath}/home">← Quay về trang chủ</a></p>
            </div>
        </form>
    </div>
</body>
</html>
