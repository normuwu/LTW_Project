<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cộng Đồng Thú Cưng - Animal Doctors</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/community.css">
    
</head>
<body>

    <jsp:include page="/components/navbar.jsp" />

    <section class="community-header">
        <div class="container">
            <span class="sub-heading">Blog & Tin Tức</span>
            <h1>Cộng Đồng Yêu Thú Cưng</h1>
            <p>Chia sẻ kiến thức, kinh nghiệm và những câu chuyện cảm động</p>
        </div>
    </section>

    <section class="blog-section container mt-5 mb-5">
        
        <div class="row mb-4 align-items-center">
            <div class="col-md-6">
                <h3 class="section-title">Bài Viết Mới Nhất</h3>
            </div>
            <div class="col-md-6">
                <div class="search-box">
                    <input type="text" placeholder="Tìm kiếm bài viết...">
                    <button><i class='bx bx-search'></i></button>
                </div>
            </div>
        </div>

        <div class="row g-4">
            
            <c:forEach items="${postList}" var="p">
                <div class="col-md-6 col-lg-4">
                    <div class="blog-card">
                        <div class="blog-img-box">
                            <img src="${pageContext.request.contextPath}/assets/images/community_pic/${p.image}" alt="${p.title}">
                            <span class="blog-category">${p.category}</span>
                        </div>
                        
                        <div class="blog-content">
                            <div class="blog-meta">
                                <span><i class='bx bx-calendar'></i> ${p.date}</span>
                                <span><i class='bx bx-user'></i> ${p.author}</span>
                            </div>
                            
                            <h4 class="blog-title">
                                <a href="#">${p.title}</a>
                            </h4>
                            
                            <p class="blog-desc">${p.summary}</p>
                            
                            <a href="#" class="read-more-link">
                                Đọc tiếp <i class='bx bx-right-arrow-alt'></i>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty postList}">
                <div class="col-12 text-center text-white">
                    <div class="alert alert-info" style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.3); color: #fff;">
                        <h4>Chưa có bài viết nào!</h4>
                        
                    </div>
                </div>
            </c:if>

        </div>
        
        <div class="row mt-5">
            <div class="col-12 text-center">
                <div class="pagination-box">
                    <a href="#" class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#"><i class='bx bx-chevron-right'></i></a>
                </div>
            </div>
        </div>

    </section>

    <jsp:include page="/components/footer.jsp" />

</body>
</html>

