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
import DAO.DoctorDAO;
import DAO.ServiceDAO;
import Model.Doctors;
import Model.User;
import Util.EmailUtil;
import Util.FormHelper;
import Util.ValidationUtil;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user != null) {
            request.setAttribute("currentUser", user);
        }
        
        // Nhận service ID từ URL parameter (từ các trang dịch vụ)
        String serviceParam = request.getParameter("service");
        if (serviceParam != null && !serviceParam.isEmpty()) {
            request.setAttribute("selectedService", serviceParam);
        }
        
        // Nhận thông tin thú cưng từ URL (từ trang "Thú cưng của tôi")
        String petId = request.getParameter("petId");
        String petName = request.getParameter("petName");
        String petType = request.getParameter("petType");
        if (petId != null && !petId.isEmpty()) {
            request.setAttribute("selectedPetId", petId);
        }
        if (petName != null && !petName.isEmpty()) {
            request.setAttribute("selectedPetName", petName);
        }
        if (petType != null && !petType.isEmpty()) {
            request.setAttribute("selectedPetType", petType);
        }
        
        DoctorDAO doctorDAO = new DoctorDAO();
        List<Doctors> listDoctors = doctorDAO.getAllDoctors();
        request.setAttribute("listDoctors", listDoctors);
        
        request.getRequestDispatcher("/pages/main/booking.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        FormHelper form = new FormHelper(request);
        
        // Lấy input
        String customerName = form.get("customerName");
        String phone = form.get("phone");
        String petName = form.get("petName");
        String petType = form.get("petType");
        String customPetType = form.get("customPetType");
        String serviceIdStr = form.get("serviceId");
        String doctorIdStr = form.get("doctorId");
        String dateStr = form.get("bookingDate");
        String note = form.get("note");
        
        // Load lại danh sách bác sĩ cho form
        DoctorDAO doctorDAO = new DoctorDAO();
        request.setAttribute("listDoctors", doctorDAO.getAllDoctors());
        if (user != null) {
            request.setAttribute("currentUser", user);
        }
        
        // === VALIDATION ===
        boolean valid = true;
        
        // Tên khách hàng
        if (!form.validateRequired("customerName", "Họ tên chủ nuôi")) {
            valid = false;
        } else if (!form.validateLength("customerName", "Họ tên", 2, 100)) {
            valid = false;
        }
        
        // Số điện thoại
        if (!form.validateRequired("phone", "Số điện thoại")) {
            valid = false;
        } else if (!form.validatePhone("phone")) {
            valid = false;
        }
        
        // Loại thú cưng
        if (!form.validateRequired("petType", "Loại thú cưng")) {
            valid = false;
        } else if ("Khác".equals(petType)) {
            if (ValidationUtil.isEmpty(customPetType)) {
                form.addError("customPetType", "Vui lòng nhập loại thú cưng của bạn");
                valid = false;
            } else {
                petType = customPetType;
            }
        }
        
        // Ngày đặt - validate không quá khứ và không quá xa (60 ngày)
        if (!form.validateBookingDate("bookingDate")) {
            valid = false;
        }
        
        // Service ID
        if (!ValidationUtil.isValidInteger(serviceIdStr)) {
            form.addError("serviceId", "Vui lòng chọn dịch vụ");
            valid = false;
        }
        
        // Nếu có lỗi, quay lại form
        if (!valid) {
            form.applyToRequest();
            request.getRequestDispatcher("/pages/main/booking.jsp").forward(request, response);
            return;
        }
        
        // === BUSINESS LOGIC ===
        try {
            int serviceId = ValidationUtil.parseIntOrDefault(serviceIdStr, 1);
            int doctorId = ValidationUtil.parseIntOrDefault(doctorIdStr, 0);
            int userId = (user != null) ? user.getId() : 0;
            
            // Normalize phone trước khi lưu
            phone = ValidationUtil.normalizePhone(phone);

            AppointmentDAO dao = new AppointmentDAO();
            dao.insertAppointment(userId, customerName, phone, petName, petType, serviceId, doctorId, dateStr, note);

            // Gửi email xác nhận đặt lịch (nếu user đã đăng nhập và có email)
            if (user != null && user.getEmail() != null && !user.getEmail().isEmpty()) {
                // Lấy tên dịch vụ
                ServiceDAO serviceDAO = new ServiceDAO();
                String serviceName = serviceDAO.getServiceNameById(serviceId);
                if (serviceName == null) serviceName = "Dịch vụ tiêm vaccine";
                
                EmailUtil.sendBookingConfirmation(
                    user.getEmail(),
                    customerName,
                    petName != null ? petName : "Thú cưng",
                    serviceName,
                    dateStr,
                    "Sẽ được thông báo sau khi duyệt"
                );
            }

            // Hiển thị thông báo thành công trên trang booking thay vì redirect
            request.setAttribute("success", "Đặt lịch hẹn thành công! Kiểm tra email để xem chi tiết.");
            request.setAttribute("listDoctors", doctorDAO.getAllDoctors());
            request.getRequestDispatcher("/pages/main/booking.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            form.addGeneralError("Có lỗi xảy ra khi đặt lịch. Vui lòng thử lại!");
            form.applyToRequest();
            request.getRequestDispatcher("/pages/main/booking.jsp").forward(request, response);
        }
    }
}

