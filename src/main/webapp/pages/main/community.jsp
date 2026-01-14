<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cộng Đồng Thú Cưng - Animal Doctors</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/favicon/favicon.ico">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Boxicons -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/community.css">
    
    <style>
    /* Color Variables */
    :root {
        --primary: #00bfa5;
        --primary-dark: #008f7a;
        --accent-orange: #ff7043;
        --accent-purple: #7c4dff;
        --accent-pink: #f50057;
        --accent-blue: #2196f3;
        --dark-blue: #1a2e5a;
        --bg-cream: #FFFAF4;
    }
    
    /* Base */
    body { font-family: 'Montserrat', sans-serif; background: var(--bg-cream); margin: 0; }
    img { max-width: 100%; height: auto; }
    
    /* Header Section - Shop Green Colors */
    .community-header {
        background: linear-gradient(135deg, #00bfa5 0%, #005f52 100%);
        padding: 160px 0 100px;
        text-align: center;
        position: relative;
    }
    .community-header::before {
        content: '';
        position: absolute;
        top: 0; left: 0; right: 0; bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="30" r="3" fill="rgba(0,191,165,0.15)"/><circle cx="80" cy="60" r="4" fill="rgba(255,255,255,0.08)"/><circle cx="50" cy="10" r="2" fill="rgba(0,191,165,0.1)"/></svg>');
        background-size: 100px 100px;
    }
    .community-header .sub-heading {
        color: #fff; font-weight: 600; font-size: 0.9rem;
        text-transform: uppercase; letter-spacing: 3px;
        background: rgba(255,255,255,0.2); padding: 8px 20px;
        border-radius: 30px; display: inline-block; margin-bottom: 20px;
        position: relative;
    }
    .community-header h1 { 
        color: #fff; font-size: 3.5rem; font-weight: 700; 
        text-shadow: 2px 2px 20px rgba(0,0,0,0.15); position: relative;
    }
    .community-header p { color: rgba(255,255,255,0.95); font-size: 1.1rem; position: relative; }
    
    /* Blog Section */
    .blog-section { padding: 60px 0; }
    .section-title { 
        color: var(--dark-blue); font-weight: 700; font-size: 1.8rem;
        position: relative; padding-left: 20px;
    }
    .section-title::before {
        content: ''; position: absolute; left: 0; top: 50%;
        transform: translateY(-50%); width: 5px; height: 30px;
        background: linear-gradient(180deg, var(--primary), var(--primary-dark));
        border-radius: 3px;
    }
    
    /* Search Box */
    .search-box {
        display: flex; background: #fff; border-radius: 50px;
        overflow: hidden; box-shadow: 0 5px 25px rgba(0,0,0,0.08);
        max-width: 350px; margin-left: auto;
        border: 2px solid transparent;
        transition: all 0.3s;
    }
    .search-box:focus-within { border-color: var(--primary); box-shadow: 0 5px 30px rgba(0,191,165,0.2); }
    .search-box input { flex: 1; border: none; padding: 15px 25px; font-size: 0.95rem; outline: none; }
    .search-box button {
        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
        border: none; padding: 15px 25px; color: #fff; cursor: pointer;
    }
    .search-box button:hover { background: linear-gradient(135deg, var(--primary-dark), var(--primary)); }
    
    /* Blog Cards - Colorful Categories */
    .blog-card {
        background: #fff; border-radius: 20px; overflow: hidden;
        box-shadow: 0 10px 40px rgba(0,0,0,0.08);
        transition: all 0.3s ease;
        height: 100%; display: flex; flex-direction: column;
    }
    .blog-card:hover { transform: translateY(-10px); box-shadow: 0 20px 50px rgba(0,0,0,0.15); }
    
    .blog-img-box { position: relative; width: 100%; height: 220px; overflow: hidden; }
    .blog-img-box img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
    .blog-card:hover .blog-img-box img { transform: scale(1.1); }
    
    /* Category badges - Project Colors */
    .blog-category {
        position: absolute; top: 15px; left: 15px;
        color: #fff; padding: 6px 16px; border-radius: 20px;
        font-size: 0.75rem; font-weight: 600; text-transform: uppercase;
        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
    }
    
    .blog-content { padding: 25px; flex: 1; display: flex; flex-direction: column; }
    .blog-meta { display: flex; gap: 20px; margin-bottom: 15px; }
    .blog-meta span { color: #999; font-size: 0.85rem; display: flex; align-items: center; gap: 5px; }
    .blog-meta i { color: var(--primary); }
    
    .blog-title { margin-bottom: 12px; }
    .blog-title a {
        color: var(--dark-blue); font-size: 1.15rem; font-weight: 700;
        text-decoration: none; line-height: 1.4; transition: color 0.3s;
        display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
    }
    .blog-title a:hover { color: var(--primary); }
    
    .blog-desc {
        color: #777; font-size: 0.9rem; line-height: 1.6; margin-bottom: 20px; flex: 1;
        display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;
    }
    
    .read-more-link {
        color: var(--primary); font-weight: 600; font-size: 0.9rem;
        text-decoration: none; display: inline-flex; align-items: center; gap: 5px;
        transition: all 0.3s; margin-top: auto;
    }
    .read-more-link:hover { gap: 10px; color: var(--primary-dark); }
    
    /* Pagination - Project Colors */
    .pagination-box { display: flex; justify-content: center; gap: 10px; }
    .pagination-box a {
        width: 45px; height: 45px; display: flex; align-items: center; justify-content: center;
        background: #fff; color: var(--dark-blue); border-radius: 12px;
        text-decoration: none; font-weight: 600;
        box-shadow: 0 3px 15px rgba(0,0,0,0.08); transition: all 0.3s;
    }
    .pagination-box a:hover { background: var(--primary); color: #fff; transform: translateY(-3px); }
    .pagination-box a.active { 
        background: linear-gradient(135deg, var(--primary), var(--primary-dark)); 
        color: #fff; 
    }
    
    /* Responsive */
    @media (max-width: 991px) {
        .community-header h1 { font-size: 2.5rem; }
        .search-box { margin: 20px auto 0; }
    }
    @media (max-width: 767px) {
        .community-header { padding: 140px 0 80px; }
        .community-header h1 { font-size: 2rem; }
        .blog-section { padding: 40px 0; }
        .section-title { text-align: center; margin-bottom: 20px; padding-left: 0; }
        .section-title::before { display: none; }
    }
    </style>
</head>
<body>

    <jsp:include page="/components/navbar.jsp" />

    <!-- Header Section -->
    <section class="community-header">
        <div class="container">
            <span class="sub-heading">Blog & Tin Tức</span>
            <h1>Cộng Đồng Yêu Thú Cưng</h1>
            <p>Chia sẻ kiến thức, kinh nghiệm và những câu chuyện cảm động</p>
        </div>
    </section>

    <!-- Blog Section -->
    <section class="blog-section container">
        
        <!-- Search & Title -->
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

        <!-- Blog Cards -->
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
            
            <!-- Sample posts if no data -->
            <c:if test="${empty postList}">
                <div class="col-md-6 col-lg-4">
                    <div class="blog-card">
                        <div class="blog-img-box">
                            <img src="${pageContext.request.contextPath}/assets/images/homepage_pic/webpic3.jpg" alt="Blog">
                            <span class="blog-category">Sức khỏe</span>
                        </div>
                        <div class="blog-content">
                            <div class="blog-meta">
                                <span><i class='bx bx-calendar'></i> 15/01/2026</span>
                                <span><i class='bx bx-user'></i> Admin</span>
                            </div>
                            <h4 class="blog-title">
                                <a href="#">Cách chăm sóc thú cưng trong mùa đông</a>
                            </h4>
                            <p class="blog-desc">Mùa đông đến, thú cưng của bạn cần được chăm sóc đặc biệt hơn. Hãy cùng tìm hiểu những tips hữu ích...</p>
                            <a href="#" class="read-more-link">
                                Đọc tiếp <i class='bx bx-right-arrow-alt'></i>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-4">
                    <div class="blog-card">
                        <div class="blog-img-box">
                            <img src="${pageContext.request.contextPath}/assets/images/homepage_pic/webpic4.jpg" alt="Blog">
                            <span class="blog-category">Dinh dưỡng</span>
                        </div>
                        <div class="blog-content">
                            <div class="blog-meta">
                                <span><i class='bx bx-calendar'></i> 12/01/2026</span>
                                <span><i class='bx bx-user'></i> BS. An</span>
                            </div>
                            <h4 class="blog-title">
                                <a href="#">Chế độ dinh dưỡng cho mèo con</a>
                            </h4>
                            <p class="blog-desc">Mèo con cần chế độ dinh dưỡng đặc biệt để phát triển khỏe mạnh. Bài viết này sẽ hướng dẫn bạn...</p>
                            <a href="#" class="read-more-link">
                                Đọc tiếp <i class='bx bx-right-arrow-alt'></i>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-4">
                    <div class="blog-card">
                        <div class="blog-img-box">
                            <img src="${pageContext.request.contextPath}/assets/images/homepage_pic/webpic5.jpg" alt="Blog">
                            <span class="blog-category">Vaccine</span>
                        </div>
                        <div class="blog-content">
                            <div class="blog-meta">
                                <span><i class='bx bx-calendar'></i> 10/01/2026</span>
                                <span><i class='bx bx-user'></i> BS. Bình</span>
                            </div>
                            <h4 class="blog-title">
                                <a href="#">Lịch tiêm phòng cho chó con</a>
                            </h4>
                            <p class="blog-desc">Tiêm phòng đúng lịch giúp bảo vệ chó con khỏi các bệnh nguy hiểm. Xem ngay lịch tiêm phòng chuẩn...</p>
                            <a href="#" class="read-more-link">
                                Đọc tiếp <i class='bx bx-right-arrow-alt'></i>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-4">
                    <div class="blog-card">
                        <div class="blog-img-box">
                            <img src="${pageContext.request.contextPath}/assets/images/homepage_pic/webpic6.jpg" alt="Blog">
                            <span class="blog-category">Làm đẹp</span>
                        </div>
                        <div class="blog-content">
                            <div class="blog-meta">
                                <span><i class='bx bx-calendar'></i> 08/01/2026</span>
                                <span><i class='bx bx-user'></i> Admin</span>
                            </div>
                            <h4 class="blog-title">
                                <a href="#">Grooming tại nhà cho thú cưng</a>
                            </h4>
                            <p class="blog-desc">Hướng dẫn chi tiết cách tắm và chải lông cho thú cưng tại nhà một cách an toàn và hiệu quả...</p>
                            <a href="#" class="read-more-link">
                                Đọc tiếp <i class='bx bx-right-arrow-alt'></i>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-4">
                    <div class="blog-card">
                        <div class="blog-img-box">
                            <img src="${pageContext.request.contextPath}/assets/images/homepage_pic/webpic7.jpg" alt="Blog">
                            <span class="blog-category">Mẹo hay</span>
                        </div>
                        <div class="blog-content">
                            <div class="blog-meta">
                                <span><i class='bx bx-calendar'></i> 05/01/2026</span>
                                <span><i class='bx bx-user'></i> BS. Châu</span>
                            </div>
                            <h4 class="blog-title">
                                <a href="#">Dấu hiệu thú cưng bị stress</a>
                            </h4>
                            <p class="blog-desc">Thú cưng cũng có thể bị stress như con người. Nhận biết sớm các dấu hiệu để giúp bé vượt qua...</p>
                            <a href="#" class="read-more-link">
                                Đọc tiếp <i class='bx bx-right-arrow-alt'></i>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-4">
                    <div class="blog-card">
                        <div class="blog-img-box">
                            <img src="${pageContext.request.contextPath}/assets/images/homepage_pic/webpic8.jpg" alt="Blog">
                            <span class="blog-category">Tin tức</span>
                        </div>
                        <div class="blog-content">
                            <div class="blog-meta">
                                <span><i class='bx bx-calendar'></i> 01/01/2026</span>
                                <span><i class='bx bx-user'></i> Admin</span>
                            </div>
                            <h4 class="blog-title">
                                <a href="#">Animal Doctors khai trương chi nhánh mới</a>
                            </h4>
                            <p class="blog-desc">Chào đón năm mới 2026, Animal Doctors chính thức khai trương chi nhánh thứ 5 tại Quận 7...</p>
                            <a href="#" class="read-more-link">
                                Đọc tiếp <i class='bx bx-right-arrow-alt'></i>
                            </a>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
        
        <!-- Pagination -->
        <div class="row mt-5">
            <div class="col-12">
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
    <jsp:include page="/components/back-button.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
