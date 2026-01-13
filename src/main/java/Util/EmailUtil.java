package Util;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Utility class để gửi email
 * Hỗ trợ gửi email đồng bộ và bất đồng bộ
 */
public class EmailUtil {
    
    // Thread pool để gửi email bất đồng bộ
    private static final ExecutorService emailExecutor = Executors.newFixedThreadPool(3);
    
    /**
     * Gửi email đồng bộ (chờ đến khi gửi xong)
     */
    public static boolean sendEmail(String toEmail, String subject, String htmlContent) {
        try {
            // Cấu hình SMTP properties
            Properties props = new Properties();
            props.put("mail.smtp.host", EmailConfig.getSmtpHost());
            props.put("mail.smtp.port", EmailConfig.getSmtpPort());
            props.put("mail.smtp.auth", String.valueOf(EmailConfig.isSmtpAuth()));
            props.put("mail.smtp.starttls.enable", String.valueOf(EmailConfig.isSmtpStarttls()));
            
            // Tạo session với authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                        EmailConfig.getSmtpEmail(), 
                        EmailConfig.getSmtpPassword()
                    );
                }
            });
            
            // Tạo message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EmailConfig.getSmtpEmail(), EmailConfig.getSenderName(), "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            
            // Gửi email
            Transport.send(message);
            System.out.println("Email sent successfully to: " + toEmail);
            return true;
            
        } catch (Exception e) {
            System.err.println("Failed to send email to: " + toEmail);
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Gửi email bất đồng bộ (không chờ, chạy background)
     * Sử dụng khi không cần biết kết quả ngay
     */
    public static void sendEmailAsync(String toEmail, String subject, String htmlContent) {
        emailExecutor.submit(() -> sendEmail(toEmail, subject, htmlContent));
    }

    
    // ============ EMAIL TEMPLATES CHO PET VACCINE ============
    
    /**
     * Gửi email xác nhận đặt lịch hẹn
     */
    public static void sendBookingConfirmation(String toEmail, String customerName, 
            String petName, String serviceName, String appointmentDate, String appointmentTime) {
        
        String subject = "Xác nhận đặt lịch hẹn - PetVaccine";
        String htmlContent = buildBookingConfirmationEmail(customerName, petName, 
                serviceName, appointmentDate, appointmentTime);
        
        sendEmailAsync(toEmail, subject, htmlContent);
    }
    
    /**
     * Gửi email nhắc nhở lịch hẹn
     */
    public static void sendAppointmentReminder(String toEmail, String customerName,
            String petName, String serviceName, String appointmentDate, String appointmentTime) {
        
        String subject = "Nhắc nhở lịch hẹn ngày mai - PetVaccine";
        String htmlContent = buildReminderEmail(customerName, petName, 
                serviceName, appointmentDate, appointmentTime);
        
        sendEmailAsync(toEmail, subject, htmlContent);
    }
    
    /**
     * Gửi email thông báo hủy lịch hẹn
     */
    public static void sendCancellationNotification(String toEmail, String customerName,
            String petName, String serviceName, String appointmentDate, String reason) {
        
        String subject = "Thông báo hủy lịch hẹn - PetVaccine";
        String htmlContent = buildCancellationEmail(customerName, petName, 
                serviceName, appointmentDate, reason);
        
        sendEmailAsync(toEmail, subject, htmlContent);
    }
    
    // ============ HTML EMAIL TEMPLATES ============
    
    private static String buildBookingConfirmationEmail(String customerName, String petName,
            String serviceName, String appointmentDate, String appointmentTime) {
        
        return "<!DOCTYPE html>" +
            "<html><head><meta charset='UTF-8'></head>" +
            "<body style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>" +
            "<div style='background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; text-align: center;'>" +
            "  <h1 style='color: white; margin: 0;'>🐾 PetVaccine</h1>" +
            "</div>" +
            "<div style='padding: 30px; background: #f9f9f9;'>" +
            "  <h2 style='color: #333;'>Xác nhận đặt lịch thành công!</h2>" +
            "  <p>Xin chào <strong>" + customerName + "</strong>,</p>" +
            "  <p>Cảm ơn bạn đã đặt lịch hẹn tại PetVaccine. Dưới đây là thông tin chi tiết:</p>" +
            "  <div style='background: white; padding: 20px; border-radius: 8px; margin: 20px 0;'>" +
            "    <p><strong>🐕 Thú cưng:</strong> " + petName + "</p>" +
            "    <p><strong>💉 Dịch vụ:</strong> " + serviceName + "</p>" +
            "    <p><strong>📅 Ngày hẹn:</strong> " + appointmentDate + "</p>" +
            "    <p><strong>⏰ Giờ hẹn:</strong> " + appointmentTime + "</p>" +
            "  </div>" +
            "  <p>Vui lòng đến đúng giờ. Nếu cần thay đổi, hãy liên hệ với chúng tôi.</p>" +
            "  <p style='color: #666;'>Trân trọng,<br>Đội ngũ PetVaccine</p>" +
            "</div>" +
            "</body></html>";
    }
    
    private static String buildReminderEmail(String customerName, String petName,
            String serviceName, String appointmentDate, String appointmentTime) {
        
        return "<!DOCTYPE html>" +
            "<html><head><meta charset='UTF-8'></head>" +
            "<body style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>" +
            "<div style='background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); padding: 30px; text-align: center;'>" +
            "  <h1 style='color: white; margin: 0;'>⏰ Nhắc nhở lịch hẹn</h1>" +
            "</div>" +
            "<div style='padding: 30px; background: #f9f9f9;'>" +
            "  <h2 style='color: #333;'>Đừng quên lịch hẹn ngày mai!</h2>" +
            "  <p>Xin chào <strong>" + customerName + "</strong>,</p>" +
            "  <p>Đây là email nhắc nhở về lịch hẹn của bạn vào ngày mai:</p>" +
            "  <div style='background: white; padding: 20px; border-radius: 8px; margin: 20px 0;'>" +
            "    <p><strong>🐕 Thú cưng:</strong> " + petName + "</p>" +
            "    <p><strong>💉 Dịch vụ:</strong> " + serviceName + "</p>" +
            "    <p><strong>📅 Ngày hẹn:</strong> " + appointmentDate + "</p>" +
            "    <p><strong>⏰ Giờ hẹn:</strong> " + appointmentTime + "</p>" +
            "  </div>" +
            "  <p>Vui lòng đến đúng giờ để được phục vụ tốt nhất.</p>" +
            "  <p style='color: #666;'>Trân trọng,<br>Đội ngũ PetVaccine</p>" +
            "</div>" +
            "</body></html>";
    }
    
    private static String buildCancellationEmail(String customerName, String petName,
            String serviceName, String appointmentDate, String reason) {
        
        return "<!DOCTYPE html>" +
            "<html><head><meta charset='UTF-8'></head>" +
            "<body style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>" +
            "<div style='background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 30px; text-align: center;'>" +
            "  <h1 style='color: white; margin: 0;'>🐾 PetVaccine</h1>" +
            "</div>" +
            "<div style='padding: 30px; background: #f9f9f9;'>" +
            "  <h2 style='color: #e74c3c;'>Thông báo hủy lịch hẹn</h2>" +
            "  <p>Xin chào <strong>" + customerName + "</strong>,</p>" +
            "  <p>Lịch hẹn sau đây đã được hủy:</p>" +
            "  <div style='background: white; padding: 20px; border-radius: 8px; margin: 20px 0;'>" +
            "    <p><strong>🐕 Thú cưng:</strong> " + petName + "</p>" +
            "    <p><strong>💉 Dịch vụ:</strong> " + serviceName + "</p>" +
            "    <p><strong>📅 Ngày hẹn:</strong> " + appointmentDate + "</p>" +
            "    <p><strong>📝 Lý do:</strong> " + (reason != null ? reason : "Không có") + "</p>" +
            "  </div>" +
            "  <p>Nếu bạn muốn đặt lịch mới, vui lòng truy cập website của chúng tôi.</p>" +
            "  <p style='color: #666;'>Trân trọng,<br>Đội ngũ PetVaccine</p>" +
            "</div>" +
            "</body></html>";
    }
}
