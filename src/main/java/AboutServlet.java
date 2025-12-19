
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.CareItem;
import Model.Doctor;
import Model.Feature;

@WebServlet("/about")
public class AboutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. Dữ liệu Features (3 mục)
		List<Feature> features = new ArrayList<>();
		features.add(new Feature("bx bxs-graduation", "Đội ngũ chuyên gia quốc tế",
				"Các bác sĩ được đào tạo bài bản từ các trường đại học danh tiếng."));
		features.add(new Feature("bx bxs-heart", "Chăm sóc bằng cả trái tim",
				"Chúng tôi đối xử với thú cưng của bạn như chính thú cưng của mình."));
		features.add(new Feature("bx bxs-first-aid", "Trang thiết bị tối tân",
				"Hệ thống máy móc chẩn đoán hình ảnh và xét nghiệm hiện đại nhất."));

		// 2. Dữ liệu Bác Sĩ (4 người)
		List<Doctor> doctors = new ArrayList<>();
		doctors.add(new Doctor("Bác sĩ Ngọc Thành", "webpic14.jpg"));
		doctors.add(new Doctor("Bác sĩ Huyền Trang", "webpic15.jpg"));
		doctors.add(new Doctor("Bác sĩ Sterenn Genewe", "webpic16.jpg"));
		doctors.add(new Doctor("Bác sĩ Mai Phạm", "webpic17.jpg"));

		// 3. Dữ liệu Chăm sóc (7 Tabs)
		
		List<CareItem> careItems = new ArrayList<>();
		careItems.add(new CareItem("Đồng hành cùng với bạn",
				"<p>Thú cưng của bạn không thể cho chúng ta biết bất cứ điều gì về cuộc sống hoặc các triệu chứng của các bé."
				+ " Đó là lý do tại sao dịch vụ chăm sóc thú cưng của ADI bắt đầu bằng việc xây dựng mối quan hệ chặt chẽ giữa bác sĩ thú y và những người chủ</p>"
				+ "<p>Vì vậy, ưu tiên hàng đầu của chúng tôi là lắng nghe những người chủ vật nuôi và hợp tác chặt chẽ để cùng nhau mang đến cho những người bạn đồng hành thân yêu của mình một cuộc sống hạnh phúc và khỏe mạnh hơn.</p>"));
		
		
		
		careItems.add(new CareItem("Trung thực và minh bạch",
				"<p>Là cha mẹ của các bé, bạn hoàn toàn có quyền minh bạch về mọi thứ liên quan đến chăm sóc y tế cho thú cưng của bạn. Đó là lý do tại sao ADI muốn bạn tham gia vào mọi quyết định liên quan đến việc điều trị cho thú cưng của bạn.</p>"));
		
		
		
		careItems.add(new CareItem("Nguyên tắc tảng băng trôi",
				"<p>Phần lớn những gì đặc trưng cho các tiêu chuẩn chăm sóc cao của chúng tôi diễn ra ở hậu trường và do đó khách hàng của chúng tôi không nhìn thấy được.</p>"));
		
		
		
		careItems.add(new CareItem("Mục Tiêu", "<p>Mọi thứ chúng tôi đề xuất cho thú cưng của bạn là kết quả của quá trình nghiên cứu,"
				+ " cống hiến và chuyên môn tuyệt vời để đảm bảo rằng mọi phương pháp điều trị đều mang lại lợi ích tốt nhất cho thú cưng của bạn.</p>"));
		
		
		
		careItems.add(
				new CareItem("Kỹ thuật xuất sắc", "<p>Thú y không chỉ là công việc kinh doanh của chúng tôi. Sức khỏe và phúc lợi động vật là sứ mệnh và niềm đam mê của Animal Doctors International. Thú cưng của bạn là ưu tiên hàng đầu của chúng tôi tại đây.Thú y không chỉ là công việc kinh doanh của chúng tôi. Sức khỏe và phúc lợi động vật là sứ mệnh và niềm đam mê của Animal Doctors International."
						+ " Thú cưng của bạn là ưu tiên hàng đầu của chúng tôi tại đây.</p>"
						+ "<p>Chúng tôi cam kết với đội ngũ bác sĩ thú y có trình độ chuyên môn cao, đội ngũ nhân viên hỗ trợ chuyên nghiệp sẽ giúp cho thú cưng của bạn có được một sức khoẻ tốt nhất.</p>"
						));
		
		
		
		careItems.add(new CareItem("Cách tiếp cận phù hợp",
				"<p>Tại ADI, chúng tôi nhận ra rằng mỗi thú cưng đều có nhu cầu, thói quen và lối sống riêng. Vì vậy, mọi thứ chúng tôi làm cho thú cưng của bạn đều phù hợp với nhu cầu cá nhân của chúng.</p>"));
		
		
		
		careItems.add(new CareItem("Công tác đào tạo",
				"<p>Chúng tôi đầu tư vào việc liên tục đào tạo cho các bác sĩ thú y của mình để giúp họ theo kịp những phát triển mới nhất trong ngành thú y."
				+ " Việc cập nhật liên tục giữ cho kiến ​​thức và kỹ năng của bác sĩ thú y của chúng tôi ở đẳng cấp thế giới.</p>"
						+ "<p>Một phòng khám thú ý tốt không chỉ riêng bác sĩ thú y giỏi mà còn nhờ có một đội ngũ xuất sắc phía sau. Nhân viên hỗ trợ của chúng tôi được đào tạo chuyên sâu để liên tục duy trì mức độ xuất sắc.</p>"));

		// Gửi dữ liệu sang JSP
		request.setAttribute("features", features);
		request.setAttribute("doctors", doctors);
		request.setAttribute("careItems", careItems);

		request.getRequestDispatcher("about.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}