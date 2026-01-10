package controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import DAO.ProductDAO;
import Model.Product;
import Util.FormHelper;
import Util.ValidationUtil;

@WebServlet("/pages/admin/products")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();
        List<Product> products = dao.getAllProducts();
        int totalProducts = dao.getTotalProducts();
        int discountedProducts = dao.getDiscountedProducts();
        
        request.setAttribute("products", products);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("discountedProducts", discountedProducts);
        
        request.getRequestDispatcher("/pages/admin/products.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        
        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();
        
        String message;
        String messageType = "success";
        
        if ("add".equals(action) || "edit".equals(action)) {
            FormHelper form = new FormHelper(request);
            
            String name = form.get("name");
            String image = form.get("image");
            String priceStr = form.get("price");
            String oldPriceStr = form.get("oldPrice");
            String discountStr = form.get("discount");
            
            // === VALIDATION ===
            boolean valid = true;
            
            if (!form.validateRequired("name", "Tên sản phẩm")) {
                valid = false;
            } else if (!form.validateLength("name", "Tên sản phẩm", 2, 200)) {
                valid = false;
            }
            
            if (!form.validatePositiveNumber("price", "Giá bán")) {
                valid = false;
            }
            
            if (ValidationUtil.isNotEmpty(oldPriceStr) && !ValidationUtil.isNonNegativeNumber(oldPriceStr)) {
                form.addError("oldPrice", "Giá gốc không hợp lệ");
                valid = false;
            }
            
            if (ValidationUtil.isNotEmpty(discountStr) && !form.validateDiscount("discount")) {
                valid = false;
            }
            
            if (!valid) {
                // Lấy lỗi đầu tiên làm message
                message = form.getErrorsMap().values().iterator().next();
                messageType = "error";
                session.setAttribute("message", message);
                session.setAttribute("messageType", messageType);
                response.sendRedirect(request.getContextPath() + "/pages/admin/products");
                return;
            }
            
            // Parse values
            double price = ValidationUtil.parseDoubleOrDefault(priceStr, 0);
            double oldPrice = ValidationUtil.parseDoubleOrDefault(oldPriceStr, 0);
            int discount = ValidationUtil.parseIntOrDefault(discountStr, 0);
            
            // === BUSINESS LOGIC ===
            if ("add".equals(action)) {
                if (dao.addProduct(name, image, price, oldPrice, discount)) {
                    message = "Thêm sản phẩm thành công!";
                } else {
                    message = "Có lỗi xảy ra khi thêm sản phẩm!";
                    messageType = "error";
                }
            } else {
                String idStr = request.getParameter("id");
                Integer id = ValidationUtil.parseIntOrNull(idStr);
                
                if (id == null) {
                    message = "ID sản phẩm không hợp lệ!";
                    messageType = "error";
                } else if (dao.updateProduct(id, name, image, price, oldPrice, discount)) {
                    message = "Cập nhật sản phẩm thành công!";
                } else {
                    message = "Có lỗi xảy ra khi cập nhật!";
                    messageType = "error";
                }
            }
        } else if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            Integer id = ValidationUtil.parseIntOrNull(idStr);
            
            if (id == null) {
                message = "ID sản phẩm không hợp lệ!";
                messageType = "error";
            } else if (dao.deleteProduct(id)) {
                message = "Xóa sản phẩm thành công!";
            } else {
                message = "Có lỗi xảy ra khi xóa!";
                messageType = "error";
            }
        } else {
            message = "Hành động không hợp lệ!";
            messageType = "error";
        }
        
        session.setAttribute("message", message);
        session.setAttribute("messageType", messageType);
        response.sendRedirect(request.getContextPath() + "/pages/admin/products");
    }
}

