import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.AppointmentDAO;
import Model.Appointment;

@WebServlet("/schedule")
public class ScheduleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Gọi DAO lấy dữ liệu thật từ Database
        AppointmentDAO dao = new AppointmentDAO();
        List<Appointment> list = dao.getAllAppointments();

        // 2. Đẩy dữ liệu sang JSP
        request.setAttribute("mySchedule", list);

        // 3. Chuyển trang
        request.getRequestDispatcher("/mainPages/schedule.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}