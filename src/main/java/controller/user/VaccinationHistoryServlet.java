package controller.user;

import java.io.IOException;
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

@WebServlet("/user/vaccination-history")
public class VaccinationHistoryServlet extends HttpServlet {
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
        
        // Lấy danh sách thú cưng để filter
        List<Pet> pets = petDAO.getPetsByUserId(user.getId());
        request.setAttribute("pets", pets);
        
        // Lấy pet_id từ query string nếu có
        String petIdStr = request.getParameter("petId");
        List<VaccinationRecord> records;
        
        if (petIdStr != null && !petIdStr.isEmpty()) {
            int petId = Integer.parseInt(petIdStr);
            // Kiểm tra quyền sở hữu
            if (petDAO.isPetOwnedByUser(petId, user.getId())) {
                records = recordDAO.getRecordsByPetId(petId);
                request.setAttribute("selectedPetId", petId);
                
                // Lấy thông tin pet được chọn
                Pet selectedPet = petDAO.getPetById(petId);
                request.setAttribute("selectedPet", selectedPet);
            } else {
                records = recordDAO.getRecordsByUserId(user.getId());
            }
        } else {
            // Lấy tất cả lịch sử tiêm của user
            records = recordDAO.getRecordsByUserId(user.getId());
        }
        
        request.setAttribute("records", records);
        
        // Lấy các mũi tiêm sắp đến hạn
        List<VaccinationRecord> upcomingVaccinations = recordDAO.getUpcomingVaccinations(user.getId());
        request.setAttribute("upcomingVaccinations", upcomingVaccinations);
        
        // Thống kê
        request.setAttribute("totalRecords", records.size());
        request.setAttribute("upcomingCount", upcomingVaccinations.size());
        
        request.getRequestDispatcher("/pages/user/vaccination-history.jsp").forward(request, response);
    }
}
