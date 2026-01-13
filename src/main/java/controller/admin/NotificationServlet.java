package controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.ReportDAO;

@WebServlet("/admin/notifications")
public class NotificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String daysParam = request.getParameter("days");
        int days = daysParam != null ? Integer.parseInt(daysParam) : 7;
        
        // Lấy danh sách cần nhắc nhở
        List<Map<String, Object>> reminders = reportDAO.getUpcomingReminders(days);
        request.setAttribute("reminders", reminders);
        request.setAttribute("totalReminders", reminders.size());
        request.setAttribute("selectedDays", days);
        
        request.getRequestDispatcher("/pages/admin/notifications.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String message = "";
        String messageType = "success";

        if ("sendReminder".equals(action)) {
            // Gửi email nhắc nhở (giả lập)
            String email = request.getParameter("email");
            String petName = request.getParameter("petName");
            String vaccineName = request.getParameter("vaccineName");
            String dueDate = request.getParameter("dueDate");
            
            // TODO: Implement actual email sending
            message = "Đã gửi nhắc nhở đến " + email + " thành công!";
            
        } else if ("sendAll".equals(action)) {
            // Gửi tất cả nhắc nhở
            int daysParam = Integer.parseInt(request.getParameter("days"));
            List<Map<String, Object>> reminders = reportDAO.getUpcomingReminders(daysParam);
            
            // TODO: Implement batch email sending
            message = "Đã gửi " + reminders.size() + " thông báo nhắc nhở!";
        }

        request.getSession().setAttribute("message", message);
        request.getSession().setAttribute("messageType", messageType);
        response.sendRedirect(request.getContextPath() + "/admin/notifications");
    }
}
