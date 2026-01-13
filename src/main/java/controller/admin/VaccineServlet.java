package controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import DAO.VaccineDAO;
import Model.User;
import Model.Vaccine;

@WebServlet("/pages/admin/vaccines")
public class VaccineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private VaccineDAO vaccineDAO = new VaccineDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<Vaccine> vaccines = vaccineDAO.getAllVaccines();
        request.setAttribute("vaccines", vaccines);
        
        // Thống kê
        request.setAttribute("totalVaccines", vaccineDAO.countAll());
        request.setAttribute("lowStock", vaccineDAO.countLowStock());
        request.setAttribute("outOfStock", vaccineDAO.countOutOfStock());
        
        request.getRequestDispatcher("/pages/admin/vaccines.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        String message = "";
        String messageType = "success";
        
        if ("add".equals(action)) {
            Vaccine vaccine = new Vaccine();
            vaccine.setName(request.getParameter("name"));
            vaccine.setDescription(request.getParameter("description"));
            vaccine.setTargetSpecies(request.getParameter("targetSpecies"));
            vaccine.setManufacturer(request.getParameter("manufacturer"));
            vaccine.setPrice(Long.parseLong(request.getParameter("price")));
            vaccine.setDosesRequired(Integer.parseInt(request.getParameter("dosesRequired")));
            vaccine.setIntervalDays(Integer.parseInt(request.getParameter("intervalDays")));
            vaccine.setMinAgeWeeks(Integer.parseInt(request.getParameter("minAgeWeeks")));
            vaccine.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
            vaccine.setActive("on".equals(request.getParameter("isActive")) || "true".equals(request.getParameter("isActive")));
            
            if (vaccineDAO.insertVaccine(vaccine)) {
                message = "Đã thêm vaccine " + vaccine.getName() + " thành công!";
            } else {
                message = "Có lỗi xảy ra khi thêm vaccine!";
                messageType = "error";
            }
            
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Vaccine vaccine = vaccineDAO.getVaccineById(id);
            
            if (vaccine != null) {
                vaccine.setName(request.getParameter("name"));
                vaccine.setDescription(request.getParameter("description"));
                vaccine.setTargetSpecies(request.getParameter("targetSpecies"));
                vaccine.setManufacturer(request.getParameter("manufacturer"));
                vaccine.setPrice(Long.parseLong(request.getParameter("price")));
                vaccine.setDosesRequired(Integer.parseInt(request.getParameter("dosesRequired")));
                vaccine.setIntervalDays(Integer.parseInt(request.getParameter("intervalDays")));
                vaccine.setMinAgeWeeks(Integer.parseInt(request.getParameter("minAgeWeeks")));
                vaccine.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
                vaccine.setActive("on".equals(request.getParameter("isActive")) || "true".equals(request.getParameter("isActive")));
                
                if (vaccineDAO.updateVaccine(vaccine)) {
                    message = "Đã cập nhật vaccine thành công!";
                } else {
                    message = "Có lỗi xảy ra khi cập nhật!";
                    messageType = "error";
                }
            }
            
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            
            if (vaccineDAO.deleteVaccine(id)) {
                message = "Đã xóa vaccine thành công!";
            } else {
                message = "Có lỗi xảy ra khi xóa! Vaccine có thể đang được sử dụng.";
                messageType = "error";
            }
            
        } else if ("updateStock".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            if (vaccineDAO.updateStock(id, quantity)) {
                message = "Đã cập nhật tồn kho thành công!";
            } else {
                message = "Có lỗi xảy ra khi cập nhật tồn kho!";
                messageType = "error";
            }
        }
        
        session.setAttribute("message", message);
        session.setAttribute("messageType", messageType);
        response.sendRedirect(request.getContextPath() + "/pages/admin/vaccines");
    }
}
