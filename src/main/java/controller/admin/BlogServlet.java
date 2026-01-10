package controller.admin;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import DAO.BlogDAO;
import Model.BlogPost;
import Util.FormHelper;
import Util.ValidationUtil;

@WebServlet("/pages/admin/blogs")
public class BlogServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private BlogDAO blogDAO = new BlogDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<BlogPost> blogs = blogDAO.getAllBlogs();
        request.setAttribute("blogs", blogs);
        request.setAttribute("totalBlogs", blogDAO.countAll());
        request.setAttribute("categories", blogDAO.getAllCategories());
        
        request.getRequestDispatcher("/pages/admin/blogs.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        
        String action = request.getParameter("action");
        String message;
        String messageType = "success";

        if ("add".equals(action) || "edit".equals(action)) {
            FormHelper form = new FormHelper(request);
            
            String title = form.get("title");
            String image = form.get("image");
            String category = form.get("category");
            String author = form.get("author");
            String summary = form.get("summary");
            
            // === VALIDATION ===
            boolean valid = true;
            
            if (!form.validateRequired("title", "Tiêu đề")) {
                valid = false;
            } else if (!form.validateLength("title", "Tiêu đề", 5, 300)) {
                valid = false;
            }
            
            if (!form.validateRequired("category", "Danh mục")) {
                valid = false;
            }
            
            if (!form.validateRequired("author", "Tác giả")) {
                valid = false;
            } else if (!form.validateLength("author", "Tên tác giả", 2, 100)) {
                valid = false;
            }
            
            if (!form.validateRequired("summary", "Tóm tắt")) {
                valid = false;
            } else if (!form.validateLength("summary", "Tóm tắt", 10, 1000)) {
                valid = false;
            }
            
            if (!valid) {
                message = form.getErrorsMap().values().iterator().next();
                messageType = "error";
                session.setAttribute("message", message);
                session.setAttribute("messageType", messageType);
                response.sendRedirect(request.getContextPath() + "/pages/admin/blogs");
                return;
            }
            
            // === BUSINESS LOGIC ===
            if ("add".equals(action)) {
                String date = new SimpleDateFormat("dd/MM/yyyy").format(new Date());
                
                if (blogDAO.insertBlog(title, image, category, date, author, summary)) {
                    message = "Đã thêm bài viết thành công!";
                } else {
                    message = "Có lỗi xảy ra khi thêm bài viết!";
                    messageType = "error";
                }
            } else {
                String idStr = request.getParameter("id");
                String date = request.getParameter("date");
                Integer id = ValidationUtil.parseIntOrNull(idStr);
                
                if (id == null) {
                    message = "ID bài viết không hợp lệ!";
                    messageType = "error";
                } else if (blogDAO.updateBlog(id, title, image, category, date, author, summary)) {
                    message = "Đã cập nhật bài viết thành công!";
                } else {
                    message = "Có lỗi xảy ra khi cập nhật!";
                    messageType = "error";
                }
            }
        } else if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            Integer id = ValidationUtil.parseIntOrNull(idStr);
            
            if (id == null) {
                message = "ID bài viết không hợp lệ!";
                messageType = "error";
            } else if (blogDAO.deleteBlog(id)) {
                message = "Đã xóa bài viết thành công!";
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
        response.sendRedirect(request.getContextPath() + "/pages/admin/blogs");
    }
}

