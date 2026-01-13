package controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.VaccineDAO;
import DAO.VaccinationRecordDAO;
import Model.Vaccine;

@WebServlet("/admin/vaccines")
public class VaccineManageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VaccineDAO vaccineDAO = new VaccineDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy danh sách vaccine
        List<Vaccine> vaccines = vaccineDAO.getAllVaccines();
        request.setAttribute("vaccines", vaccines);
        
        // Thống kê
        request.setAttribute("totalVaccines", vaccineDAO.countAll());
        request.setAttribute("lowStockCount", vaccineDAO.countLowStock());
        request.setAttribute("outOfStockCount", vaccineDAO.countOutOfStock());
        
        request.getRequestDispatcher("/pages/admin/vaccines.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String message = "";
        String messageType = "success";

        try {
            switch (action) {
                case "add":
                    Vaccine newVaccine = new Vaccine();
                    newVaccine.setName(request.getParameter("name"));
                    newVaccine.setDescription(request.getParameter("description"));
                    newVaccine.setTargetSpecies(request.getParameter("targetSpecies"));
                    newVaccine.setManufacturer(request.getParameter("manufacturer"));
                    newVaccine.setPrice(Long.parseLong(request.getParameter("price")));
                    newVaccine.setDosesRequired(Integer.parseInt(request.getParameter("dosesRequired")));
                    newVaccine.setIntervalDays(Integer.parseInt(request.getParameter("intervalDays")));
                    newVaccine.setMinAgeWeeks(Integer.parseInt(request.getParameter("minAgeWeeks")));
                    newVaccine.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
                    newVaccine.setActive(request.getParameter("isActive") != null);
                    
                    if (vaccineDAO.insertVaccine(newVaccine)) {
                        message = "Thêm vaccine thành công!";
                    } else {
                        message = "Không thể thêm vaccine!";
                        messageType = "error";
                    }
                    break;
                    
                case "update":
                    Vaccine updateVaccine = new Vaccine();
                    updateVaccine.setId(Integer.parseInt(request.getParameter("id")));
                    updateVaccine.setName(request.getParameter("name"));
                    updateVaccine.setDescription(request.getParameter("description"));
                    updateVaccine.setTargetSpecies(request.getParameter("targetSpecies"));
                    updateVaccine.setManufacturer(request.getParameter("manufacturer"));
                    updateVaccine.setPrice(Long.parseLong(request.getParameter("price")));
                    updateVaccine.setDosesRequired(Integer.parseInt(request.getParameter("dosesRequired")));
                    updateVaccine.setIntervalDays(Integer.parseInt(request.getParameter("intervalDays")));
                    updateVaccine.setMinAgeWeeks(Integer.parseInt(request.getParameter("minAgeWeeks")));
                    updateVaccine.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
                    updateVaccine.setActive(request.getParameter("isActive") != null);
                    
                    if (vaccineDAO.updateVaccine(updateVaccine)) {
                        message = "Cập nhật vaccine thành công!";
                    } else {
                        message = "Không thể cập nhật vaccine!";
                        messageType = "error";
                    }
                    break;
                    
                case "delete":
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    if (vaccineDAO.deleteVaccine(deleteId)) {
                        message = "Xóa vaccine thành công!";
                    } else {
                        message = "Không thể xóa vaccine!";
                        messageType = "error";
                    }
                    break;
                    
                case "updateStock":
                    int vaccineId = Integer.parseInt(request.getParameter("id"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    if (vaccineDAO.updateStock(vaccineId, quantity)) {
                        message = "Cập nhật tồn kho thành công!";
                    } else {
                        message = "Không thể cập nhật tồn kho!";
                        messageType = "error";
                    }
                    break;
            }
        } catch (Exception e) {
            message = "Có lỗi xảy ra: " + e.getMessage();
            messageType = "error";
            e.printStackTrace();
        }

        request.getSession().setAttribute("message", message);
        request.getSession().setAttribute("messageType", messageType);
        response.sendRedirect(request.getContextPath() + "/admin/vaccines");
    }
}
