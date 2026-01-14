package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Util.UploadConfig;

/**
 * Servlet để serve ảnh từ thư mục upload bên ngoài webapp
 * URL pattern: /uploads/{type}/{filename}
 * Ví dụ: /uploads/shop_pic/product_abc123.jpg
 */
@WebServlet("/uploads/*")
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Cache 7 ngày
    private static final int CACHE_DURATION = 7 * 24 * 60 * 60;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Parse path: /shop_pic/filename.jpg
        String[] parts = pathInfo.substring(1).split("/", 2);
        if (parts.length < 2) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        String type = parts[0];
        String fileName = parts[1];
        
        // Security: chặn path traversal
        if (fileName.contains("..") || fileName.contains("/") || fileName.contains("\\")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        // Xác định thư mục
        String uploadDir;
        switch (type) {
            case "shop_pic":
                uploadDir = UploadConfig.getProductsUploadDir();
                break;
            case "community_pic":
                uploadDir = UploadConfig.getBlogsUploadDir();
                break;
            case "pets_pic":
                uploadDir = UploadConfig.getPetsUploadDir();
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
        }
        
        File file = new File(uploadDir, fileName);
        
        if (!file.exists() || !file.isFile()) {
            // Fallback: thử tìm trong webapp (ảnh cũ)
            String webappPath = getServletContext().getRealPath("/assets/images/" + type + "/" + fileName);
            if (webappPath != null) {
                file = new File(webappPath);
            }
            
            if (!file.exists() || !file.isFile()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
        }
        
        // Set content type
        String contentType = Files.probeContentType(file.toPath());
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        response.setContentType(contentType);
        
        // Set cache headers
        response.setHeader("Cache-Control", "public, max-age=" + CACHE_DURATION);
        response.setDateHeader("Expires", System.currentTimeMillis() + CACHE_DURATION * 1000L);
        
        // Set content length
        response.setContentLengthLong(file.length());
        
        // Stream file
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            
            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }
}
