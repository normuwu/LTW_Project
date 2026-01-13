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

@WebServlet("/admin/statistics")
public class StatisticsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy năm hiện tại hoặc từ parameter
        String yearParam = request.getParameter("year");
        int year = yearParam != null ? Integer.parseInt(yearParam) : Calendar.getInstance().get(Calendar.YEAR);
        
        // Thống kê tổng quan
        Map<String, Integer> overview = reportDAO.getOverviewStats();
        request.setAttribute("overview", overview);
        
        // Thống kê tiêm chủng theo tháng (biểu đồ cột)
        List<Map<String, Object>> vaccinationsByMonth = reportDAO.getVaccinationsByMonth(year);
        request.setAttribute("vaccinationsByMonthJson", toJson(vaccinationsByMonth));
        
        // Thống kê vaccine phổ biến (biểu đồ tròn)
        List<Map<String, Object>> popularVaccines = reportDAO.getPopularVaccines();
        request.setAttribute("popularVaccinesJson", toJsonVaccine(popularVaccines));
        
        // Thống kê dịch vụ phổ biến (biểu đồ cột ngang)
        List<Map<String, Object>> serviceStats = reportDAO.getAppointmentsByService();
        request.setAttribute("serviceStatsJson", toJsonService(serviceStats));
        
        // Thống kê lịch hẹn theo tháng với trạng thái (biểu đồ đường)
        List<Map<String, Object>> appointmentsByMonth = reportDAO.getAppointmentsByMonthWithStatus(year);
        request.setAttribute("appointmentsByMonthJson", toJsonAppointment(appointmentsByMonth));
        
        request.setAttribute("selectedYear", year);
        request.setAttribute("currentYear", Calendar.getInstance().get(Calendar.YEAR));
        
        request.getRequestDispatcher("/pages/admin/statistics.jsp").forward(request, response);
    }
    
    // Helper methods to convert to JSON
    private String toJson(List<Map<String, Object>> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> item = list.get(i);
            sb.append("{\"month\":").append(item.get("month"))
              .append(",\"count\":").append(item.get("count")).append("}");
            if (i < list.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
    
    private String toJsonVaccine(List<Map<String, Object>> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> item = list.get(i);
            String vaccine = item.get("vaccine") != null ? item.get("vaccine").toString().replace("\"", "\\\"") : "";
            sb.append("{\"vaccine\":\"").append(vaccine)
              .append("\",\"count\":").append(item.get("count")).append("}");
            if (i < list.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
    
    private String toJsonService(List<Map<String, Object>> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> item = list.get(i);
            String service = item.get("service") != null ? item.get("service").toString().replace("\"", "\\\"") : "";
            sb.append("{\"service\":\"").append(service)
              .append("\",\"count\":").append(item.get("count")).append("}");
            if (i < list.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
    
    private String toJsonAppointment(List<Map<String, Object>> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> item = list.get(i);
            sb.append("{\"month\":").append(item.get("month"))
              .append(",\"pending\":").append(item.get("pending"))
              .append(",\"confirmed\":").append(item.get("confirmed"))
              .append(",\"completed\":").append(item.get("completed"))
              .append(",\"total\":").append(item.get("total")).append("}");
            if (i < list.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
}
