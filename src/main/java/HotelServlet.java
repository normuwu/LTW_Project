

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 👇 Dòng này QUAN TRỌNG NHẤT: Nó định nghĩa đường dẫn trùng với link bên services.jsp
@WebServlet("/hotel") 
public class HotelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public HotelServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Khi ai đó vào /cat-hotel, Servlet này sẽ mở file cat_hotel.jsp lên
		// Lưu ý: Tên file trong ngoặc kép phải đúng y hệt tên file JSP bạn đã tạo
		request.getRequestDispatcher("hotel.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}