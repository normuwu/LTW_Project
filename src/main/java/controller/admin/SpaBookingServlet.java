package controller.admin;

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

@WebServlet("/admin/spa-bookings")
public class SpaBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int SPA_SERVICE_ID = 4;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        AppointmentDAO dao = new AppointmentDAO();
        
        // Lấy danh sách booking spa (service_id = 4)
        List<Appointment> spaBookings = dao.getAppointmentsByServiceId(SPA_SERVICE_ID);
        request.setAttribute("bookings", spaBookings);
        
        // Thống kê
        int totalPending = 0, totalConfirmed = 0, totalCompleted = 0, totalCancelled = 0;
        for (Appointment apt : spaBookings) {
            String status = apt.getStatus();
            if ("Pending".equals(status) || "Chờ xác nhận".equals(status)) totalPending++;
            else if ("Confirmed".equals(status) || "Đã xác nhận".equals(status)) totalConfirmed++;
            else if ("Completed".equals(status) || "Hoàn thành".equals(status)) totalCompleted++;
            else if ("Cancelled".equals(status) || "Đã hủy".equals(status)) totalCancelled++;
        }
        
        request.setAttribute("totalPending", totalPending);
        request.setAttribute("totalConfirmed", totalConfirmed);
        request.setAttribute("totalCompleted", totalCompleted);
        request.setAttribute("totalCancelled", totalCancelled);
        request.setAttribute("totalBookings", spaBookings.size());
        
        request.getRequestDispatcher("/pages/admin/spa-bookings.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        AppointmentDAO dao = new AppointmentDAO();
        
        try {
            if ("updateStatus".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");
                dao.updateAppointmentStatus(id, status);
                session.setAttribute("toastMessage", "Cập nhật trạng thái thành công!");
                session.setAttribute("toastType", "success");
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteAppointment(id);
                session.setAttribute("toastMessage", "Xóa lịch spa thành công!");
                session.setAttribute("toastType", "success");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("toastMessage", "Có lỗi xảy ra: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/spa-bookings");
    }
}
