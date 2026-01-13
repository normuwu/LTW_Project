package controller.admin;

import Context.DBContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/admin/fix-data")
public class FixDataServlet extends HttpServlet {
    
    // Vietnamese strings with proper encoding
    private static final String QUAN_TRI_VIEN = "Qu\u1EA3n tr\u1ECB vi\u00EAn";
    private static final String NGUYEN_VAN_THANH = "Nguy\u1EC5n V\u0103n Th\u00E0nh";
    private static final String TRAN_THI_BINH = "Tr\u1EA7n Th\u1ECB B\u00ECnh";
    private static final String LE_VAN_CUONG = "L\u00EA V\u0103n C\u01B0\u1EDDng";
    private static final String PHAM_THI_DUNG = "Ph\u1EA1m Th\u1ECB Dung";
    private static final String HOANG_VAN_EM = "Ho\u00E0ng V\u0103n Em";
    
    // Pet types
    private static final String CHO = "Ch\u00F3";
    private static final String MEO = "M\u00E8o";
    private static final String DUC = "\u0110\u1EF1c";
    private static final String CAI = "C\u00E1i";
    
    // Common phrases
    private static final String TAT_CA = "T\u1EA5t c\u1EA3";
    private static final String DUOI_5KG = "D\u01B0\u1EDBi 5kg";
    private static final String TREN_5KG = "Tr\u00EAn 5kg";
    private static final String PHONG_TIEU_CHUAN = "Ph\u00F2ng Ti\u00EAu chu\u1EA9n - 150.000\u0111/ng\u00E0y";
    private static final String PHONG_VIP = "Ph\u00F2ng VIP - 250.000\u0111/ng\u00E0y";
    private static final String SANG = "S\u00E1ng (9h-12h)";
    private static final String CHIEU = "Chi\u1EC1u (14h-17h)";
    private static final String TOI = "T\u1ED1i (17h-19h)";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'></head><body>");
        
