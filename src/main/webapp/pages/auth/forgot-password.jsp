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
            margin-bottom: 10px;
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
        .btn-submit:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }
        .form-control:focus {
            border-color: #0b1a33;
            box-shadow: 0 0 0 0.2rem rgba(11, 26, 51, 0.25);
        }
        
        /* Steps indicator */
        .steps {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }
        .step {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: #e9ecef;
            color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 14px;
            position: relative;
        }
        .step.active {
            background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%);
            color: white;
        }
        .step.completed {
            background: #28a745;
            color: white;
        }
        .step-line {
            width: 50px;
            height: 3px;
            background: #e9ecef;
            margin: 16px 10px;
        }
        .step-line.active {
            background: #28a745;
        }
        
        /* OTP Input */
        .otp-inputs {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 20px 0;
        }
        .otp-input {
            width: 50px;
            height: 55px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            border: 2px solid #dee2e6;
            border-radius: 10px;
        }
        .otp-input:focus {
            border-color: #0b1a33;
            box-shadow: 0 0 0 0.2rem rgba(11, 26, 51, 0.25);
            outline: none;
        }
        
        /* Step panels */
        .step-panel {
            display: none;
        }
        .step-panel.active {
            display: block;
        }
        
        /* Timer */
        .timer {
            color: #6c757d;
            font-size: 14px;
            text-align: center;
            margin-top: 15px;
        }
        .timer.expired {
            color: #dc3545;
        }
        
        /* Success icon */
        .success-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: #d4edda;
            color: #28a745;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            margin: 0 auto 20px;
        }
        
        /* Alert */
        .alert-message {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }
        .alert-message.show {
            display: block;
        }
        .alert-message.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-message.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="forgot-container">
        <h2 class="forgot-title"><i class='bx bx-lock-open'></i> QUÊN MẬT KHẨU</h2>
        
        <!-- Steps indicator -->
        <div class="steps">
            <div class="step active" id="step1Indicator">1</div>
            <div class="step-line" id="line1"></div>
            <div class="step" id="step2Indicator">2</div>
            <div class="step-line" id="line2"></div>
            <div class="step" id="step3Indicator">3</div>
        </div>
        
        <!-- Alert message -->
        <div class="alert-message" id="alertMessage"></div>
        
        <!-- Step 1: Nhập email -->
        <div class="step-panel active" id="step1Panel">
            <p class="text-muted text-center mb-4">
                Nhập email đã đăng ký để nhận mã OTP
            </p>
            
            <div class="mb-4">
                <label class="form-label fw-bold">Email</label>
                <div class="input-group">
                    <span class="input-group-text"><i class='bx bx-envelope'></i></span>
                    <input type="email" class="form-control" id="emailInput" 
                           placeholder="Nhập email đã đăng ký" required>
                </div>
            </div>
            
            <button type="button" class="btn btn-submit w-100 mb-3" id="sendOTPBtn" onclick="sendOTP()">
                <i class='bx bx-send'></i> Gửi mã OTP
            </button>
        </div>
        
        <!-- Step 2: Nhập OTP -->
        <div class="step-panel" id="step2Panel">
            <p class="text-muted text-center mb-2">
                Nhập mã OTP đã gửi đến email
            </p>
            <p class="text-center mb-3" id="emailDisplay"></p>
            
            <div class="otp-inputs">
                <input type="text" class="otp-input" maxlength="1" data-index="0">
                <input type="text" class="otp-input" maxlength="1" data-index="1">
                <input type="text" class="otp-input" maxlength="1" data-index="2">
                <input type="text" class="otp-input" maxlength="1" data-index="3">
                <input type="text" class="otp-input" maxlength="1" data-index="4">
                <input type="text" class="otp-input" maxlength="1" data-index="5">
            </div>
            
            <button type="button" class="btn btn-submit w-100 mb-3" id="verifyOTPBtn" onclick="verifyOTP()">
                <i class='bx bx-check'></i> Xác nhận OTP
            </button>
            
            <div class="timer" id="otpTimer">
                Mã OTP hết hạn sau: <span id="countdown">05:00</span>
            </div>
            
            <div class="text-center mt-3">
                <a href="javascript:void(0)" onclick="resendOTP()" id="resendLink" style="display: none;">
                    <i class='bx bx-refresh'></i> Gửi lại mã OTP
                </a>
            </div>
        </div>
        
        <!-- Step 3: Đặt mật khẩu mới -->
        <div class="step-panel" id="step3Panel">
            <p class="text-muted text-center mb-4">
                Nhập mật khẩu mới cho tài khoản của bạn
            </p>
            
            <div class="mb-3">
                <label class="form-label fw-bold">Mật khẩu mới</label>
                <div class="input-group">
                    <span class="input-group-text"><i class='bx bx-lock-alt'></i></span>
                    <input type="password" class="form-control" id="newPassword" 
                           placeholder="Nhập mật khẩu mới" required>
                </div>
                <small class="text-muted">Tối thiểu 6 ký tự</small>
            </div>
            
            <div class="mb-4">
                <label class="form-label fw-bold">Xác nhận mật khẩu</label>
                <div class="input-group">
                    <span class="input-group-text"><i class='bx bx-lock'></i></span>
                    <input type="password" class="form-control" id="confirmPassword" 
                           placeholder="Nhập lại mật khẩu" required>
                </div>
            </div>
            
            <button type="button" class="btn btn-submit w-100 mb-3" id="resetPasswordBtn" onclick="resetPassword()">
                <i class='bx bx-check'></i> Đặt lại mật khẩu
            </button>
        </div>
        
        <!-- Step 4: Thành công -->
        <div class="step-panel" id="successPanel">
            <div class="text-center">
                <div class="success-icon">
                    <i class='bx bx-check'></i>
                </div>
                <h4 class="text-success mb-3">Đặt lại mật khẩu thành công!</h4>
                <p class="text-muted mb-4">Bạn có thể đăng nhập với mật khẩu mới.</p>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-submit">
                    <i class='bx bx-log-in'></i> Đăng nhập ngay
                </a>
            </div>
        </div>
        
        <div class="text-center mt-3" id="backToLogin">
            <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">
                <i class='bx bx-arrow-back'></i> Quay lại đăng nhập
            </a>
        </div>
    </div>
    
    <jsp:include page="/components/scripts.jsp" />
    <script>
        var currentEmail = '';
        var countdownInterval = null;
        var timeLeft = 300; // 5 phút
        
        // Xử lý OTP inputs
        document.querySelectorAll('.otp-input').forEach(function(input, index) {
            input.addEventListener('input', function(e) {
                var value = e.target.value;
                if (value.length === 1 && index < 5) {
                    document.querySelectorAll('.otp-input')[index + 1].focus();
                }
                // Auto submit khi nhập đủ 6 số
                if (getOTPValue().length === 6) {
                    verifyOTP();
                }
            });
            
            input.addEventListener('keydown', function(e) {
                if (e.key === 'Backspace' && !e.target.value && index > 0) {
                    document.querySelectorAll('.otp-input')[index - 1].focus();
                }
            });
            
            // Chỉ cho phép nhập số
            input.addEventListener('keypress', function(e) {
                if (!/[0-9]/.test(e.key)) {
                    e.preventDefault();
                }
            });
        });
        
        function getOTPValue() {
            var otp = '';
            document.querySelectorAll('.otp-input').forEach(function(input) {
                otp += input.value;
            });
            return otp;
        }
        
        function showAlert(message, type) {
            var alert = document.getElementById('alertMessage');
            alert.textContent = message;
            alert.className = 'alert-message show ' + type;
            
            setTimeout(function() {
                alert.classList.remove('show');
            }, 5000);
        }
        
        function setLoading(btn, loading) {
            if (loading) {
                btn.disabled = true;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Đang xử lý...';
            } else {
                btn.disabled = false;
            }
        }
        
        function goToStep(step) {
            // Hide all panels
            document.querySelectorAll('.step-panel').forEach(function(p) {
                p.classList.remove('active');
            });
            
            // Update indicators
            for (var i = 1; i <= 3; i++) {
                var indicator = document.getElementById('step' + i + 'Indicator');
                indicator.classList.remove('active', 'completed');
                if (i < step) {
                    indicator.classList.add('completed');
                    indicator.innerHTML = '<i class="bx bx-check"></i>';
                } else if (i === step) {
                    indicator.classList.add('active');
                }
            }
            
            // Update lines
            document.getElementById('line1').classList.toggle('active', step > 1);
            document.getElementById('line2').classList.toggle('active', step > 2);
            
            // Show target panel
            if (step === 1) {
                document.getElementById('step1Panel').classList.add('active');
            } else if (step === 2) {
                document.getElementById('step2Panel').classList.add('active');
            } else if (step === 3) {
                document.getElementById('step3Panel').classList.add('active');
            } else if (step === 4) {
                document.getElementById('successPanel').classList.add('active');
                document.getElementById('backToLogin').style.display = 'none';
                document.querySelector('.steps').style.display = 'none';
            }
        }
        
        function startCountdown() {
            timeLeft = 300;
            document.getElementById('resendLink').style.display = 'none';
            document.getElementById('otpTimer').classList.remove('expired');
            
            if (countdownInterval) clearInterval(countdownInterval);
            
            countdownInterval = setInterval(function() {
                timeLeft--;
                var minutes = Math.floor(timeLeft / 60);
                var seconds = timeLeft % 60;
                document.getElementById('countdown').textContent = 
                    String(minutes).padStart(2, '0') + ':' + String(seconds).padStart(2, '0');
                
                if (timeLeft <= 0) {
                    clearInterval(countdownInterval);
                    document.getElementById('otpTimer').classList.add('expired');
                    document.getElementById('countdown').textContent = 'Đã hết hạn';
                    document.getElementById('resendLink').style.display = 'inline';
                }
            }, 1000);
        }
        
        function sendOTP() {
            var email = document.getElementById('emailInput').value.trim();
            if (!email) {
                showAlert('Vui lòng nhập email', 'error');
                return;
            }
            
            var btn = document.getElementById('sendOTPBtn');
            setLoading(btn, true);
            
            fetch('${pageContext.request.contextPath}/forgot-password', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'action=sendOTP&email=' + encodeURIComponent(email)
            })
            .then(function(res) { return res.json(); })
            .then(function(data) {
                if (data.success) {
                    currentEmail = email;
                    document.getElementById('emailDisplay').innerHTML = 
                        '<strong>' + email + '</strong>';
                    goToStep(2);
                    startCountdown();
                    document.querySelectorAll('.otp-input')[0].focus();
                } else {
                    showAlert(data.message, 'error');
                }
            })
            .catch(function() {
                showAlert('Có lỗi xảy ra. Vui lòng thử lại', 'error');
            })
            .finally(function() {
                btn.disabled = false;
                btn.innerHTML = '<i class="bx bx-send"></i> Gửi mã OTP';
            });
        }
        
        function resendOTP() {
            // Clear OTP inputs
            document.querySelectorAll('.otp-input').forEach(function(input) {
                input.value = '';
            });
            
            var btn = document.getElementById('resendLink');
            btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Đang gửi...';
            
            fetch('${pageContext.request.contextPath}/forgot-password', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'action=sendOTP&email=' + encodeURIComponent(currentEmail)
            })
            .then(function(res) { return res.json(); })
            .then(function(data) {
                if (data.success) {
                    showAlert('Đã gửi lại mã OTP', 'success');
                    startCountdown();
                } else {
                    showAlert(data.message, 'error');
                }
            })
            .finally(function() {
                btn.innerHTML = '<i class="bx bx-refresh"></i> Gửi lại mã OTP';
            });
        }
        
        function verifyOTP() {
            var otp = getOTPValue();
            if (otp.length !== 6) {
                showAlert('Vui lòng nhập đủ 6 số OTP', 'error');
                return;
            }
            
            var btn = document.getElementById('verifyOTPBtn');
            setLoading(btn, true);
            
            fetch('${pageContext.request.contextPath}/forgot-password', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'action=verifyOTP&email=' + encodeURIComponent(currentEmail) + '&otp=' + otp
            })
            .then(function(res) { return res.json(); })
            .then(function(data) {
                if (data.success) {
                    clearInterval(countdownInterval);
                    goToStep(3);
                    document.getElementById('newPassword').focus();
                } else {
                    showAlert(data.message, 'error');
                    // Clear OTP inputs
                    document.querySelectorAll('.otp-input').forEach(function(input) {
                        input.value = '';
                    });
                    document.querySelectorAll('.otp-input')[0].focus();
                }
            })
            .catch(function() {
                showAlert('Có lỗi xảy ra. Vui lòng thử lại', 'error');
            })
            .finally(function() {
                btn.disabled = false;
                btn.innerHTML = '<i class="bx bx-check"></i> Xác nhận OTP';
            });
        }
        
        function resetPassword() {
            var password = document.getElementById('newPassword').value;
            var confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password.length < 6) {
                showAlert('Mật khẩu phải có ít nhất 6 ký tự', 'error');
                return;
            }
            
            if (password !== confirmPassword) {
                showAlert('Mật khẩu xác nhận không khớp', 'error');
                return;
            }
            
            var btn = document.getElementById('resetPasswordBtn');
            setLoading(btn, true);
            
            fetch('${pageContext.request.contextPath}/forgot-password', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'action=resetPassword&password=' + encodeURIComponent(password) + 
                      '&confirmPassword=' + encodeURIComponent(confirmPassword)
            })
            .then(function(res) { return res.json(); })
            .then(function(data) {
                if (data.success) {
                    goToStep(4);
                } else {
                    showAlert(data.message, 'error');
                }
            })
            .catch(function() {
                showAlert('Có lỗi xảy ra. Vui lòng thử lại', 'error');
            })
            .finally(function() {
                btn.disabled = false;
                btn.innerHTML = '<i class="bx bx-check"></i> Đặt lại mật khẩu';
            });
        }
        
        // Enter key support
        document.getElementById('emailInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') sendOTP();
        });
        document.getElementById('confirmPassword').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') resetPassword();
        });
    </script>
</body>
</html>
