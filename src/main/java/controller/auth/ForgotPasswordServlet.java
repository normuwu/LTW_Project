package controller.auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.UserDAO;
import Model.User;
import Util.EmailUtil;
import Util.FormHelper;
import Util.OTPUtil;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/auth/forgot-password.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if ("sendOTP".equals(action)) {
            handleSendOTP(request, response);
        } else if ("verifyOTP".equals(action)) {
            handleVerifyOTP(request, response);
        } else if ("resetPassword".equals(action)) {
            handleResetPassword(request, response);
        } else {
            // Form submit thông thường (fallback)
            handleFormSubmit(request, response);
        }
    }
    
    // Gửi OTP qua email
    private void handleSendOTP(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            response.getWriter().write("{\"success\":false,\"message\":\"Email không được để trống\"}");
            return;
        }
        
        email = email.trim().toLowerCase();
        
        UserDAO dao = new UserDAO();
        User user = dao.getUserByEmail(email);
        
        // Luôn trả về thành công để không lộ email có tồn tại hay không
        if (user == null) {
            response.getWriter().write("{\"success\":true,\"message\":\"Nếu email tồn tại, bạn sẽ nhận được mã OTP\"}");
            return;
        }
        
        // Tạo và gửi OTP
        String otp = OTPUtil.generateOTP(email);
        boolean sent = sendResetOTPEmail(email, user.getFullname(), otp);
        
        if (sent) {
            response.getWriter().write("{\"success\":true,\"message\":\"Đã gửi mã OTP đến email của bạn\"}");
        } else {
            response.getWriter().write("{\"success\":false,\"message\":\"Không thể gửi email. Vui lòng thử lại\"}");
        }
    }
    
    // Xác thực OTP
    private void handleVerifyOTP(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String email = request.getParameter("email");
        String otp = request.getParameter("otp");
        
        if (email == null || otp == null) {
            response.getWriter().write("{\"success\":false,\"message\":\"Thiếu thông tin\"}");
            return;
        }
        
        email = email.trim().toLowerCase();
        
        // Verify OTP nhưng không xóa (để dùng cho bước reset password)
        if (OTPUtil.verifyOTP(email, otp.trim())) {
            // Lưu vào session để cho phép đặt lại mật khẩu
            HttpSession session = request.getSession();
            session.setAttribute("resetPasswordEmail", email);
            session.setAttribute("otpVerified", true);
            
            response.getWriter().write("{\"success\":true,\"message\":\"Xác thực thành công\"}");
        } else {
            response.getWriter().write("{\"success\":false,\"message\":\"Mã OTP không đúng hoặc đã hết hạn\"}");
        }
    }
    
    // Đặt lại mật khẩu
    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetPasswordEmail");
        Boolean otpVerified = (Boolean) session.getAttribute("otpVerified");
        
        if (email == null || otpVerified == null || !otpVerified) {
            response.getWriter().write("{\"success\":false,\"message\":\"Phiên làm việc hết hạn. Vui lòng thử lại\"}");
            return;
        }
        
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validation
        if (password == null || password.length() < 6) {
            response.getWriter().write("{\"success\":false,\"message\":\"Mật khẩu phải có ít nhất 6 ký tự\"}");
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            response.getWriter().write("{\"success\":false,\"message\":\"Mật khẩu xác nhận không khớp\"}");
            return;
        }
        
        // Cập nhật mật khẩu
        UserDAO dao = new UserDAO();
        boolean success = dao.updatePassword(email, password);
        
        if (success) {
            // Xóa session
            session.removeAttribute("resetPasswordEmail");
            session.removeAttribute("otpVerified");
            
            response.getWriter().write("{\"success\":true,\"message\":\"Đặt lại mật khẩu thành công!\"}");
        } else {
            response.getWriter().write("{\"success\":false,\"message\":\"Có lỗi xảy ra. Vui lòng thử lại\"}");
        }
    }
    
    // Form submit thông thường (fallback cho non-JS)
    private void handleFormSubmit(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html");
        
        FormHelper form = new FormHelper(request);
        String email = form.get("email");
        
        if (!form.validateRequired("email", "Email") || !form.validateEmail("email")) {
            form.applyToRequest();
            request.getRequestDispatcher("/pages/auth/forgot-password.jsp").forward(request, response);
            return;
        }
        
        request.setAttribute("success", "Nếu email tồn tại trong hệ thống, bạn sẽ nhận được mã OTP.");
        request.getRequestDispatcher("/pages/auth/forgot-password.jsp").forward(request, response);
    }
    
    // Gửi email OTP reset password
    private boolean sendResetOTPEmail(String email, String fullname, String otp) {
        String subject = "Mã xác thực đặt lại mật khẩu - PetVaccine";
        String htmlContent = "<!DOCTYPE html>" +
            "<html><head><meta charset='UTF-8'></head>" +
            "<body style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>" +
            "<div style='background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%); padding: 30px; text-align: center;'>" +
            "  <h1 style='color: white; margin: 0;'>🐾 PetVaccine</h1>" +
            "</div>" +
            "<div style='padding: 30px; background: #f9f9f9; text-align: center;'>" +
            "  <h2 style='color: #333;'>Đặt lại mật khẩu</h2>" +
            "  <p>Xin chào <strong>" + fullname + "</strong>,</p>" +
            "  <p>Bạn đã yêu cầu đặt lại mật khẩu. Sử dụng mã OTP sau:</p>" +
            "  <div style='background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%); color: white; " +
            "              font-size: 32px; font-weight: bold; padding: 20px 40px; border-radius: 10px; " +
            "              display: inline-block; letter-spacing: 8px; margin: 20px 0;'>" + otp + "</div>" +
            "  <p style='color: #666;'>Mã này sẽ hết hạn sau <strong>5 phút</strong>.</p>" +
            "  <p style='color: #999; font-size: 12px;'>Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.</p>" +
            "</div>" +
            "</body></html>";
        
        return EmailUtil.sendEmail(email, subject, htmlContent);
    }
}
