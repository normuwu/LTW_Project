package controller.admin;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.ReportDAO;
import Util.EmailUtil;

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

        try {
            if ("sendReminder".equals(action)) {
                // Gửi email nhắc nhở cho 1 người
                String email = request.getParameter("email");
                String customerName = request.getParameter("customerName");
                String petName = request.getParameter("petName");
                String vaccineName = request.getParameter("vaccineName");
                String dueDate = request.getParameter("dueDate");
                
                boolean sent = sendVaccineReminderEmail(email, customerName, petName, vaccineName, dueDate);
                
                if (sent) {
                    message = "Đã gửi nhắc nhở đến " + email + " thành công!";
                } else {
                    message = "Không thể gửi email đến " + email + ". Vui lòng kiểm tra cấu hình email.";
                    messageType = "error";
                }
                
            } else if ("sendAll".equals(action)) {
                // Gửi tất cả nhắc nhở
                int daysParam = Integer.parseInt(request.getParameter("days"));
                List<Map<String, Object>> reminders = reportDAO.getUpcomingReminders(daysParam);
                
                int successCount = 0;
                int failCount = 0;
                
                for (Map<String, Object> reminder : reminders) {
                    String email = (String) reminder.get("email");
                    String customerName = (String) reminder.get("fullname");
                    String petName = (String) reminder.get("petName");
                    String vaccineName = (String) reminder.get("vaccineName");
                    Date nextDueDate = (Date) reminder.get("nextDueDate");
                    String dueDate = new SimpleDateFormat("dd/MM/yyyy").format(nextDueDate);
                    
                    boolean sent = sendVaccineReminderEmail(email, customerName, petName, vaccineName, dueDate);
                    if (sent) {
                        successCount++;
                    } else {
                        failCount++;
                    }
                }
                
                if (failCount == 0) {
                    message = "Đã gửi thành công " + successCount + " thông báo nhắc nhở!";
                } else {
                    message = "Đã gửi " + successCount + " thành công, " + failCount + " thất bại.";
                    messageType = failCount > successCount ? "error" : "warning";
                }
            }
        } catch (Exception e) {
            message = "Có lỗi xảy ra: " + e.getMessage();
            messageType = "error";
            e.printStackTrace();
        }

        request.getSession().setAttribute("message", message);
        request.getSession().setAttribute("messageType", messageType);
        response.sendRedirect(request.getContextPath() + "/admin/notifications");
    }
    
    /**
     * Gửi email nhắc nhở tiêm vaccine
     */
    private boolean sendVaccineReminderEmail(String toEmail, String customerName, 
            String petName, String vaccineName, String dueDate) {
        
        String subject = "🐾 Nhắc nhở lịch tiêm vaccine cho " + petName + " - Animal Doctors";
        String htmlContent = buildVaccineReminderEmail(customerName, petName, vaccineName, dueDate);
        
        return EmailUtil.sendEmail(toEmail, subject, htmlContent);
    }
    
    /**
     * Tạo nội dung email nhắc nhở tiêm vaccine
     */
    private String buildVaccineReminderEmail(String customerName, String petName, 
            String vaccineName, String dueDate) {
        
        return "<!DOCTYPE html>" +
            "<html><head><meta charset='UTF-8'></head>" +
            "<body style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; background: #f5f5f5; padding: 20px;'>" +
            "<div style='background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.1);'>" +
            
            // Header
            "  <div style='background: linear-gradient(135deg, #0d9488 0%, #14b8a6 100%); padding: 30px; text-align: center;'>" +
            "    <h1 style='color: white; margin: 0; font-size: 28px;'>🐾 Animal Doctors</h1>" +
            "    <p style='color: rgba(255,255,255,0.9); margin: 10px 0 0 0;'>Chăm sóc sức khỏe thú cưng</p>" +
            "  </div>" +
            
            // Content
            "  <div style='padding: 30px;'>" +
            "    <h2 style='color: #0d9488; margin-top: 0;'>⏰ Nhắc nhở lịch tiêm vaccine</h2>" +
            "    <p style='color: #333; font-size: 16px;'>Xin chào <strong>" + customerName + "</strong>,</p>" +
            "    <p style='color: #555; line-height: 1.6;'>Đây là email nhắc nhở về lịch tiêm vaccine sắp tới cho thú cưng của bạn:</p>" +
            
            // Info Box
            "    <div style='background: linear-gradient(135deg, #f0fdfa 0%, #ccfbf1 100%); padding: 24px; border-radius: 12px; margin: 24px 0; border-left: 4px solid #0d9488;'>" +
            "      <table style='width: 100%; border-collapse: collapse;'>" +
            "        <tr><td style='padding: 8px 0; color: #666;'>🐕 Thú cưng:</td><td style='padding: 8px 0; font-weight: bold; color: #333;'>" + petName + "</td></tr>" +
            "        <tr><td style='padding: 8px 0; color: #666;'>💉 Vaccine:</td><td style='padding: 8px 0; font-weight: bold; color: #333;'>" + vaccineName + "</td></tr>" +
            "        <tr><td style='padding: 8px 0; color: #666;'>📅 Ngày tiêm:</td><td style='padding: 8px 0; font-weight: bold; color: #0d9488; font-size: 18px;'>" + dueDate + "</td></tr>" +
            "      </table>" +
            "    </div>" +
            
            // CTA Button
            "    <div style='text-align: center; margin: 30px 0;'>" +
            "      <a href='#' style='display: inline-block; background: linear-gradient(135deg, #0d9488 0%, #14b8a6 100%); color: white; padding: 14px 32px; text-decoration: none; border-radius: 8px; font-weight: bold; font-size: 16px;'>Đặt lịch ngay</a>" +
            "    </div>" +
            
            "    <p style='color: #555; line-height: 1.6;'>Việc tiêm vaccine đúng lịch rất quan trọng để bảo vệ sức khỏe cho thú cưng của bạn. Vui lòng liên hệ với chúng tôi để đặt lịch hẹn.</p>" +
            
            // Contact Info
            "    <div style='background: #f8fafc; padding: 16px; border-radius: 8px; margin-top: 24px;'>" +
            "      <p style='margin: 0; color: #666; font-size: 14px;'><strong>📞 Hotline:</strong> 1900-xxxx</p>" +
            "      <p style='margin: 8px 0 0 0; color: #666; font-size: 14px;'><strong>📍 Địa chỉ:</strong> 123 Đường ABC, Quận XYZ, TP.HCM</p>" +
            "    </div>" +
            "  </div>" +
            
            // Footer
            "  <div style='background: #f1f5f9; padding: 20px; text-align: center;'>" +
            "    <p style='margin: 0; color: #94a3b8; font-size: 13px;'>Email này được gửi tự động từ hệ thống Animal Doctors.</p>" +
            "    <p style='margin: 8px 0 0 0; color: #94a3b8; font-size: 13px;'>© 2024 Animal Doctors. All rights reserved.</p>" +
            "  </div>" +
            "</div>" +
            "</body></html>";
    }
}
