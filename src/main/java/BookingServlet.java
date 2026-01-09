import java.io.IOException;
import java.util.List; // Cần import List

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.AppointmentDAO;
import DAO.DoctorDAO; // Import DAO Bác sĩ
import Model.Doctors; // Import Model Bác sĩ

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // GET: Hiển thị trang form đặt lịch
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Gọi DAO lấy danh sách bác sĩ từ Database
        DoctorDAO doctorDAO = new DoctorDAO();
        List<Doctors> listDoctors = doctorDAO.getAllDoctors();
        
        // 2. Gắn danh sách vào request để trang JSP có thể dùng
        request.setAttribute("listDoctors", listDoctors);
        
        // 3. Chuyển hướng sang trang giao diện
        request.getRequestDispatcher("/mainPages/booking.jsp").forward(request, response);
    }

    // POST: Nhận dữ liệu form gửi về và lưu
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Xử lý tiếng Việt

        try {
            // 1. Lấy dữ liệu từ form
            String customerName = request.getParameter("customerName");
            String phone = request.getParameter("phone");
            String petName = request.getParameter("petName");
            String petType = request.getParameter("petType");
            String customPetType = request.getParameter("customPetType");
            
            // Nếu chọn "Khác" thì dùng giá trị từ ô nhập tùy chỉnh
            if ("Khác".equals(petType) && customPetType != null && !customPetType.trim().isEmpty()) {
                petType = customPetType.trim();
            }
            
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            int doctorId = Integer.parseInt(request.getParameter("doctorId")); 
            String dateStr = request.getParameter("bookingDate"); 
            String note = request.getParameter("note");

            // 2. Gọi DAO lưu vào Database
            AppointmentDAO dao = new AppointmentDAO();
            dao.insertAppointment(customerName, phone, petName, petType, serviceId, doctorId, dateStr, note);

            // 3. Lưu xong chuyển hướng sang trang Xem Lịch
            response.sendRedirect(request.getContextPath() + "/schedule");

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu lỗi thì quay lại trang đặt lịch kèm thông báo lỗi
            response.sendRedirect(request.getContextPath() + "/booking?error=1");
        }
    }
}