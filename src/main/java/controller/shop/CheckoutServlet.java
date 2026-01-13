package controller.shop;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // 1. Lấy thông tin từ form (để sau này lưu vào DB)
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String note = request.getParameter("note");
        
        // (Ở đây bạn sẽ gọi DAO để lưu đơn hàng vào Database)
        // OrderDAO.saveOrder(fullname, phone, address, ...);
        
        // 2. Xử lý Session
        HttpSession session = request.getSession();
        
        // Xóa sạch giỏ hàng sau khi đặt thành công
        session.removeAttribute("cart");
        session.removeAttribute("totalQuantity");
        
        // 3. Gửi thông báo thành công (Toast)
        session.setAttribute("toastMessage", "🎉 Đặt hàng thành công! Cảm ơn bạn đã ủng hộ.");
        session.setAttribute("toastType", "success");
        
        // 4. Chuyển hướng về trang chủ
        response.sendRedirect(request.getContextPath() + "/home");
    }
}