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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/auth/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        FormHelper form = new FormHelper(request);
        
        String username = form.get("username");
        String password = form.getRaw("password");
        
        // === VALIDATION ===
        boolean valid = true;
        
        if (!form.validateRequired("username", "Tên đăng nhập")) {
            valid = false;
        }
        
        if (!form.validateRequiredRaw("password", "Mật khẩu")) {
            valid = false;
        }
        
        if (!valid) {
            form.applyToRequest();
            request.getRequestDispatcher("/pages/auth/login.jsp").forward(request, response);
            return;
        }
        
        // === BUSINESS LOGIC ===
        UserDAO dao = new UserDAO();
        User user = dao.login(username, password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            
            if ("admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/pages/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            form.addGeneralError("Tên đăng nhập hoặc mật khẩu không đúng!");
            form.applyToRequest();
            request.getRequestDispatcher("/pages/auth/login.jsp").forward(request, response);
        }
    }
}

