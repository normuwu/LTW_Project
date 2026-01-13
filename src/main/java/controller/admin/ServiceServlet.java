package controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import DAO.ServiceDAO;
import Model.Service;
import Model.User;

@WebServlet("/pages/admin/services")
public class ServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ServiceDAO serviceDAO = new ServiceDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<Service> services = serviceDAO.getAllServices();
        request.setAttribute("services", services);
        request.setAttribute("totalServices", serviceDAO.countAll());
        request.setAttribute("categories", serviceDAO.getAllCategories());
        
        request.getRequestDispatcher("/pages/admin/services.jsp").forward(request, response);
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
            Service service = new Service();
            service.setName(request.getParameter("name"));
            service.setPrice(request.getParameter("price"));
            service.setDescription(request.getParameter("description"));
            service.setCategory(request.getParameter("category"));
            service.setDurationMinutes(Integer.parseInt(request.getParameter("durationMinutes")));
            service.setActive(true);
            
            if (serviceDAO.insertService(service)) {
                message = "Đã thêm dịch vụ thành công!";
            } else {
                message = "Có lỗi xảy ra!";
                messageType = "error";
            }
            
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Service service = serviceDAO.getServiceById(id);
            
            if (service != null) {
                service.setName(request.getParameter("name"));
                service.setPrice(request.getParameter("price"));
                service.setDescription(request.getParameter("description"));
                service.setCategory(request.getParameter("category"));
                service.setDurationMinutes(Integer.parseInt(request.getParameter("durationMinutes")));
                
                if (serviceDAO.updateService(service)) {
                    message = "Đã cập nhật dịch vụ thành công!";
                } else {
                    message = "Có lỗi xảy ra!";
                    messageType = "error";
                }
            }
            
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            
            if (serviceDAO.deleteService(id)) {
                message = "Đã xóa dịch vụ thành công!";
            } else {
                message = "Có lỗi xảy ra!";
                messageType = "error";
            }
        }
        
        session.setAttribute("message", message);
        session.setAttribute("messageType", messageType);
        response.sendRedirect(request.getContextPath() + "/pages/admin/services");
    }
}
