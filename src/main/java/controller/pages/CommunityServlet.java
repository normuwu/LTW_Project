package controller.pages;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.BlogDAO;
import Model.BlogPost;

@WebServlet("/community")
public class CommunityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Gọi DAO để lấy dữ liệu từ Database
        BlogDAO dao = new BlogDAO();
        List<BlogPost> postList = dao.getAllBlogs();
        
        // 2. Gửi danh sách sang JSP
        request.setAttribute("postList", postList);
        
        // 3. Chuyển hướng
        request.getRequestDispatcher("/pages/main/community.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

