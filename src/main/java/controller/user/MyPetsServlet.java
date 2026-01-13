package controller.user;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import DAO.PetDAO;
import DAO.VaccinationRecordDAO;
import Model.Pet;
import Model.User;
import Model.VaccinationRecord;

@WebServlet("/user/my-pets")
public class MyPetsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private PetDAO petDAO = new PetDAO();
    private VaccinationRecordDAO recordDAO = new VaccinationRecordDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy danh sách thú cưng của user
        List<Pet> pets = petDAO.getPetsByUserId(user.getId());
        request.setAttribute("pets", pets);
        
        // Lấy các mũi tiêm sắp đến hạn
        List<VaccinationRecord> upcomingVaccinations = recordDAO.getUpcomingVaccinations(user.getId());
        request.setAttribute("upcomingVaccinations", upcomingVaccinations);
        
        // Thống kê
        request.setAttribute("totalPets", pets.size());
        int totalVaccinations = 0;
        for (Pet pet : pets) {
            totalVaccinations += pet.getVaccinationCount();
        }
        request.setAttribute("totalVaccinations", totalVaccinations);
        
        request.getRequestDispatcher("/pages/user/my-pets.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        String message = "";
        String messageType = "success";
        
        if ("add".equals(action)) {
            Pet pet = new Pet();
            pet.setUserId(user.getId());
            pet.setName(request.getParameter("name"));
            pet.setSpecies(request.getParameter("species"));
            pet.setBreed(request.getParameter("breed"));
            pet.setGender(request.getParameter("gender"));
            
            String birthDateStr = request.getParameter("birthDate");
            if (birthDateStr != null && !birthDateStr.isEmpty()) {
                pet.setBirthDate(Date.valueOf(birthDateStr));
            }
            
            String weightStr = request.getParameter("weight");
            if (weightStr != null && !weightStr.isEmpty()) {
                pet.setWeight(Double.parseDouble(weightStr));
            }
            
            pet.setColor(request.getParameter("color"));
            pet.setNotes(request.getParameter("notes"));
            
            if (petDAO.insertPet(pet)) {
                message = "Đã thêm thú cưng " + pet.getName() + " thành công!";
            } else {
                message = "Có lỗi xảy ra khi thêm thú cưng!";
                messageType = "error";
            }
            
        } else if ("edit".equals(action)) {
            int petId = Integer.parseInt(request.getParameter("id"));
            
            // Kiểm tra quyền sở hữu
            if (!petDAO.isPetOwnedByUser(petId, user.getId())) {
                message = "Bạn không có quyền chỉnh sửa thú cưng này!";
                messageType = "error";
            } else {
                Pet pet = petDAO.getPetById(petId);
                if (pet != null) {
                    pet.setName(request.getParameter("name"));
                    pet.setSpecies(request.getParameter("species"));
                    pet.setBreed(request.getParameter("breed"));
                    pet.setGender(request.getParameter("gender"));
                    
                    String birthDateStr = request.getParameter("birthDate");
                    if (birthDateStr != null && !birthDateStr.isEmpty()) {
                        pet.setBirthDate(Date.valueOf(birthDateStr));
                    }
                    
                    String weightStr = request.getParameter("weight");
                    if (weightStr != null && !weightStr.isEmpty()) {
                        pet.setWeight(Double.parseDouble(weightStr));
                    }
                    
                    pet.setColor(request.getParameter("color"));
                    pet.setNotes(request.getParameter("notes"));
                    
                    if (petDAO.updatePet(pet)) {
                        message = "Đã cập nhật thông tin " + pet.getName() + " thành công!";
                    } else {
                        message = "Có lỗi xảy ra khi cập nhật!";
                        messageType = "error";
                    }
                }
            }
            
        } else if ("delete".equals(action)) {
            int petId = Integer.parseInt(request.getParameter("id"));
            
            // Kiểm tra quyền sở hữu
            if (!petDAO.isPetOwnedByUser(petId, user.getId())) {
                message = "Bạn không có quyền xóa thú cưng này!";
                messageType = "error";
            } else {
                if (petDAO.deletePet(petId)) {
                    message = "Đã xóa thú cưng thành công!";
                } else {
                    message = "Có lỗi xảy ra khi xóa!";
                    messageType = "error";
                }
            }
        }
        
        session.setAttribute("message", message);
        session.setAttribute("messageType", messageType);
        response.sendRedirect(request.getContextPath() + "/user/my-pets");
    }
}
