package controller.admin;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.AppointmentDAO;
import DAO.DoctorDAO;
import DAO.PetDAO;
import DAO.VaccinationRecordDAO;
import DAO.VaccineDAO;
import Model.Appointment;
import Model.Doctors;
import Model.Pet;
import Model.VaccinationRecord;
import Model.Vaccine;

@WebServlet("/admin/vaccination-records")
public class VaccinationRecordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private VaccinationRecordDAO recordDAO = new VaccinationRecordDAO();
    private VaccineDAO vaccineDAO = new VaccineDAO();
    private PetDAO petDAO = new PetDAO();
    private DoctorDAO doctorDAO = new DoctorDAO();
    private AppointmentDAO appointmentDAO = new AppointmentDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy danh sách tất cả bản ghi tiêm chủng
        List<VaccinationRecord> records = recordDAO.getAllRecords();
        request.setAttribute("records", records);
        request.setAttribute("totalRecords", records.size());
        
        // Lấy danh sách vaccines để filter và form
        List<Vaccine> vaccines = vaccineDAO.getActiveVaccines();
        request.setAttribute("vaccines", vaccines);
        
        // Lấy danh sách bác sĩ cho form
        List<Doctors> doctors = doctorDAO.getActiveDoctors();
        request.setAttribute("doctors", doctors);
        
        // Lấy danh sách lịch hẹn vaccine đã xác nhận (service_id = 3) để liên kết
        List<Appointment> vaccineAppointments = appointmentDAO.getAppointmentsByServiceId(3);
        // Lọc chỉ lấy Confirmed
        vaccineAppointments.removeIf(a -> !"Confirmed".equals(a.getStatus()));
        request.setAttribute("vaccineAppointments", vaccineAppointments);
        
        // Lấy tất cả pets (cho admin chọn)
        List<Pet> allPets = getAllPets();
        request.setAttribute("allPets", allPets);
        
        request.getRequestDispatcher("/pages/admin/vaccination-records.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            handleAdd(request, session);
        } else if ("edit".equals(action)) {
            handleEdit(request, session);
        } else if ("delete".equals(action)) {
            handleDelete(request, session);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/vaccination-records");
    }
    
    private void handleAdd(HttpServletRequest request, HttpSession session) {
        try {
            int petId = Integer.parseInt(request.getParameter("petId"));
            int vaccineId = Integer.parseInt(request.getParameter("vaccineId"));
            String appointmentIdStr = request.getParameter("appointmentId");
            String doctorIdStr = request.getParameter("doctorId");
            String vaccinationDateStr = request.getParameter("vaccinationDate");
            int doseNumber = Integer.parseInt(request.getParameter("doseNumber"));
            String batchNumber = request.getParameter("batchNumber");
            String nextDueDateStr = request.getParameter("nextDueDate");
            String notes = request.getParameter("notes");
            
            VaccinationRecord record = new VaccinationRecord();
            record.setPetId(petId);
            record.setVaccineId(vaccineId);
            
            // Appointment ID (optional)
            if (appointmentIdStr != null && !appointmentIdStr.isEmpty()) {
                record.setAppointmentId(Integer.parseInt(appointmentIdStr));
            }
            
            // Doctor ID (optional)
            if (doctorIdStr != null && !doctorIdStr.isEmpty() && !"0".equals(doctorIdStr)) {
                record.setDoctorId(Integer.parseInt(doctorIdStr));
            }
            
            // Vaccination date
            record.setVaccinationDate(Date.valueOf(vaccinationDateStr));
            record.setDoseNumber(doseNumber);
            record.setBatchNumber(batchNumber);
            
            // Next due date (optional)
            if (nextDueDateStr != null && !nextDueDateStr.isEmpty()) {
                record.setNextDueDate(Date.valueOf(nextDueDateStr));
            }
            
            record.setNotes(notes);
            
            if (recordDAO.insertRecord(record)) {
                // Giảm tồn kho vaccine
                vaccineDAO.decreaseStock(vaccineId);
                
                // Nếu có liên kết với appointment, cập nhật trạng thái thành Completed
                if (record.getAppointmentId() != null) {
                    appointmentDAO.completeAppointment(record.getAppointmentId());
                }
                
                session.setAttribute("message", "Thêm bản ghi tiêm chủng thành công!");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Có lỗi xảy ra khi thêm bản ghi!");
                session.setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Lỗi: " + e.getMessage());
            session.setAttribute("messageType", "error");
        }
    }
    
    private void handleEdit(HttpServletRequest request, HttpSession session) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int vaccineId = Integer.parseInt(request.getParameter("vaccineId"));
            String doctorIdStr = request.getParameter("doctorId");
            String vaccinationDateStr = request.getParameter("vaccinationDate");
            int doseNumber = Integer.parseInt(request.getParameter("doseNumber"));
            String batchNumber = request.getParameter("batchNumber");
            String nextDueDateStr = request.getParameter("nextDueDate");
            String notes = request.getParameter("notes");
            
            VaccinationRecord record = recordDAO.getRecordById(id);
            if (record != null) {
                record.setVaccineId(vaccineId);
                
                if (doctorIdStr != null && !doctorIdStr.isEmpty() && !"0".equals(doctorIdStr)) {
                    record.setDoctorId(Integer.parseInt(doctorIdStr));
                } else {
                    record.setDoctorId(null);
                }
                
                record.setVaccinationDate(Date.valueOf(vaccinationDateStr));
                record.setDoseNumber(doseNumber);
                record.setBatchNumber(batchNumber);
                
                if (nextDueDateStr != null && !nextDueDateStr.isEmpty()) {
                    record.setNextDueDate(Date.valueOf(nextDueDateStr));
                } else {
                    record.setNextDueDate(null);
                }
                
                record.setNotes(notes);
                
                if (recordDAO.updateRecord(record)) {
                    session.setAttribute("message", "Cập nhật bản ghi thành công!");
                    session.setAttribute("messageType", "success");
                } else {
                    session.setAttribute("message", "Có lỗi xảy ra khi cập nhật!");
                    session.setAttribute("messageType", "error");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Lỗi: " + e.getMessage());
            session.setAttribute("messageType", "error");
        }
    }
    
    private void handleDelete(HttpServletRequest request, HttpSession session) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            if (recordDAO.deleteRecord(id)) {
                session.setAttribute("message", "Xóa bản ghi thành công!");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Có lỗi xảy ra khi xóa!");
                session.setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Lỗi: " + e.getMessage());
            session.setAttribute("messageType", "error");
        }
    }
    
    // Lấy tất cả pets từ database
    private List<Pet> getAllPets() {
        List<Pet> list = new java.util.ArrayList<>();
        String query = "SELECT p.*, u.fullname as owner_name FROM pets p " +
                       "LEFT JOIN users u ON p.user_id = u.id ORDER BY p.name";
        
        try (java.sql.Connection conn = new Context.DBContext().getConnection();
             java.sql.PreparedStatement ps = conn.prepareStatement(query);
             java.sql.ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setId(rs.getInt("id"));
                pet.setUserId(rs.getInt("user_id"));
                pet.setName(rs.getString("name"));
                pet.setSpecies(rs.getString("species"));
                try { pet.setOwnerName(rs.getString("owner_name")); } catch (Exception e) {}
                list.add(pet);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
