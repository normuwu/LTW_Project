package controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.ServiceDAO;
import DAO.VaccineDAO;
import Model.Service;
import Model.Vaccine;

@WebServlet("/admin/services")
public class ServiceManageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ServiceDAO serviceDAO = new ServiceDAO();
    private VaccineDAO vaccineDAO = new VaccineDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Service> services = serviceDAO.getAllServices();
        List<Vaccine> vaccines = vaccineDAO.getAllVaccines();
        
        request.setAttribute("services", services);
        request.setAttribute("vaccines", vaccines);
        request.setAttribute("totalServices", services.size());
        request.setAttribute("totalVaccines", vaccines.size());
        request.setAttribute("categories", serviceDAO.getAllCategories());
        
        request.getRequestDispatcher("/pages/admin/services.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String type = request.getParameter("type"); // service or vaccine
        String message = "";
        String messageType = "success";

        if ("service".equals(type)) {
            if ("add".equals(action)) {
                Service service = new Service();
                service.setName(request.getParameter("name"));
                service.setPrice(request.getParameter("price"));
                service.setDescription(request.getParameter("description"));
                service.setCategory(request.getParameter("category"));
                service.setDurationMinutes(Integer.parseInt(request.getParameter("duration")));
                service.setActive("on".equals(request.getParameter("isActive")));

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
                    service.setDurationMinutes(Integer.parseInt(request.getParameter("duration")));
                    service.setActive("on".equals(request.getParameter("isActive")));

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

        } else if ("vaccine".equals(type)) {
            if ("add".equals(action)) {
                Vaccine vaccine = new Vaccine();
                vaccine.setName(request.getParameter("name"));
                vaccine.setDescription(request.getParameter("description"));
                vaccine.setTargetSpecies(request.getParameter("targetSpecies"));
                vaccine.setManufacturer(request.getParameter("manufacturer"));
                vaccine.setPrice(Long.parseLong(request.getParameter("price").replaceAll("[^0-9]", "")));
                vaccine.setDosesRequired(Integer.parseInt(request.getParameter("dosesRequired")));
                vaccine.setIntervalDays(Integer.parseInt(request.getParameter("intervalDays")));
                vaccine.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
                vaccine.setActive("on".equals(request.getParameter("isActive")));

                if (vaccineDAO.insertVaccine(vaccine)) {
                    message = "Đã thêm vaccine thành công!";
                } else {
                    message = "Có lỗi xảy ra!";
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
                    vaccine.setPrice(Long.parseLong(request.getParameter("price").replaceAll("[^0-9]", "")));
                    vaccine.setDosesRequired(Integer.parseInt(request.getParameter("dosesRequired")));
                    vaccine.setIntervalDays(Integer.parseInt(request.getParameter("intervalDays")));
                    vaccine.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
                    vaccine.setActive("on".equals(request.getParameter("isActive")));

                    if (vaccineDAO.updateVaccine(vaccine)) {
                        message = "Đã cập nhật vaccine thành công!";
                    } else {
                        message = "Có lỗi xảy ra!";
                        messageType = "error";
                    }
                }

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                if (vaccineDAO.deleteVaccine(id)) {
                    message = "Đã xóa vaccine thành công!";
                } else {
                    message = "Có lỗi xảy ra!";
                    messageType = "error";
                }
            }
        }

        request.getSession().setAttribute("message", message);
        request.getSession().setAttribute("messageType", messageType);
        response.sendRedirect(request.getContextPath() + "/admin/services");
    }
}
