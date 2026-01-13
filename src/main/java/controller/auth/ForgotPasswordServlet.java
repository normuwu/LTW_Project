package controller.auth;

import java.io.IOException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.UserDAO;
import Model.User;
import Util.EmailUtil;
import Util.FormHelper;

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
        
        FormHelper form = new FormHelper(request);
        String email = form.get("email");
        
        if (!form.validateRequired("email", "Email")) {
            form.applyToRequest();
            request.getRequestDispatcher("/pages/auth/forgot-password.jsp").forward(request, response);
            return;
        }
        
        if (!form.validateEmail("email")) {
            form.applyToRequest();
            request.getRequestDispatcher("/pages/auth/forgot-password.jsp").forward(request, response);
            return;
        }
        
        UserDAO dao = new UserDAO();
        User user = dao.getUserByEmail(email);
        
        // Luôn hiển thị thông báo thành công để tránh lộ thông tin email tồn tại
        if (user != null) {
            // Tạo token reset
            String token = UUID.randomUUID().toString();
            dao.saveResetToken(email, token);
            
            // Gửi email reset password
            String resetLink = request.getScheme() + "://" + request.getServerName() 
                + ":" + request.getServerPort() + request.getContextPath() 
                + "/reset-password?token=" + token;
            
            sendResetEmail(email, user.getFullname(), resetLink);
        }
        
        request.setAttribute("success", "Nếu email tồn tại trong hệ thống, bạn sẽ nhận được link đặt lại mật khẩu.");
        request.getRequestDispatcher("/pages/auth/forgot-password.jsp").forward(request, response);
    }
    
    private void sendResetEmail(String email, String fullname, String resetLink) {
        String subject = "Đặt lại mật khẩu - PetVaccine";
        String htmlContent = "<!DOCTYPE html>" +
            "<html><head><meta charset='UTF-8'></head>" +
            "<body style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>" +
            "<div style='background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; text-align: center;'>" +
            "  <h1 style='color: white; margin: 0;'>🐾 PetVaccine</h1>" +
            "</div>" +
            "<div style='padding: 30px; background: #f9f9f9;'>" +
            "  <h2 style='color: #333;'>Đặt lại mật khẩu</h2>" +
            "  <p>Xin chào <strong>" + fullname + "</strong>,</p>" +
            "  <p>Bạn đã yêu cầu đặt lại mật khẩu. Click vào nút bên dưới để tiếp tục:</p>" +
            "  <div style='text-align: center; margin: 30px 0;'>" +
            "    <a href='" + resetLink + "' style='background: #667eea; color: white; padding: 15px 30px; " +
            "       text-decoration: none; border-radius: 5px; font-weight: bold;'>Đặt lại mật khẩu</a>" +
            "  </div>" +
            "  <p style='color: #666;'>Link này sẽ hết hạn sau <strong>30 phút</strong>.</p>" +
            "  <p style='color: #999; font-size: 12px;'>Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.</p>" +
            "</div>" +
            "</body></html>";
        
        EmailUtil.sendEmailAsync(email, subject, htmlContent);
    }
}
