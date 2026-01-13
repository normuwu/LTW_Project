package controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.UserDAO;
import Model.User;

@WebServlet("/admin/users")
public class UserManageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String roleFilter = request.getParameter("role");
        List<User> users;
        
        if (roleFilter != null && !roleFilter.isEmpty()) {
            users = userDAO.getUsersByRole(roleFilter);
        } else {
            users = userDAO.getAllUsers();
        }
        
        request.setAttribute("users", users);
        request.setAttribute("totalUsers", users.size());
        request.setAttribute("totalAdmins", userDAO.countUsersByRole("admin"));
        request.setAttribute("totalRegularUsers", userDAO.countUsersByRole("user"));
        request.setAttribute("selectedRole", roleFilter);
        
        request.getRequestDispatcher("/pages/admin/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String message = "";
        String messageType = "success";

        if ("updateRole".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String newRole = request.getParameter("role");
            
            if (userDAO.updateUserRole(userId, newRole)) {
                message = "Đã cập nhật quyền người dùng thành công!";
            } else {
                message = "Có lỗi xảy ra!";
                messageType = "error";
            }

        } else if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            
            if (userDAO.deleteUser(userId)) {
                message = "Đã xóa người dùng thành công!";
            } else {
                message = "Có lỗi xảy ra khi xóa!";
                messageType = "error";
            }
        }

        request.getSession().setAttribute("message", message);
        request.getSession().setAttribute("messageType", messageType);
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
