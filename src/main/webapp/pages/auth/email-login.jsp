<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="/components/meta.jsp" />
    <title>Đăng nhập bằng Email - PetVaccine</title>
    <jsp:include page="/components/head.jsp" />
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            max-width: 450px;
            width: 100%;
        }
        .login-title {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
            text-align: center;
        }
        .login-subtitle {
            color: #666;
            text-align: center;
            margin-bottom: 30px;
        }
        .btn-primary-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 12px;
            font-weight: bold;
        }
        .btn-primary-custom:hover {
            opacity: 0.9;
            color: white;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .otp-input {
            font-size: 24px;
            letter-spacing: 8px;
            text-align: center;
            font-weight: bold;
        }
        .timer {
            color: #666;
            font-size: 14px;
        }
        .resend-link {
            color: #667eea;
            cursor: pointer;
        }
        .resend-link:hover {
            text-decoration: underline;
        }
        .resend-link.disabled {
            color: #999;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2 class="login-title"><i class='bx bx-envelope'></i> Đăng nhập bằng Email</h2>
        <p class="login-subtitle">Không cần mật khẩu, chỉ cần email của bạn</p>
        
        <%-- Hiển thị thông báo --%>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class='bx bx-error-circle'></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class='bx bx-check-circle'></i> ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:choose>
            <%-- Form nhập họ tên (user mới) --%>
            <c:when test="${needFullname}">
                <form method="post" action="${pageContext.request.contextPath}/email-login">
                    <input type="hidden" name="action" value="verify-otp">
                    <input type="hidden" name="otp" value="${param.otp}">
                    
                    <div class="text-center mb-4">
                        <i class='bx bx-user-plus' style="font-size: 48px; color: #667eea;"></i>
                        <h5 class="mt-2">Chào mừng bạn mới!</h5>
                        <p class="text-muted">Vui lòng cho chúng tôi biết tên của bạn</p>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label fw-bold">Họ và tên</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class='bx bx-user'></i></span>
                            <input type="text" class="form-control" name="fullname" 
                                   placeholder="Nguyễn Văn A" required autofocus>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary-custom w-100">
                        <i class='bx bx-check'></i> Hoàn tất đăng ký
                    </button>
                </form>
            </c:when>
            
            <%-- Form nhập OTP --%>
            <c:when test="${otpSent}">
                <form method="post" action="${pageContext.request.contextPath}/email-login" id="otpForm">
                    <input type="hidden" name="action" value="verify-otp">
                    
                    <div class="text-center mb-4">
                        <i class='bx bx-mail-send' style="font-size: 48px; color: #667eea;"></i>
                        <p class="mt-2">Mã OTP đã được gửi đến</p>
                        <strong>${email}</strong>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Nhập mã OTP (6 số)</label>
                        <input type="text" class="form-control otp-input" name="otp" 
                               maxlength="6" pattern="[0-9]{6}" required autofocus
                               placeholder="000000">
                    </div>
                    
                    <div class="text-center mb-3 timer" id="timerDiv">
                        Mã hết hạn sau: <span id="countdown">5:00</span>
                    </div>
                    
                    <button type="submit" class="btn btn-primary-custom w-100 mb-3">
                        <i class='bx bx-check'></i> Xác nhận
                    </button>
                    
                    <div class="text-center">
                        <span class="resend-link disabled" id="resendLink" onclick="resendOTP()">
                            <i class='bx bx-refresh'></i> Gửi lại mã
                        </span>
                    </div>
                </form>
                
                <%-- Form ẩn để gửi lại OTP --%>
                <form method="post" action="${pageContext.request.contextPath}/email-login" id="resendForm" style="display:none;">
                    <input type="hidden" name="action" value="send-otp">
                    <input type="hidden" name="email" value="${email}">
                </form>
            </c:when>
            
            <%-- Form nhập email --%>
            <c:otherwise>
                <form method="post" action="${pageContext.request.contextPath}/email-login">
                    <input type="hidden" name="action" value="send-otp">
                    
                    <div class="mb-4">
                        <label class="form-label fw-bold">Email của bạn</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class='bx bx-envelope'></i></span>
                            <input type="email" class="form-control" name="email" 
                                   placeholder="example@gmail.com" required autofocus
                                   value="${email}">
                        </div>
                        <small class="text-muted">Chúng tôi sẽ gửi mã xác thực đến email này</small>
                    </div>
                    
                    <button type="submit" class="btn btn-primary-custom w-100 mb-3">
                        <i class='bx bx-send'></i> Gửi mã xác thực
                    </button>
                </form>
            </c:otherwise>
        </c:choose>
        
        <hr>
        
        <div class="text-center">
            <p class="mb-2">
                <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">
                    <i class='bx bx-user'></i> Đăng nhập bằng tài khoản
                </a>
            </p>
            <p>
                <a href="${pageContext.request.contextPath}/home" class="text-muted">
                    <i class='bx bx-arrow-back'></i> Quay về trang chủ
                </a>
            </p>
        </div>
    </div>
    
    <jsp:include page="/components/scripts.jsp" />
    
    <c:if test="${otpSent}">
    <script>
        // Countdown timer
        let timeLeft = 300; // 5 phút
        const countdownEl = document.getElementById('countdown');
        const resendLink = document.getElementById('resendLink');
        
        const timer = setInterval(() => {
            timeLeft--;
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            countdownEl.textContent = minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
            
            if (timeLeft <= 0) {
                clearInterval(timer);
                countdownEl.textContent = 'Đã hết hạn';
                resendLink.classList.remove('disabled');
            }
        }, 1000);
        
        // Cho phép gửi lại sau 60 giây
        setTimeout(() => {
            resendLink.classList.remove('disabled');
        }, 60000);
        
        function resendOTP() {
            if (!resendLink.classList.contains('disabled')) {
                document.getElementById('resendForm').submit();
            }
        }
        
        // Auto-submit khi nhập đủ 6 số
        document.querySelector('input[name="otp"]').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
            if (this.value.length === 6) {
                document.getElementById('otpForm').submit();
            }
        });
    </script>
    </c:if>
</body>
</html>
