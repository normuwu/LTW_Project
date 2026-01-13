<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Siêu Thị Thú Cưng - Animal Doctors</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/shop.css">
    
</head>
<body>

    <jsp:include page="/components/navbar.jsp" />

    <section class="shop-header">
        <div class="container">
            <h1>Siêu Thị Thú Cưng</h1>
            <p>Dinh dưỡng & Phụ kiện tốt nhất cho Boss của bạn</p>
        </div>
    </section>

    <section class="category-section container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4 text-white">
            <h3>Bộ Sưu Tập Cho Mèo Con</h3>
            <a href="#" class="text-white text-decoration-none">Xem Tất Cả <i class='bx bx-right-arrow-alt'></i></a>
        </div>

        <div class="row text-center g-4">
            <div class="col-6 col-md-2">
                <div class="cat-circle">
                    <img src="${pageContext.request.contextPath}/assets/images/shop_pic/cate_pate.jpg" alt="Pate">
                </div>
                <p class="cat-name">Pate Mèo Con</p>
            </div>
            <div class="col-6 col-md-2">
                <div class="cat-circle">
                    <img src="${pageContext.request.contextPath}/assets/images/shop_pic/cate_food.jpg" alt="Food">
                </div>
                <p class="cat-name">Thức Ăn Hạt</p>
            </div>
            <div class="col-6 col-md-2">
                <div class="cat-circle">
                    <img src="${pageContext.request.contextPath}/assets/images/shop_pic/cate_sand.jpg" alt="Sand">
                </div>
                <p class="cat-name">Cát Vệ Sinh</p>
            </div>
            <div class="col-6 col-md-2">
                <div class="cat-circle">
                    <img src="${pageContext.request.contextPath}/assets/images/shop_pic/cate_shampoo.jpg" alt="Shampoo">
                </div>
                <p class="cat-name">Sữa Tắm</p>
            </div>
            <div class="col-6 col-md-2">
                <div class="cat-circle">
                    <img src="${pageContext.request.contextPath}/assets/images/shop_pic/cate_toy.jpg" alt="Toy">
                </div>
                <p class="cat-name">Đồ Chơi</p>
            </div>
            <div class="col-6 col-md-2">
                <div class="cat-circle">
                    <img src="${pageContext.request.contextPath}/assets/images/shop_pic/cate_house.jpg" alt="House">
                </div>
                <p class="cat-name">Nhà Cho Mèo</p>
            </div>
        </div>
    </section>

    <section class="product-section container mt-5 mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4 text-white">
            <h3>Được Boss Yêu Thích</h3>
            <a href="#" class="text-white text-decoration-none">Xem tất cả <i class='bx bx-right-arrow-alt'></i></a>
        </div>

        <div class="row g-4">
            
            <c:forEach items="${products}" var="p">
                <div class="col-6 col-md-3">
                    <div class="product-card">
                        
                        <c:if test="${p.discount > 0}">
                            <div class="badge-discount">-${p.discount}%</div>
                        </c:if>

                        <img src="${pageContext.request.contextPath}/assets/images/shop_pic/${p.image}" class="product-img" alt="${p.name}">
                        
                        <div class="product-info">
                            <span class="brand">Royal Canin</span>
                            <h5 class="product-title">${p.name}</h5>
                            
                            <div class="price-box">
                                <c:if test="${p.oldPrice > 0}">
                                    <span class="old-price">${p.formattedOldPrice}</span>
                                </c:if>
                                <span class="new-price">${p.formattedPrice}</span>
                            </div>
                            
                            <button class="btn-add-cart"><i class='bx bxs-cart-add'></i> Thêm</button>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty products}">
                <div class="col-12 text-center text-white">
                    <p>Đang cập nhật sản phẩm...</p>
                </div>
            </c:if>

        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />
    <jsp:include page="/components/back-button.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

