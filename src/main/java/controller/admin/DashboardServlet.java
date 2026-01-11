package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.AppointmentDAO;
import DAO.UserDAO;

@WebServlet("/pages/admin/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy thống kê
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        UserDAO userDAO = new UserDAO();
        
        request.setAttribute("totalUsers", userDAO.countUsers());
        request.setAttribute("todayAppointments", appointmentDAO.countTodayAppointments());
        request.setAttribute("pendingAppointments", appointmentDAO.countByStatus("Pending"));
        request.setAttribute("confirmedAppointments", appointmentDAO.countByStatus("Confirmed"));
        
        request.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}

