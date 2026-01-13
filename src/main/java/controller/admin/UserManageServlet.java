package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.UserDAO;
import DAO.PetDAO;
import DAO.AppointmentDAO;
import Model.User;
import Model.Pet;
import Model.Appointment;

@WebServlet(urlPatterns = {"/admin/users", "/admin/users/api"})
public class UserManageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        // API endpoint để lấy pets và appointments
        if (path.equals("/admin/users/api")) {
            handleApiRequest(request, response);
            return;
        }
        
        String keyword = request.getParameter("keyword");
        String roleFilter = request.getParameter("role");
        
        List<User> users;
        
        // Tìm kiếm hoặc lọc
        if ((keyword != null && !keyword.isEmpty()) || (roleFilter != null && !roleFilter.isEmpty())) {
            users = userDAO.searchUsers(keyword, roleFilter);
        } else {
            users = userDAO.getAllUsersWithStats();
        }
        
        // Thống kê
        request.setAttribute("users", users);
        request.setAttribute("totalUsers", userDAO.countUsers());
        request.setAttribute("totalAdmins", userDAO.countUsersByRole("admin"));
        request.setAttribute("totalRegularUsers", userDAO.countUsersByRole("user"));
        request.setAttribute("newUsersThisWeek", userDAO.countNewUsersThisWeek());
        request.setAttribute("selectedRole", roleFilter);
        request.setAttribute("keyword", keyword);
        
        // Lấy chi tiết user nếu có
        String viewId = request.getParameter("viewId");
        if (viewId != null && !viewId.isEmpty()) {
            try {
                int userId = Integer.parseInt(viewId);
                User viewUser = userDAO.getUserFullById(userId);
                request.setAttribute("viewUser", viewUser);
                
                // Lấy thú cưng và lịch hẹn của user
                PetDAO petDAO = new PetDAO();
                AppointmentDAO appointmentDAO = new AppointmentDAO();
                request.setAttribute("userPets", petDAO.getPetsByUserId(userId));
                request.setAttribute("userAppointments", appointmentDAO.getAppointmentsByUserId(userId));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        request.getRequestDispatcher("/pages/admin/users.jsp").forward(request, response);
    }
    
    // API để lấy pets và appointments của user
    private void handleApiRequest(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        String action = request.getParameter("action");
        String userIdStr = request.getParameter("userId");
        
        if (userIdStr == null || userIdStr.isEmpty()) {
            out.print("{\"error\": \"Missing userId\"}");
            return;
        }
        
        try {
            int userId = Integer.parseInt(userIdStr);
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            
            if ("getPets".equals(action)) {
                PetDAO petDAO = new PetDAO();
                List<Pet> pets = petDAO.getPetsByUserId(userId);
                
                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < pets.size(); i++) {
                    Pet p = pets.get(i);
                    if (i > 0) json.append(",");
                    json.append("{");
                    json.append("\"id\":").append(p.getId()).append(",");
                    json.append("\"name\":\"").append(escapeJson(p.getName())).append("\",");
                    json.append("\"species\":\"").append(escapeJson(p.getSpecies())).append("\",");
                    json.append("\"breed\":\"").append(escapeJson(p.getBreed() != null ? p.getBreed() : "")).append("\",");
                    json.append("\"gender\":\"").append(escapeJson(p.getGender() != null ? p.getGender() : "")).append("\",");
                    json.append("\"age\":\"").append(escapeJson(p.getAge() != null ? p.getAge() : "")).append("\",");
                    json.append("\"vaccinationCount\":").append(p.getVaccinationCount());
                    json.append("}");
                }
                json.append("]");
                out.print(json.toString());
                
            } else if ("getAppointments".equals(action)) {
                AppointmentDAO appointmentDAO = new AppointmentDAO();
                List<Appointment> appointments = appointmentDAO.getAppointmentsByUserId(userId);
                
                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < appointments.size(); i++) {
                    Appointment a = appointments.get(i);
                    if (i > 0) json.append(",");
                    json.append("{");
                    json.append("\"id\":").append(a.getId()).append(",");
                    json.append("\"petName\":\"").append(escapeJson(a.getPetName())).append("\",");
                    json.append("\"serviceName\":\"").append(escapeJson(a.getServiceName())).append("\",");
                    json.append("\"doctorName\":\"").append(escapeJson(a.getDoctorName() != null ? a.getDoctorName() : "Chưa chỉ định")).append("\",");
                    json.append("\"bookingDate\":\"").append(a.getBookingDate() != null ? sdf.format(a.getBookingDate()) : "").append("\",");
                    json.append("\"status\":\"").append(escapeJson(a.getStatus())).append("\"");
                    json.append("}");
                }
                json.append("]");
                out.print(json.toString());
                
            } else {
                out.print("{\"error\": \"Invalid action\"}");
            }
        } catch (Exception e) {
            out.print("{\"error\": \"" + escapeJson(e.getMessage()) + "\"}");
        }
    }
    
    // Helper để escape JSON string
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String message = "";
        String messageType = "success";

        try {
            switch (action) {
                case "add":
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String fullname = request.getParameter("fullname");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phone");
                    String role = request.getParameter("role");
                    
                    if (userDAO.checkUsernameExists(username)) {
                        message = "Username đã tồn tại!";
                        messageType = "error";
                    } else if (userDAO.addUser(username, password, fullname, email, phone, role)) {
                        message = "Thêm người dùng thành công!";
                    } else {
                        message = "Có lỗi xảy ra!";
                        messageType = "error";
                    }
                    break;
                    
                case "update":
                    int updateId = Integer.parseInt(request.getParameter("userId"));
                    String updateFullname = request.getParameter("fullname");
                    String updateEmail = request.getParameter("email");
                    String updatePhone = request.getParameter("phone");
                    String updateAddress = request.getParameter("address");
                    
                    if (userDAO.updateUser(updateId, updateFullname, updateEmail, updatePhone, updateAddress)) {
                        message = "Cập nhật thông tin thành công!";
                    } else {
                        message = "Có lỗi xảy ra!";
                        messageType = "error";
                    }
                    break;
                    
                case "updateRole":
                    int roleUserId = Integer.parseInt(request.getParameter("userId"));
                    String newRole = request.getParameter("role");
                    
                    if (userDAO.updateUserRole(roleUserId, newRole)) {
                        message = "Đã cập nhật quyền thành công!";
                    } else {
                        message = "Có lỗi xảy ra!";
                        messageType = "error";
                    }
                    break;
                    
                case "toggleStatus":
                    int statusUserId = Integer.parseInt(request.getParameter("userId"));
                    String newStatus = request.getParameter("status");
                    
                    if (userDAO.updateUserStatus(statusUserId, newStatus)) {
                        message = newStatus.equals("active") ? "Đã mở khóa tài khoản!" : "Đã khóa tài khoản!";
                    } else {
                        message = "Có lỗi xảy ra!";
                        messageType = "error";
                    }
                    break;
                    
                case "resetPassword":
                    int resetUserId = Integer.parseInt(request.getParameter("userId"));
                    String newPassword = request.getParameter("newPassword");
                    
                    if (userDAO.resetUserPassword(resetUserId, newPassword)) {
                        message = "Đã reset mật khẩu thành công!";
                    } else {
                        message = "Có lỗi xảy ra!";
                        messageType = "error";
                    }
                    break;
                    
                case "delete":
                    int deleteId = Integer.parseInt(request.getParameter("userId"));
                    
                    if (userDAO.deleteUser(deleteId)) {
                        message = "Đã xóa người dùng thành công!";
                    } else {
                        message = "Có lỗi xảy ra khi xóa!";
                        messageType = "error";
                    }
                    break;
                    
                default:
                    message = "Hành động không hợp lệ!";
                    messageType = "error";
            }
        } catch (Exception e) {
            message = "Có lỗi xảy ra: " + e.getMessage();
            messageType = "error";
            e.printStackTrace();
        }

        request.getSession().setAttribute("message", message);
        request.getSession().setAttribute("messageType", messageType);
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
