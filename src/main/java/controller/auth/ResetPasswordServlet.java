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
import Util.FormHelper;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String token = request.getParameter("token");
        
        if (token == null || token.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        UserDAO dao = new UserDAO();
        User user = dao.getUserByResetToken(token);
        
        if (user == null) {
            request.setAttribute("error", "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
            request.getRequestDispatcher("/pages/auth/reset-password.jsp").forward(request, response);
            return;
        }
        
        request.setAttribute("token", token);
        request.setAttribute("email", user.getEmail());
        request.getRequestDispatcher("/pages/auth/reset-password.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        FormHelper form = new FormHelper(request);
        String token = request.getParameter("token");
        String password = form.getRaw("password");
        String confirmPassword = form.getRaw("confirmPassword");
        
        // Validation
        boolean valid = true;
        
        if (!form.validateRequiredRaw("password", "Mật khẩu mới")) {
            valid = false;
        } else if (!form.validatePassword("password")) {
            valid = false;
        }
        
        if (!form.validatePasswordMatch("password", "confirmPassword")) {
            valid = false;
        }
        
        if (!valid) {
            request.setAttribute("token", token);
            form.applyToRequest();
            request.getRequestDispatcher("/pages/auth/reset-password.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra token
        UserDAO dao = new UserDAO();
        User user = dao.getUserByResetToken(token);
        
        if (user == null) {
            request.setAttribute("error", "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
            request.getRequestDispatcher("/pages/auth/reset-password.jsp").forward(request, response);
            return;
        }
        
        // Cập nhật mật khẩu
        boolean success = dao.updatePassword(user.getEmail(), password);
        
        if (success) {
            dao.clearResetToken(user.getEmail());
            HttpSession session = request.getSession();
            session.setAttribute("success", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/pages/auth/reset-password.jsp").forward(request, response);
        }
    }
}
