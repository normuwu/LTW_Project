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
import DAO.UserDAO;
import Model.Appointment;
import Model.User;
import Util.EmailUtil;

@WebServlet("/pages/admin/appointments")
public class AppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private AppointmentDAO appointmentDAO = new AppointmentDAO();
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy danh sách tất cả lịch hẹn
        List<Appointment> appointments = appointmentDAO.getAllAppointments();
        request.setAttribute("appointments", appointments);
        
        // Thống kê
        request.setAttribute("totalPending", appointmentDAO.countByStatus("Pending"));
        request.setAttribute("totalConfirmed", appointmentDAO.countByStatus("Confirmed"));
        request.setAttribute("totalCompleted", appointmentDAO.countByStatus("Completed"));
        request.setAttribute("totalRejected", appointmentDAO.countByStatus("Rejected"));
        
        request.getRequestDispatcher("/pages/admin/appointments.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // Kiểm tra quyền admin
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        String idsStr = request.getParameter("ids");
        
        String message = "";
        String messageType = "success";
        
        // Handle bulk actions
        if (action != null && action.startsWith("bulk_")) {
            String bulkAction = action.replace("bulk_", "");
            if (idsStr != null && !idsStr.isEmpty()) {
                String[] ids = idsStr.split(",");
                int successCount = 0;
                for (String id : ids) {
                    int aptId = Integer.parseInt(id.trim());
                    boolean success = false;
                    switch (bulkAction) {
                        case "approve":
                            success = "SUCCESS".equals(appointmentDAO.approveAppointment(aptId));
                            break;
                        case "reject":
                            success = appointmentDAO.rejectAppointment(aptId);
                            break;
                        case "delete":
                            success = appointmentDAO.deleteAppointment(aptId);
                            break;
                    }
                    if (success) successCount++;
                }
                message = "Đã xử lý " + successCount + "/" + ids.length + " lịch hẹn";
            }
            session.setAttribute("message", message);
            session.setAttribute("messageType", messageType);
            response.sendRedirect(request.getContextPath() + "/pages/admin/appointments");
            return;
        }
        
        // Handle delete all cancelled
        if ("delete_all_cancelled".equals(action)) {
            int deleted = appointmentDAO.deleteAllCancelled();
            message = "Đã xóa " + deleted + " lịch hẹn đã hủy";
            session.setAttribute("message", message);
            session.setAttribute("messageType", messageType);
            response.sendRedirect(request.getContextPath() + "/pages/admin/appointments");
            return;
        }
        
        // Handle delete all completed
        if ("delete_all_completed".equals(action)) {
            int deleted = appointmentDAO.deleteAllCompleted();
            message = "Đã xóa " + deleted + " lịch hẹn đã hoàn thành";
            session.setAttribute("message", message);
            session.setAttribute("messageType", messageType);
            response.sendRedirect(request.getContextPath() + "/pages/admin/appointments");
            return;
        }
        
        // Handle single actions
        if (action == null || idStr == null) {
            response.sendRedirect(request.getContextPath() + "/pages/admin/appointments");
            return;
        }
        
        int appointmentId = Integer.parseInt(idStr);
        
        switch (action) {
            case "approve":
                String result = appointmentDAO.approveAppointment(appointmentId);
                if ("SUCCESS".equals(result)) {
                    message = "Đã duyệt lịch hẹn #" + appointmentId + " thành công!";
                    // Gửi email thông báo duyệt lịch
                    sendApprovalEmail(appointmentId);
                } else if ("FULL".equals(result)) {
                    message = "Không thể duyệt! Bác sĩ đã full lịch trong ngày này.";
                    messageType = "error";
                } else {
                    message = result;
                    messageType = "error";
                }
                break;
                
            case "reject":
                if (appointmentDAO.rejectAppointment(appointmentId)) {
                    message = "Đã từ chối lịch hẹn #" + appointmentId;
                    // Gửi email thông báo từ chối
                    sendRejectionEmail(appointmentId, "Lịch hẹn không phù hợp với lịch làm việc");
                } else {
                    message = "Có lỗi xảy ra!";
                    messageType = "error";
                }
                break;
                
            case "complete":
                if (appointmentDAO.completeAppointment(appointmentId)) {
                    message = "Đã hoàn thành lịch hẹn #" + appointmentId;
                } else {
                    message = "Có lỗi xảy ra!";
                    messageType = "error";
                }
                break;
                
            case "cancel":
                String cancelReason = request.getParameter("reason");
                if (appointmentDAO.cancelAppointment(appointmentId)) {
                    message = "Đã hủy lịch hẹn #" + appointmentId;
                    // Gửi email thông báo hủy
                    sendCancellationEmail(appointmentId, cancelReason);
                } else {
                    message = "Có lỗi xảy ra!";
                    messageType = "error";
                }
                break;
                
            case "delete":
                if (appointmentDAO.deleteAppointment(appointmentId)) {
                    message = "Đã xóa lịch hẹn #" + appointmentId;
                } else {
                    message = "Có lỗi xảy ra!";
                    messageType = "error";
                }
                break;
        }
        
        session.setAttribute("message", message);
        session.setAttribute("messageType", messageType);
        response.sendRedirect(request.getContextPath() + "/pages/admin/appointments");
    }
    
    // Helper method: Gửi email khi duyệt lịch hẹn
    private void sendApprovalEmail(int appointmentId) {
        try {
            Appointment apt = appointmentDAO.getAppointmentById(appointmentId);
            if (apt == null || apt.getUserId() <= 0) return;
            
            String email = userDAO.getEmailByUserId(apt.getUserId());
            if (email == null || email.isEmpty()) return;
            
            String dateStr = apt.getBookingDate() != null ? apt.getBookingDate().toString() : "Chưa xác định";
            
            // Sử dụng method mới trong EmailUtil
            EmailUtil.sendAppointmentApproved(
                email,
                apt.getCustomerName(),
                apt.getPetName(),
                apt.getServiceName(),
                dateStr,
                apt.getDoctorName()
            );
            System.out.println("Sent approval email to: " + email);
        } catch (Exception e) {
            System.err.println("Failed to send approval email for appointment #" + appointmentId);
            e.printStackTrace();
        }
    }
    
    // Helper method: Gửi email khi từ chối lịch hẹn
    private void sendRejectionEmail(int appointmentId, String reason) {
        try {
            Appointment apt = appointmentDAO.getAppointmentById(appointmentId);
            if (apt == null || apt.getUserId() <= 0) return;
            
            String email = userDAO.getEmailByUserId(apt.getUserId());
            if (email == null || email.isEmpty()) return;
            
            String dateStr = apt.getBookingDate() != null ? apt.getBookingDate().toString() : "Chưa xác định";
            
            // Sử dụng method mới trong EmailUtil
            EmailUtil.sendAppointmentRejected(
                email,
                apt.getCustomerName(),
                apt.getPetName(),
                apt.getServiceName(),
                dateStr,
                reason != null ? reason : "Lịch không phù hợp với lịch làm việc"
            );
            System.out.println("Sent rejection email to: " + email);
        } catch (Exception e) {
            System.err.println("Failed to send rejection email for appointment #" + appointmentId);
            e.printStackTrace();
        }
    }
    
    // Helper method: Gửi email khi hủy lịch hẹn
    private void sendCancellationEmail(int appointmentId, String reason) {
        try {
            Appointment apt = appointmentDAO.getAppointmentById(appointmentId);
            if (apt == null || apt.getUserId() <= 0) return;
            
            String email = userDAO.getEmailByUserId(apt.getUserId());
            if (email == null || email.isEmpty()) return;
            
            String dateStr = apt.getBookingDate() != null ? apt.getBookingDate().toString() : "Chưa xác định";
            
            EmailUtil.sendCancellationNotification(
                email, apt.getCustomerName(), apt.getPetName(),
                apt.getServiceName(), dateStr, reason != null ? reason : "Theo yêu cầu"
            );
            System.out.println("Sent cancellation email to: " + email);
        } catch (Exception e) {
            System.err.println("Failed to send cancellation email for appointment #" + appointmentId);
            e.printStackTrace();
        }
    }
}

