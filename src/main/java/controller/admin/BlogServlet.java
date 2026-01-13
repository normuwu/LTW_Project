package controller.admin;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import DAO.BlogDAO;
import Model.BlogPost;
import Util.ValidationUtil;

@WebServlet("/pages/admin/blogs")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB
    maxFileSize = 1024 * 1024 * 10,       // 10 MB
    maxRequestSize = 1024 * 1024 * 50     // 50 MB
)
public class BlogServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private BlogDAO blogDAO = new BlogDAO();
    private static final String UPLOAD_DIR = "assets/images/community_pic";
    
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
            String title = request.getParameter("title");
            String category = request.getParameter("category");
            String author = request.getParameter("author");
            String summary = request.getParameter("summary");
            String existingImage = request.getParameter("existingImage");
            
            // === VALIDATION ===
            boolean valid = true;
            StringBuilder errors = new StringBuilder();
            
            if (title == null || title.trim().isEmpty()) {
                valid = false;
                errors.append("Tiêu đề không được để trống. ");
            } else if (title.length() < 5 || title.length() > 300) {
                valid = false;
                errors.append("Tiêu đề phải từ 5-300 ký tự. ");
            }
            
            if (category == null || category.trim().isEmpty()) {
                valid = false;
                errors.append("Danh mục không được để trống. ");
            }
            
            if (author == null || author.trim().isEmpty()) {
                valid = false;
                errors.append("Tác giả không được để trống. ");
            } else if (author.length() < 2 || author.length() > 100) {
                valid = false;
                errors.append("Tên tác giả phải từ 2-100 ký tự. ");
            }
            
            if (summary == null || summary.trim().isEmpty()) {
                valid = false;
                errors.append("Tóm tắt không được để trống. ");
            } else if (summary.length() < 10 || summary.length() > 1000) {
                valid = false;
                errors.append("Tóm tắt phải từ 10-1000 ký tự. ");
            }
            
            if (!valid) {
                message = errors.toString().trim();
                messageType = "error";
                session.setAttribute("message", message);
                session.setAttribute("messageType", messageType);
                response.sendRedirect(request.getContextPath() + "/pages/admin/blogs");
                return;
            }
            
            // === HANDLE FILE UPLOAD ===
            String imageName = existingImage; // Giữ ảnh cũ nếu không upload mới
            
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getSubmittedFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    // Validate file type
                    String contentType = filePart.getContentType();
                    if (!isValidImageType(contentType)) {
                        message = "Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WebP)!";
                        messageType = "error";
                        session.setAttribute("message", message);
                        session.setAttribute("messageType", messageType);
                        response.sendRedirect(request.getContextPath() + "/pages/admin/blogs");
                        return;
                    }
                    
                    // Generate unique filename
                    String extension = getFileExtension(fileName);
                    imageName = UUID.randomUUID().toString().substring(0, 8) + "_" + System.currentTimeMillis() + extension;
                    
                    // Save file
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    
                    String filePath = uploadPath + File.separator + imageName;
                    filePart.write(filePath);
                }
            }
            
            // === BUSINESS LOGIC ===
            if ("add".equals(action)) {
                String date = new SimpleDateFormat("dd/MM/yyyy").format(new Date());
                
                if (blogDAO.insertBlog(title, imageName, category, date, author, summary)) {
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
                } else if (blogDAO.updateBlog(id, title, imageName, category, date, author, summary)) {
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
    
    // Lấy tên file từ Part
    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp != null) {
            for (String token : contentDisp.split(";")) {
                if (token.trim().startsWith("filename")) {
                    String fileName = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                    // Handle IE which sends full path
                    int index = fileName.lastIndexOf(File.separator);
                    if (index >= 0) {
                        fileName = fileName.substring(index + 1);
                    }
                    return fileName;
                }
            }
        }
        return null;
    }
    
    // Kiểm tra loại file ảnh hợp lệ
    private boolean isValidImageType(String contentType) {
        return contentType != null && (
            contentType.equals("image/jpeg") ||
            contentType.equals("image/png") ||
            contentType.equals("image/gif") ||
            contentType.equals("image/webp")
        );
    }
    
    // Lấy extension của file
    private String getFileExtension(String fileName) {
        int lastDot = fileName.lastIndexOf('.');
        if (lastDot > 0) {
            return fileName.substring(lastDot).toLowerCase();
        }
        return ".jpg";
    }
}
