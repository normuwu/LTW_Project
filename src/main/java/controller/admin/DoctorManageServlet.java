package controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.DoctorDAO;
import Model.Doctors;

@WebServlet("/admin/doctors")
public class DoctorManageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DoctorDAO doctorDAO = new DoctorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Doctors> doctors = doctorDAO.getAllDoctors();
        request.setAttribute("doctors", doctors);
        request.setAttribute("totalDoctors", doctors.size());
        
        request.getRequestDispatcher("/pages/admin/doctors.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String message = "";
        String messageType = "success";

        if ("add".equals(action)) {
            Doctors doctor = new Doctors();
            doctor.setName(request.getParameter("name"));
            doctor.setSpecialty(request.getParameter("specialty"));
            doctor.setPhone(request.getParameter("phone"));
            doctor.setEmail(request.getParameter("email"));
            doctor.setWorkSchedule(request.getParameter("workSchedule"));
            doctor.setImage(request.getParameter("image"));
            doctor.setActive("on".equals(request.getParameter("isActive")));

            if (doctorDAO.insertDoctor(doctor)) {
                message = "Đã thêm bác sĩ " + doctor.getName() + " thành công!";
            } else {
                message = "Có lỗi xảy ra khi thêm bác sĩ!";
                messageType = "error";
            }

        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Doctors doctor = doctorDAO.getDoctorById(id);
            if (doctor != null) {
                doctor.setName(request.getParameter("name"));
                doctor.setSpecialty(request.getParameter("specialty"));
                doctor.setPhone(request.getParameter("phone"));
                doctor.setEmail(request.getParameter("email"));
                doctor.setWorkSchedule(request.getParameter("workSchedule"));
                String image = request.getParameter("image");
                if (image != null && !image.isEmpty()) {
                    doctor.setImage(image);
                }
                doctor.setActive("on".equals(request.getParameter("isActive")));

                if (doctorDAO.updateDoctor(doctor)) {
                    message = "Đã cập nhật thông tin bác sĩ thành công!";
                } else {
                    message = "Có lỗi xảy ra khi cập nhật!";
                    messageType = "error";
                }
            }

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if (doctorDAO.deleteDoctor(id)) {
                message = "Đã xóa bác sĩ thành công!";
            } else {
                message = "Có lỗi xảy ra khi xóa!";
                messageType = "error";
            }
        }

        request.getSession().setAttribute("message", message);
        request.getSession().setAttribute("messageType", messageType);
        response.sendRedirect(request.getContextPath() + "/admin/doctors");
    }
}