        try {
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            
            out.println("<h2>X\u00F3a d\u1EEF li\u1EC7u c\u0169...</h2>");
            exec(conn, "DELETE FROM vaccination_records");
            exec(conn, "DELETE FROM cart");
            exec(conn, "DELETE FROM reviews");
            exec(conn, "DELETE FROM appointments");
            exec(conn, "DELETE FROM hotel_bookings");
            exec(conn, "DELETE FROM spa_bookings");
            exec(conn, "DELETE FROM pets");
            exec(conn, "DELETE FROM vaccines");
            
            out.println("<h2>Th\u00EAm d\u1EEF li\u1EC7u m\u1EDBi...</h2>");
            
            // 1. Fix Users
            out.println("<p>Fixing users...</p>");
            updUser(conn, 1, QUAN_TRI_VIEN);
            updUser(conn, 2, NGUYEN_VAN_THANH);
            updUser(conn, 5, TRAN_THI_BINH);
            updUser(conn, 6, LE_VAN_CUONG);
            updUser(conn, 7, PHAM_THI_DUNG);
            updUser(conn, 8, HOANG_VAN_EM);

            // 2. Vaccines
            out.println("<p>Adding vaccines...</p>");
            addVaccine(conn, "Vaccine 5 b\u1EC7nh ch\u00F3", "Ph\u00F2ng Care, Parvo, Vi\u00EAm gan, Ho c\u0169i, Ph\u00F3 c\u00FAm", CHO, 250000);
            addVaccine(conn, "Vaccine 7 b\u1EC7nh ch\u00F3", "Ph\u00F2ng 5 b\u1EC7nh + Lepto + Corona", CHO, 350000);
            addVaccine(conn, "Vaccine d\u1EA1i", "Ph\u00F2ng b\u1EC7nh d\u1EA1i cho ch\u00F3 m\u00E8o", TAT_CA, 150000);
            addVaccine(conn, "Vaccine 4 b\u1EC7nh m\u00E8o", "Ph\u00F2ng Vi\u00EAm m\u0169i, Calici, Panleukopenia", MEO, 280000);
            addVaccine(conn, "Vaccine FeLV", "Ph\u00F2ng virus g\u00E2y b\u1EA1ch c\u1EA7u \u1EDF m\u00E8o", MEO, 320000);
            addVaccine(conn, "Vaccine Kennel Cough", "Ph\u00F2ng ho c\u0169i cho ch\u00F3", CHO, 200000);
            addVaccine(conn, "Vaccine Lepto", "Ph\u00F2ng b\u1EC7nh Leptospirosis", CHO, 180000);
            addVaccine(conn, "Vaccine Bordetella", "Ph\u00F2ng vi\u00EAm ph\u1EBF qu\u1EA3n truy\u1EC1n nhi\u1EC5m", CHO, 190000);
            addVaccine(conn, "Vaccine Corona ch\u00F3", "Ph\u00F2ng virus Corona \u1EDF ch\u00F3", CHO, 210000);
            addVaccine(conn, "Vaccine c\u00FAm ch\u00F3", "Ph\u00F2ng virus c\u00FAm H3N8/H3N2", CHO, 280000);
            
            // 3. Pets
            out.println("<p>Adding pets...</p>");
            addPet(conn, 2, "Lucky", CHO, "Golden Retriever", DUC, 25.5, "R\u1EA5t th\u00E2n thi\u1EC7n");
            addPet(conn, 2, "Miu Miu", MEO, "M\u00E8o Anh l\u00F4ng ng\u1EAFn", CAI, 4.2, "Nh\u00E1t ng\u01B0\u1EDDi");
            addPet(conn, 2, "B\u00F4ng", CHO, "Poodle", CAI, 5.8, "\u0110\u00E3 tri\u1EC7t s\u1EA3n");
            addPet(conn, 5, "Rex", CHO, "German Shepherd", DUC, 32.0, "\u0110\u00E3 hu\u1EA5n luy\u1EC7n");
            addPet(conn, 5, "Kitty", MEO, "M\u00E8o Xi\u00EAm", CAI, 3.8, "N\u0103ng \u0111\u1ED9ng");
            addPet(conn, 5, "Buddy", CHO, "Labrador", DUC, 28.0, "Th\u00EDch b\u01A1i l\u1ED9i");
            addPet(conn, 6, "Nala", MEO, "Maine Coon", CAI, 6.5, "K\u00EDch th\u01B0\u1EDBc l\u1EDBn");
            addPet(conn, 6, "Max", CHO, "Husky", DUC, 22.0, "C\u1EA7n v\u1EADn \u0111\u1ED9ng nhi\u1EC1u");
            addPet(conn, 6, "Luna", MEO, "Ragdoll", CAI, 4.0, "R\u1EA5t hi\u1EC1n l\u00E0nh");
            addPet(conn, 2, "Coco", CHO, "Corgi", CAI, 11.0, "Th\u00F4ng minh");
            
            // 4. Appointments
            out.println("<p>Adding appointments...</p>");
            addAppt(conn, 2, NGUYEN_VAN_THANH, "0901234567", "Lucky", CHO, 3, 1, "2026-01-20", "Ti\u00EAm vaccine d\u1EA1i \u0111\u1ECBnh k\u1EF3", "Confirmed");
            addAppt(conn, 2, NGUYEN_VAN_THANH, "0901234567", "Miu Miu", MEO, 1, 2, "2026-01-21", "Kh\u00E1m t\u1ED5ng qu\u00E1t", "Pending");
            addAppt(conn, 2, NGUYEN_VAN_THANH, "0901234567", "B\u00F4ng", CHO, 4, 3, "2026-01-22", "T\u1EAFm spa v\u00E0 c\u1EAFt t\u1EC9a l\u00F4ng", "Confirmed");
            addAppt(conn, 5, TRAN_THI_BINH, "0902345678", "Rex", CHO, 1, 1, "2026-01-23", "Kh\u00E1m da, nghi ng\u1EDD n\u1EA5m", "Pending");
            addAppt(conn, 5, TRAN_THI_BINH, "0902345678", "Kitty", MEO, 2, 2, "2026-01-24", "Ph\u1EABu thu\u1EADt tri\u1EC7t s\u1EA3n", "Confirmed");
            addAppt(conn, 5, TRAN_THI_BINH, "0902345678", "Buddy", CHO, 3, 1, "2026-01-25", "Ti\u00EAm vaccine 7 b\u1EC7nh", "Pending");
            addAppt(conn, 6, LE_VAN_CUONG, "0903456789", "Nala", MEO, 1, 3, "2026-01-26", "Kh\u00E1m m\u1EAFt", "Pending");
            addAppt(conn, 6, LE_VAN_CUONG, "0903456789", "Max", CHO, 4, 1, "2026-01-27", "Spa full combo", "Confirmed");
            addAppt(conn, 6, LE_VAN_CUONG, "0903456789", "Luna", MEO, 3, 2, "2026-01-28", "Ti\u00EAm vaccine FeLV", "Pending");
            addAppt(conn, 2, NGUYEN_VAN_THANH, "0901234567", "Coco", CHO, 5, 3, "2026-01-29", "G\u1EEDi kh\u00E1ch s\u1EA1n 3 ng\u00E0y", "Confirmed");

            // 5. Hotel Bookings
            out.println("<p>Adding hotel_bookings...</p>");
            addHotel(conn, 2, NGUYEN_VAN_THANH, "0901234567", "Miu Miu", MEO, DUOI_5KG, PHONG_TIEU_CHUAN, "2026-01-25", "2026-01-28", "Ch\u1EBF \u0111\u1ED9 \u0103n cao c\u1EA5p", "B\u00E9 nh\u00E1t ng\u01B0\u1EDDi", 3, 600000, "Confirmed");
            addHotel(conn, 2, NGUYEN_VAN_THANH, "0901234567", "B\u00F4ng", CHO, TREN_5KG, PHONG_VIP, "2026-02-01", "2026-02-05", "Vui ch\u01A1i th\u00EAm 30 ph\u00FAt", null, 4, 1200000, "Pending");
            addHotel(conn, 5, TRAN_THI_BINH, "0902345678", "Kitty", MEO, DUOI_5KG, PHONG_TIEU_CHUAN, "2026-02-10", "2026-02-12", null, "C\u1EA7n ph\u00F2ng y\u00EAn t\u0129nh", 2, 300000, "Pending");
            addHotel(conn, 5, TRAN_THI_BINH, "0902345678", "Rex", CHO, TREN_5KG, PHONG_VIP, "2026-02-15", "2026-02-20", "T\u1EAFm spa khi tr\u1EA3 ph\u00F2ng", "Ch\u00F3 l\u1EDBn c\u1EA7n ph\u00F2ng r\u1ED9ng", 5, 1400000, "Confirmed");
            addHotel(conn, 6, LE_VAN_CUONG, "0903456789", "Luna", MEO, DUOI_5KG, PHONG_TIEU_CHUAN, "2026-02-20", "2026-02-22", "C\u1EADp nh\u1EADt video h\u00E0ng ng\u00E0y", null, 2, 340000, "Pending");
            addHotel(conn, 6, LE_VAN_CUONG, "0903456789", "Nala", MEO, TREN_5KG, PHONG_VIP, "2026-02-25", "2026-02-28", "Ch\u1EBF \u0111\u1ED9 \u0103n cao c\u1EA5p", "Maine Coon", 3, 900000, "Confirmed");
            addHotel(conn, 2, NGUYEN_VAN_THANH, "0901234567", "Coco", CHO, TREN_5KG, PHONG_VIP, "2026-03-01", "2026-03-03", null, "\u0110i c\u00F4ng t\u00E1c", 2, 500000, "Pending");
            addHotel(conn, 5, TRAN_THI_BINH, "0902345678", "Buddy", CHO, TREN_5KG, PHONG_VIP, "2026-03-05", "2026-03-10", "Vui ch\u01A1i, T\u1EAFm spa", "Labrador th\u00EDch n\u01B0\u1EDBc", 5, 1550000, "Pending");
            addHotel(conn, 6, LE_VAN_CUONG, "0903456789", "Max", CHO, TREN_5KG, PHONG_VIP, "2026-03-15", "2026-03-18", "Ch\u1EBF \u0111\u1ED9 \u0103n cao c\u1EA5p, Video", "Husky c\u1EA7n v\u1EADn \u0111\u1ED9ng", 3, 1050000, "Confirmed");
            addHotel(conn, 2, NGUYEN_VAN_THANH, "0901234567", "Lucky", CHO, TREN_5KG, PHONG_VIP, "2026-03-20", "2026-03-25", "T\u1EAFm spa khi tr\u1EA3 ph\u00F2ng", "Golden th\u00E2n thi\u1EC7n", 5, 1400000, "Pending");
            
            // 6. Spa Bookings
            out.println("<p>Adding spa_bookings...</p>");
            addSpa(conn, 2, NGUYEN_VAN_THANH, "0901234567", "Lucky", CHO, "C\u1EAFt t\u1EC9a to\u00E0n th\u00E2n (> 5kg) - 500.000\u0111", "2026-01-20", SANG, "C\u1EAFt ki\u1EC3u Teddy bear", 500000, "Confirmed");
            addSpa(conn, 2, NGUYEN_VAN_THANH, "0901234567", "B\u00F4ng", CHO, "T\u1EAFm v\u1EC7 sinh (< 5kg) - 150.000\u0111", "2026-01-22", CHIEU, null, 150000, "Pending");
            addSpa(conn, 2, NGUYEN_VAN_THANH, "0901234567", "Miu Miu", MEO, "T\u1EAFm v\u1EC7 sinh (< 5kg) - 150.000\u0111", "2026-01-25", SANG, "M\u00E8o s\u1EE3 n\u01B0\u1EDBc", 150000, "Pending");
            addSpa(conn, 5, TRAN_THI_BINH, "0902345678", "Rex", CHO, "C\u1EAFt t\u1EC9a to\u00E0n th\u00E2n (> 5kg) - 500.000\u0111", "2026-01-26", SANG, "C\u1EAFt ng\u1EAFn d\u1EC5 ch\u0103m s\u00F3c", 500000, "Confirmed");
            addSpa(conn, 5, TRAN_THI_BINH, "0902345678", "Buddy", CHO, "T\u1EAFm v\u1EC7 sinh (> 5kg) - 250.000\u0111", "2026-01-28", TOI, "Labrador th\u00EDch n\u01B0\u1EDBc", 250000, "Pending");
            addSpa(conn, 5, TRAN_THI_BINH, "0902345678", "Kitty", MEO, "T\u1EAFm v\u1EC7 sinh (< 5kg) - 150.000\u0111", "2026-01-30", CHIEU, null, 150000, "Confirmed");
            addSpa(conn, 6, LE_VAN_CUONG, "0903456789", "Max", CHO, "Combo VIP (T\u1EAFm + C\u1EAFt t\u1EC9a + Nhu\u1ED9m)", "2026-02-01", SANG, "Nhu\u1ED9m xanh nh\u1EA1t \u1EDF tai", 800000, "Pending");
            addSpa(conn, 6, LE_VAN_CUONG, "0903456789", "Nala", MEO, "C\u1EAFt t\u1EC9a to\u00E0n th\u00E2n (> 5kg) - 500.000\u0111", "2026-02-03", CHIEU, "Maine Coon l\u00F4ng d\u00E0i", 500000, "Confirmed");
            addSpa(conn, 6, LE_VAN_CUONG, "0903456789", "Luna", MEO, "T\u1EAFm v\u1EC7 sinh (< 5kg) - 150.000\u0111", "2026-02-05", SANG, "Ragdoll hi\u1EC1n l\u00E0nh", 150000, "Pending");
            addSpa(conn, 2, NGUYEN_VAN_THANH, "0901234567", "Coco", CHO, "C\u1EAFt t\u1EC9a to\u00E0n th\u00E2n (< 5kg) - 350.000\u0111", "2026-02-08", TOI, "Ki\u1EC3u Corgi truy\u1EC1n th\u1ED1ng", 350000, "Confirmed");
            
            conn.close();
            out.println("<h3 style='color:green'>\u2713 Ho\u00E0n th\u00E0nh!</h3>");
            out.println("<p><a href='" + request.getContextPath() + "/admin/dashboard'>Quay v\u1EC1 Dashboard</a></p>");
            
        } catch (Exception e) {
            out.println("<h3 style='color:red'>L\u1ED7i: " + e.getMessage() + "</h3>");
            e.printStackTrace(out);
        }
        out.println("</body></html>");
    }
    
    private void exec(Connection c, String sql) throws Exception {
        c.prepareStatement(sql).executeUpdate();
    }
    
    private void updUser(Connection c, int id, String name) throws Exception {
        PreparedStatement ps = c.prepareStatement("UPDATE users SET fullname = ? WHERE id = ?");
        ps.setString(1, name);
        ps.setInt(2, id);
        ps.executeUpdate();
    }
    
    private void addVaccine(Connection c, String name, String desc, String species, int price) throws Exception {
        PreparedStatement ps = c.prepareStatement("INSERT INTO vaccines (name, description, target_species, manufacturer, price, doses_required, interval_days, min_age_weeks, stock_quantity, is_active) VALUES (?, ?, ?, 'Nobivac', ?, 2, 21, 8, 100, 1)");
        ps.setString(1, name);
        ps.setString(2, desc);
        ps.setString(3, species);
        ps.setInt(4, price);
        ps.executeUpdate();
    }
    
    private void addPet(Connection c, int userId, String name, String species, String breed, String gender, double weight, String notes) throws Exception {
        PreparedStatement ps = c.prepareStatement("INSERT INTO pets (user_id, name, species, breed, gender, birth_date, weight, color, notes) VALUES (?, ?, ?, ?, ?, '2023-01-01', ?, 'Mixed', ?)");
        ps.setInt(1, userId);
        ps.setString(2, name);
        ps.setString(3, species);
        ps.setString(4, breed);
        ps.setString(5, gender);
        ps.setDouble(6, weight);
        ps.setString(7, notes);
        ps.executeUpdate();
    }
    
    private void addAppt(Connection c, int userId, String custName, String phone, String petName, String petType, int serviceId, int doctorId, String date, String note, String status) throws Exception {
        PreparedStatement ps = c.prepareStatement("INSERT INTO appointments (user_id, customer_name, phone, pet_name, pet_type, service_id, doctor_id, booking_date, note, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        ps.setInt(1, userId);
        ps.setString(2, custName);
        ps.setString(3, phone);
        ps.setString(4, petName);
        ps.setString(5, petType);
        ps.setInt(6, serviceId);
        ps.setInt(7, doctorId);
        ps.setString(8, date);
        ps.setString(9, note);
        ps.setString(10, status);
        ps.executeUpdate();
    }
    
    private void addHotel(Connection c, int userId, String custName, String phone, String petName, String petType, String petWeight, String roomType, String checkIn, String checkOut, String extra, String note, int nights, int price, String status) throws Exception {
        PreparedStatement ps = c.prepareStatement("INSERT INTO hotel_bookings (user_id, customer_name, phone, pet_name, pet_type, pet_weight, room_type, check_in_date, check_out_date, extra_services, note, total_nights, total_price, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        ps.setInt(1, userId);
        ps.setString(2, custName);
        ps.setString(3, phone);
        ps.setString(4, petName);
        ps.setString(5, petType);
        ps.setString(6, petWeight);
        ps.setString(7, roomType);
        ps.setString(8, checkIn);
        ps.setString(9, checkOut);
        ps.setString(10, extra);
        ps.setString(11, note);
        ps.setInt(12, nights);
        ps.setInt(13, price);
        ps.setString(14, status);
        ps.executeUpdate();
    }
    
    private void addSpa(Connection c, int userId, String custName, String phone, String petName, String petType, String pkg, String date, String time, String note, int price, String status) throws Exception {
        PreparedStatement ps = c.prepareStatement("INSERT INTO spa_bookings (user_id, customer_name, phone, pet_name, pet_type, spa_package, booking_date, preferred_time, note, price, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        ps.setInt(1, userId);
        ps.setString(2, custName);
        ps.setString(3, phone);
        ps.setString(4, petName);
        ps.setString(5, petType);
        ps.setString(6, pkg);
        ps.setString(7, date);
        ps.setString(8, time);
        ps.setString(9, note);
        ps.setInt(10, price);
        ps.setString(11, status);
        ps.executeUpdate();
    }
}
