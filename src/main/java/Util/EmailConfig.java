package Util;

/**
 * Cấu hình SMTP để gửi email
 * Hỗ trợ Gmail, Outlook, và các SMTP server khác
 */
public class EmailConfig {
    
    // ============ CẤU HÌNH EMAIL CỦA BẠN Ở ĐÂY ============
    
    // Email gửi đi (sender)
    private static final String SMTP_EMAIL = "tthhaannhh06032005@gmail.com";
    
    // Mật khẩu ứng dụng (App Password) - KHÔNG phải mật khẩu Gmail thường
    // Hướng dẫn tạo App Password: https://support.google.com/accounts/answer/185833
    private static final String SMTP_PASSWORD = "hjralarxujzgtlpp";
    
    // Tên hiển thị khi gửi email
    private static final String SENDER_NAME = "PetVaccine System";
    
    // ============ CẤU HÌNH SMTP SERVER ============
    
    // Gmail SMTP
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final boolean SMTP_AUTH = true;
    private static final boolean SMTP_STARTTLS = true;
    
    // ============ GETTERS ============
    
    public static String getSmtpEmail() {
        return SMTP_EMAIL;
    }
    
    public static String getSmtpPassword() {
        return SMTP_PASSWORD;
    }
    
    public static String getSenderName() {
        return SENDER_NAME;
    }
    
    public static String getSmtpHost() {
        return SMTP_HOST;
    }
    
    public static String getSmtpPort() {
        return SMTP_PORT;
    }
    
    public static boolean isSmtpAuth() {
        return SMTP_AUTH;
    }
    
    public static boolean isSmtpStarttls() {
        return SMTP_STARTTLS;
    }
}
