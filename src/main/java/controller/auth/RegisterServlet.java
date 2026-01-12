package controller.auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.UserDAO;
import Util.FormHelper;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        FormHelper form = new FormHelper(request);
        
        // Lấy input
        String username = form.get("username");
        String email = form.get("email");
        String fullname = form.get("fullName");
        String password = form.getRaw("password");
        String confirmPassword = form.getRaw("confirmPassword");
        
        // === VALIDATION ===
        boolean valid = true;
        
        if (!form.validateRequired("username", "Tên đăng nhập")) {
            valid = false;
        } else if (!form.validateUsername("username")) {
            valid = false;
        }
        
        if (!form.validateRequired("email", "Email")) {
            valid = false;
        } else if (!form.validateEmail("email")) {
            valid = false;
        }
        
        if (!form.validateRequired("fullName", "Họ tên")) {
            valid = false;
        } else if (!form.validateLength("fullName", "Họ tên", 2, 100)) {
            valid = false;
        }
        
        if (!form.validateRequired("password", "Mật khẩu")) {
            valid = false;
        } else if (!form.validatePassword("password")) {
            valid = false;
        }
        
        if (!form.validatePasswordMatch("password", "confirmPassword")) {
            valid = false;
        }
        
        // Validation lỗi → forward về form (giữ lại data)
        if (!valid) {
            form.applyToRequest();
            request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
            return;
        }
        
        // === BUSINESS LOGIC ===
        UserDAO dao = new UserDAO();
        
        // Kiểm tra username đã tồn tại
        if (dao.checkUsernameExists(username)) {
            form.addError("username", "Tên đăng nhập này đã được sử dụng");
            form.addGeneralError("Tên đăng nhập đã tồn tại!");
            form.applyToRequest();
            request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
            return;
        }
        
        // Đăng ký
        boolean success = dao.register(username, password, fullname, email);
        
        if (success) {
            // PRG: Thành công → REDIRECT (tránh duplicate submit khi refresh)
            HttpSession session = request.getSession();
            session.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Thất bại → forward (giữ lại data)
            form.addGeneralError("Đăng ký thất bại! Vui lòng thử lại.");
            form.applyToRequest();
            request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
        }
    }
}

