package controller.shop;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import DAO.ProductDAO;
import Model.CartItem;
import Model.Product;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        int productId = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        
        if (cart == null) cart = new HashMap<>();

        ProductDAO dao = new ProductDAO();
        Product product = dao.getProductById(productId); 
        
        if (product != null) {
            if (cart.containsKey(productId)) {
                CartItem existingItem = cart.get(productId);
                existingItem.setQuantity(existingItem.getQuantity() + quantity);
            } else {
                cart.put(productId, new CartItem(product, quantity));
            }
            
            session.setAttribute("cart", cart);
            
            int totalQuantity = 0;
            for (CartItem item : cart.values()) {
                totalQuantity += item.getQuantity();
            }
            session.setAttribute("totalQuantity", totalQuantity);

            session.setAttribute("toastMessage", "Đã thêm <b>" + product.getName() + "</b> vào giỏ hàng!");
            session.setAttribute("toastType", "success");
        } else {
            session.setAttribute("toastMessage", "Sản phẩm không tồn tại!");
            session.setAttribute("toastType", "error");
        }
        
        // Xử lý điều hướng
        String action = request.getParameter("actionType");
        
        if ("buy".equals(action)) {
            response.sendRedirect(request.getContextPath() + "/shopping/cart.jsp");
        } else {
            String referer = request.getHeader("referer");
            response.sendRedirect(referer);
        }
    }
}