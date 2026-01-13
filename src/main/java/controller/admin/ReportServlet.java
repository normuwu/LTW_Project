package controller.admin;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.ReportDAO;

@WebServlet("/admin/reports")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String yearParam = request.getParameter("year");
        int year = yearParam != null ? Integer.parseInt(yearParam) : Calendar.getInstance().get(Calendar.YEAR);
        
        // Thống kê tổng quan
        Map<String, Integer> overview = reportDAO.getOverviewStats();
        request.setAttribute("overview", overview);
        
        // Thống kê theo tháng
        List<Map<String, Object>> appointmentsByMonth = reportDAO.getAppointmentsByMonth(year);
        List<Map<String, Object>> vaccinationsByMonth = reportDAO.getVaccinationsByMonth(year);
        
        // Thống kê theo dịch vụ và bác sĩ
        List<Map<String, Object>> appointmentsByService = reportDAO.getAppointmentsByService();
        List<Map<String, Object>> appointmentsByDoctor = reportDAO.getAppointmentsByDoctor();
        List<Map<String, Object>> popularVaccines = reportDAO.getPopularVaccines();
        
        // Convert to JSON manually
        request.setAttribute("appointmentsByMonthJson", toJson(appointmentsByMonth));
        request.setAttribute("vaccinationsByMonthJson", toJson(vaccinationsByMonth));
        request.setAttribute("appointmentsByServiceJson", toJsonService(appointmentsByService));
        request.setAttribute("appointmentsByDoctorJson", toJsonDoctor(appointmentsByDoctor));
        request.setAttribute("popularVaccinesJson", toJsonVaccine(popularVaccines));
        
        request.setAttribute("selectedYear", year);
        request.setAttribute("currentYear", Calendar.getInstance().get(Calendar.YEAR));
        
        request.getRequestDispatcher("/pages/admin/reports.jsp").forward(request, response);
    }
    
    private String toJson(List<Map<String, Object>> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> item = list.get(i);
            sb.append("{\"month\":").append(item.get("month"))
              .append(",\"count\":").append(item.get("count"));
            if (item.containsKey("completed")) {
                sb.append(",\"completed\":").append(item.get("completed"));
            }
            sb.append("}");
            if (i < list.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
    
    private String toJsonService(List<Map<String, Object>> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> item = list.get(i);
            sb.append("{\"service\":\"").append(item.get("service"))
              .append("\",\"count\":").append(item.get("count")).append("}");
            if (i < list.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
    
    private String toJsonDoctor(List<Map<String, Object>> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> item = list.get(i);
            sb.append("{\"doctor\":\"").append(item.get("doctor"))
              .append("\",\"count\":").append(item.get("count")).append("}");
            if (i < list.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
    
    private String toJsonVaccine(List<Map<String, Object>> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> item = list.get(i);
            sb.append("{\"vaccine\":\"").append(item.get("vaccine"))
              .append("\",\"count\":").append(item.get("count")).append("}");
            if (i < list.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
}
