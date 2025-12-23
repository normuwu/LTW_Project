import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.CareItemDAO;
import DAO.DoctorDAO;
import DAO.FeatureDAO; // <-- Import mới
import Model.CareItem;
import Model.Doctor;
import Model.Feature;

@WebServlet("/about")
public class AboutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. Lấy Features từ DB
		FeatureDAO featureDao = new FeatureDAO();
		List<Feature> features = featureDao.getAllFeatures();

		// 2. Lấy Doctors từ DB
		DoctorDAO doctorDao = new DoctorDAO();
		List<Doctor> doctors = doctorDao.getAllDoctors();

		// 3. Lấy CareItems từ DB
		CareItemDAO careDao = new CareItemDAO();
		List<CareItem> careItems = careDao.getAllCareItems();

		// Gửi tất cả sang JSP
		request.setAttribute("features", features);
		request.setAttribute("doctors", doctors);
		request.setAttribute("careItems", careItems);

		request.getRequestDispatcher("/mainPages/about.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}