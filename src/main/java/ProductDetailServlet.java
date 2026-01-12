

import DAO.ProductDAO;
import DAO.ReviewDAO;
import Model.Product;
import Model.Review;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Đường dẫn URL để truy cập
@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. Lấy ID từ URL (VD: product-detail?id=5)
            String idRaw = request.getParameter("id");
            
            
            if (idRaw == null || idRaw.isEmpty()) {
                response.sendRedirect("shop");
                return;
            }

            int id = Integer.parseInt(idRaw);
            
            // 2. Gọi DAO lấy thông tin sản phẩm
            ProductDAO pDao = new ProductDAO();
            Product p = pDao.getProductById(id);
            
            
            if (p == null) {
                response.sendRedirect("shop");
                return;
            }

            // 3. Gọi DAO lấy danh sách đánh giá (Reviews)
            ReviewDAO rDao = new ReviewDAO();
            List<Review> listReviews = rDao.getReviewsByProductId(id);
            
            // 4. Đẩy dữ liệu sang JSP
            request.setAttribute("detail", p);
            request.setAttribute("listReviews", listReviews);
            

            // === THÊM ĐOẠN NÀY ĐỂ HIỆN SẢN PHẨM LIÊN QUAN ===
            // Lấy 4 sản phẩm khác để hiển thị
            List<Product> listRelated = pDao.getRelatedProducts(id); 
            request.setAttribute("relatedProducts", listRelated);
  
            
            // 5. Chuyển hướng đến file JSP giao diện

            request.getRequestDispatcher("/shopping/product.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("shop");
        }
    }
}