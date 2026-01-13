package controller.booking;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import DAO.AppointmentDAO;
import Model.Appointment;
import Model.User;

@WebServlet("/schedule")
public class ScheduleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        AppointmentDAO dao = new AppointmentDAO();
        List<Appointment> list;
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Chỉ user mới được truy cập, admin không được
        if ("admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/pages/admin/dashboard");
            return;
        }
        
        // Lấy lịch hẹn theo user_id HOẶC theo phone của user
        list = dao.getAppointmentsByUserId(user.getId());

        request.setAttribute("mySchedule", list);
        request.setAttribute("currentUser", user);
        request.getRequestDispatcher("/pages/main/schedule.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Chỉ user mới được truy cập, admin không được
        if ("admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/pages/admin/dashboard");
            return;
        }
        
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        AppointmentDAO dao = new AppointmentDAO();
        
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/schedule");
            return;
        }
        
        int appointmentId = Integer.parseInt(idStr);
        Appointment apt = dao.getAppointmentById(appointmentId);
        
        // Kiểm tra lịch hẹn tồn tại
        if (apt == null) {
            session.setAttribute("error", "Không tìm thấy lịch hẹn!");
            response.sendRedirect(request.getContextPath() + "/schedule");
            return;
        }
        
        if ("cancel".equals(action)) {
            if ("Pending".equals(apt.getStatus())) {
                if (dao.cancelAppointment(appointmentId)) {
                    session.setAttribute("success", "Đã hủy lịch hẹn thành công!");
                } else {
                    session.setAttribute("error", "Có lỗi xảy ra khi hủy lịch hẹn!");
                }
            } else {
                session.setAttribute("error", "Chỉ có thể hủy lịch hẹn đang chờ xác nhận!");
            }
        } else if ("delete".equals(action)) {
            if ("Cancelled".equals(apt.getStatus()) || "Rejected".equals(apt.getStatus())) {
                if (dao.deleteAppointment(appointmentId)) {
                    session.setAttribute("success", "Đã xóa lịch hẹn thành công!");
                } else {
                    session.setAttribute("error", "Có lỗi xảy ra khi xóa lịch hẹn!");
                }
            } else {
                session.setAttribute("error", "Chỉ có thể xóa lịch hẹn đã hủy hoặc bị từ chối!");
            }
        } else if ("update".equals(action)) {
            if ("Pending".equals(apt.getStatus())) {
                // Lấy dữ liệu từ form
                String customerName = request.getParameter("customerName");
                String phone = request.getParameter("phone");
                String petName = request.getParameter("petName");
                String petType = request.getParameter("petType");
                String bookingDate = request.getParameter("bookingDate");
                int serviceId = Integer.parseInt(request.getParameter("serviceId"));
                String note = request.getParameter("note");
                
                // Cập nhật lịch hẹn
                if (dao.updateAppointment(appointmentId, customerName, phone, petName, petType, serviceId, bookingDate, note)) {
                    session.setAttribute("success", "Đã cập nhật lịch hẹn thành công!");
                } else {
                    session.setAttribute("error", "Có lỗi xảy ra khi cập nhật lịch hẹn!");
                }
            } else {
                session.setAttribute("error", "Chỉ có thể sửa lịch hẹn đang chờ xác nhận!");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/schedule");
    }
}

