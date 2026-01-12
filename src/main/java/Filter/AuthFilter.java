package Filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        
        // Các trang/resource không cần đăng nhập
        boolean isPublicResource = uri.endsWith("/login") || 
                               uri.endsWith("/register") || 
                               uri.endsWith("/home") ||
                               uri.endsWith("/about") ||
                               uri.endsWith("/services") ||
                               uri.endsWith("/community") ||
                               uri.endsWith("/shop") ||
                               uri.endsWith("/vaccine") ||
                               uri.endsWith("/spa") ||
                               uri.endsWith("/surgery") ||
                               uri.endsWith("/medical") ||
                               uri.endsWith("/hotel") ||
                               uri.contains("/css/") ||
                               uri.contains("/js/") ||
                               uri.contains("_pic/") ||
                               uri.contains("/video/") ||
                               uri.contains("/header_footer/") ||
                               uri.contains("/components/") ||
                               uri.contains("/auth/") ||
                               uri.contains("/Services/") ||
                               uri.endsWith(".css") ||
                               uri.endsWith(".js") ||
                               uri.endsWith(".jpg") ||
                               uri.endsWith(".png") ||
                               uri.endsWith(".gif") ||
                               uri.endsWith(".ico");
        
        // Các trang chỉ admin mới vào được
        boolean isAdminPage = uri.contains("/admin/");
        
        // Kiểm tra đăng nhập
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        
        if (isPublicResource) {
            // Cho phép truy cập trang/resource public
            chain.doFilter(request, response);
        } else if (isAdminPage) {
            // Kiểm tra quyền admin
            if (isLoggedIn && "admin".equals(role)) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(contextPath + "/login");
            }
        } else {
            // Các trang khác cần đăng nhập
            if (isLoggedIn) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(contextPath + "/login");
            }
        }
    }

    public void destroy() {
    }
}
