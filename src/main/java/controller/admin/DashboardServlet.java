package controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.AppointmentDAO;
import DAO.UserDAO;
import DAO.PetDAO;
import DAO.ProductDAO;
import DAO.ServiceDAO;
import DAO.DoctorDAO;
import Model.Appointment;

@WebServlet("/pages/admin/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        UserDAO userDAO = new UserDAO();
        PetDAO petDAO = new PetDAO();
        ProductDAO productDAO = new ProductDAO();
        ServiceDAO serviceDAO = new ServiceDAO();
        DoctorDAO doctorDAO = new DoctorDAO();
        
        // Thống kê chính
        request.setAttribute("totalUsers", userDAO.countUsers());
        request.setAttribute("totalPets", petDAO.countAll());
        request.setAttribute("totalProducts", productDAO.getTotalProducts());
        request.setAttribute("totalServices", serviceDAO.countAll());
        request.setAttribute("totalDoctors", doctorDAO.countAll());
        
        // Thống kê lịch hẹn
        request.setAttribute("todayAppointments", appointmentDAO.countTodayAppointments());
        request.setAttribute("pendingAppointments", appointmentDAO.countByStatus("Pending"));
        request.setAttribute("confirmedAppointments", appointmentDAO.countByStatus("Confirmed"));
        request.setAttribute("completedAppointments", appointmentDAO.countByStatus("Completed"));
        
        // Lịch hẹn hôm nay
        List<Appointment> todayList = appointmentDAO.getTodayAppointments();
        request.setAttribute("todayAppointmentsList", todayList);
        
        // Lịch hẹn gần đây (5 lịch mới nhất)
        List<Appointment> recentAppointments = appointmentDAO.getRecentAppointments(5);
        request.setAttribute("recentAppointments", recentAppointments);
        
        request.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}

