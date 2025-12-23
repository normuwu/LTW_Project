import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Appointment;
import Model.Doctor; // 👇 Nhớ import Doctor

@WebServlet("/schedule")
public class ScheduleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Appointment> list = new ArrayList<>();
		
		// 1. Tạo các bác sĩ (Giả lập lấy từ Database)
		Doctor doc1 = new Doctor("Bs. Ngọc Thành", "webpic14.jpg");
		Doctor doc2 = new Doctor("Bs. Huyền Trang", "webpic15.jpg");
		Doctor doc3 = new Doctor("Bs. Sterenn Genewe", "webpic16.jpg");

		// 2. Tạo lịch hẹn và gán bác sĩ vào
		list.add(new Appointment("LH001", "20/12/2025", "08:30", "Spa & Grooming", "Mimi (Mèo)", doc1, "Đã xác nhận"));
		list.add(new Appointment("LH002", "22/12/2025", "10:00", "Tiêm Vaccine", "Lu (Chó)", doc2, "Chờ duyệt"));
		list.add(new Appointment("LH003", "25/12/2025", "14:00", "Khám tổng quát", "Mimi (Mèo)", doc3, "Hoàn thành"));

		request.setAttribute("mySchedule", list);
		request.getRequestDispatcher("/mainPages/schedule.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}