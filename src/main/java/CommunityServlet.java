import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Import class từ package Model
import Model.BlogPost;

@WebServlet("/community") // Đường dẫn truy cập
public class CommunityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. Tạo danh sách bài viết
		List<BlogPost> postList = new ArrayList<>();
		
		// Bài 1
		postList.add(new BlogPost(
			"5 Dấu hiệu nhận biết mèo đang bị stress", 
			"blog1.jpg", 
			"Tâm lý thú cưng", 
			"19/12/2025", 
			"Bs. Ngọc Thành",
			"Mèo là loài động vật nhạy cảm. Thay đổi môi trường sống hoặc tiếng ồn lớn có thể khiến chúng bị stress nặng. Hãy cùng tìm hiểu các dấu hiệu..."
		));

		// Bài 2
		postList.add(new BlogPost(
			"Lịch tiêm phòng đầy đủ cho cún con từ A-Z", 
			"blog2.jpg", 
			"Sức khỏe", 
			"18/12/2025", 
			"Bs. Huyền Trang",
			"Tiêm vaccine là cách tốt nhất để bảo vệ cún cưng khỏi các bệnh nguy hiểm như Care, Parvo. Đừng bỏ lỡ các mốc thời gian vàng này nhé."
		));

		// Bài 3
		postList.add(new BlogPost(
			"Review các loại cát vệ sinh tốt nhất hiện nay", 
			"blog3.jpg", 
			"Review Sản phẩm", 
			"15/12/2025", 
			"Admin",
			"Cát đất sét, cát gỗ hay cát đậu nành? Loại nào khử mùi tốt nhất và tiết kiệm nhất? Bài viết này sẽ giúp bạn chọn được loại cát chân ái."
		));

		// Bài 4
		postList.add(new BlogPost(
			"Câu chuyện cảm động về chú chó Hachiko", 
			"blog4.jpg", 
			"Chuyện bên lề", 
			"10/12/2025", 
			"Sưu tầm",
			"Lòng trung thành của loài chó luôn là điều khiến con người rơi nước mắt. Cùng đọc lại câu chuyện kinh điển về Hachiko đợi chủ."
		));

		// Bài 5
		postList.add(new BlogPost(
			"Chế độ dinh dưỡng cho mèo bị sỏi thận", 
			"blog5.jpg", 
			"Dinh dưỡng", 
			"05/12/2025", 
			"Bs. Mai Phạm",
			"Mèo bị sỏi thận cần kiêng ăn gì? Tại sao nên cho ăn nhiều thức ăn ướt hơn hạt khô? Lời khuyên từ chuyên gia dinh dưỡng."
		));

		// 2. Gửi danh sách sang JSP
		request.setAttribute("postList", postList);
		
		// 3. Chuyển hướng
		request.getRequestDispatcher("community.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}