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
import Util.OTPUtil;
import Util.ValidationUtil;

@WebServlet("/email-login")
public class EmailLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/auth/email-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if ("send-otp".equals(action)) {
            handleSendOTP(request, response);
        } else if ("verify-otp".equals(action)) {
            handleVerifyOTP(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/email-login");
        }
    }
    
    /**
     * Xử lý gửi OTP
     */
    private void handleSendOTP(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        // Validate email
        if (ValidationUtil.isEmpty(email)) {
            request.setAttribute("error", "Vui lòng nhập email");
            request.getRequestDispatcher("/pages/auth/email-login.jsp").forward(request, response);
            return;
        }
        
        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Email không hợp lệ");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/pages/auth/email-login.jsp").forward(request, response);
            return;
        }
        
        // Gửi OTP
        boolean sent = OTPUtil.generateAndSendOTP(email);
        
        if (sent) {
            HttpSession session = request.getSession();
            session.setAttribute("pendingEmail", email);
            
            request.setAttribute("email", email);
            request.setAttribute("otpSent", true);
            request.setAttribute("success", "Mã OTP đã được gửi đến " + email);
            request.getRequestDispatcher("/pages/auth/email-login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Không thể gửi OTP. Vui lòng thử lại!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/pages/auth/email-login.jsp").forward(request, response);
        }
    }
    
    /**
     * Xử lý xác thực OTP
     */
    private void handleVerifyOTP(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("pendingEmail");
        String otp = request.getParameter("otp");
        String fullname = request.getParameter("fullname");
        
        if (email == null) {
            response.sendRedirect(request.getContextPath() + "/email-login");
            return;
        }
        
        // Validate OTP
        if (ValidationUtil.isEmpty(otp)) {
            request.setAttribute("error", "Vui lòng nhập mã OTP");
            request.setAttribute("email", email);
            request.setAttribute("otpSent", true);
            request.getRequestDispatcher("/pages/auth/email-login.jsp").forward(request, response);
            return;
        }
        
        // Verify OTP
        if (!OTPUtil.verifyOTP(email, otp)) {
            request.setAttribute("error", "Mã OTP không đúng hoặc đã hết hạn");
            request.setAttribute("email", email);
            request.setAttribute("otpSent", true);
            request.getRequestDispatcher("/pages/auth/email-login.jsp").forward(request, response);
            return;
        }
        
        // OTP hợp lệ - Kiểm tra user tồn tại
        User user = userDAO.getUserByEmail(email);
        
        if (user == null) {
            // User mới - cần nhập tên
            if (ValidationUtil.isEmpty(fullname)) {
                request.setAttribute("needFullname", true);
                request.setAttribute("email", email);
                request.setAttribute("otpVerified", true);
                request.getRequestDispatcher("/pages/auth/email-login.jsp").forward(request, response);
                return;
            }
            
            // Tạo user mới
            user = userDAO.registerWithEmail(email, fullname.trim());
            if (user == null) {
                request.setAttribute("error", "Không thể tạo tài khoản. Vui lòng thử lại!");
                request.getRequestDispatcher("/pages/auth/email-login.jsp").forward(request, response);
                return;
            }
        }
        
        // Đăng nhập thành công
        session.removeAttribute("pendingEmail");
        session.setAttribute("user", user);
        session.setAttribute("username", user.getUsername());
        session.setAttribute("role", user.getRole());
        
        // Redirect theo role
        if ("admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/pages/admin/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
