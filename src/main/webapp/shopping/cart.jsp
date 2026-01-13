<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="totalAmount" value="0" />
<c:if test="${not empty sessionScope.cart}">
    <c:forEach items="${sessionScope.cart}" var="entry">
        <c:set var="totalAmount" value="${totalAmount + entry.value.totalPrice}" />
    </c:forEach>
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ Hàng - Animal Doctors</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    
    <style>
        /* Giữ nguyên CSS cũ của bạn, thêm một chút cho Modal */
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        .cart-title { color: #10314d; font-weight: 700; text-transform: uppercase; font-size: 1.8rem; margin-bottom: 30px; border-bottom: 2px solid #e0e0e0; padding-bottom: 15px; }
        .table-cart { background: white; border-radius: 10px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); overflow: hidden; width: 100%; border-collapse: separate; border-spacing: 0; }
        .table-cart thead { background-color: #10314d; color: white; }
        .table-cart th { padding: 15px; border: none; text-transform: uppercase; font-size: 0.9rem; }
        .table-cart td { padding: 20px 15px; vertical-align: middle; border-bottom: 1px solid #eee; }
        .cart-product-img { width: 80px; height: 80px; object-fit: cover; border-radius: 8px; border: 1px solid #eee; margin-right: 15px; }
        .qty-input { width: 70px !important; text-align: center; border-radius: 20px; border: 1px solid #ced4da; font-weight: bold; color: #10314d; }
        .btn-remove { color: #dc3545; background: #fff0f1; width: 35px; height: 35px; border-radius: 50%; display: flex; align-items: center; justify-content: center; text-decoration: none; transition: 0.2s; }
        .btn-remove:hover { background: #dc3545; color: white; }
        .cart-summary { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); position: sticky; top: 20px; }
        .summary-row.total { border-top: 2px dashed #eee; padding-top: 15px; margin-top: 15px; font-weight: 800; color: #10314d; font-size: 1.2rem; display: flex; justify-content: space-between; }
        .btn-checkout { background-color: #10314d; color: white; font-weight: 600; padding: 12px; border-radius: 50px; text-transform: uppercase; width: 100%; border: none; transition: 0.3s; }
        .btn-checkout:hover { background-color: #0a2135; transform: translateY(-2px); }
        
        /* CSS cho Modal thanh toán */
        .modal-header { background-color: #10314d; color: white; }
        .modal-title { font-weight: 700; }
        .btn-close-white { filter: invert(1) grayscale(100%) brightness(200%); }
    </style>
</head>
<body>

    <jsp:include page="/components/navbar.jsp" />

    <div class="container mt-5 mb-5" style="min-height: 600px;">
        <h2 class="cart-title"><i class='bx bx-cart-alt'></i> Giỏ Hàng Của Bạn</h2>

        <c:if test="${empty sessionScope.cart}">
            <div class="text-center py-5 bg-white rounded shadow-sm">
                <img src="https://cdn-icons-png.flaticon.com/512/11329/11329060.png" width="150" style="opacity: 0.6">
                <h4 class="mt-4 text-muted">Giỏ hàng trống</h4>
                <a href="${pageContext.request.contextPath}/shop" class="btn btn-checkout px-5 mt-3" style="width: auto;">Mua sắm ngay</a>
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.cart}">
            <div class="row">
                <div class="col-lg-8 mb-4">
                    <div class="table-responsive">
                        <table class="table table-cart">
                            <thead>
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th class="text-center">Đơn giá</th>
                                    <th class="text-center">Số lượng</th>
                                    <th class="text-center">Thành tiền</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${sessionScope.cart}" var="entry">
                                    <c:set var="item" value="${entry.value}" />
                                    <tr class="cart-row">
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="${pageContext.request.contextPath}/assets/images/shop_pic/${item.product.image}" 
                                                     class="cart-product-img"
                                                     onerror="this.src='${pageContext.request.contextPath}/assets/images/shop_pic/default.jpg'">
                                                <div>
                                                    <p class="fw-bold mb-0">${item.product.name}</p>
                                                    <small class="text-muted">ID: ${item.product.id}</small>
                                                </div>
                                            </div>
                                        </td>
                                        
                                        <td class="text-center fw-bold text-secondary" data-price="${item.product.price}">
                                            <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                        </td>
                                        
                                        <td class="text-center">
                                            <input type="number" min="1" value="${item.quantity}" 
                                                   class="form-control qty-input d-inline-block"
                                                   onchange="updateCart(this)">
                                        </td>
                                        
                                        <td class="text-center fw-bold text-primary row-total">
                                            <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                        </td>
                                        
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/cart?action=remove&id=${item.product.id}" 
                                               class="btn-remove" 
                                               onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                                <i class='bx bx-trash'></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="cart-summary">
                        <h5 class="mb-3 fw-bold">Thông tin đơn hàng</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tạm tính:</span>
                            <span id="cart-subtotal" class="fw-bold">
                                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                            </span>
                        </div>
                        <div class="summary-row total">
                            <span>Tổng cộng:</span>
                            <span id="cart-total" class="text-primary">
                                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                            </span>
                        </div>
                        
                        <p class="small text-muted mt-2 mb-4"><i class='bx bx-check-circle'></i> Đã bao gồm thuế VAT</p>
                        
                        <button type="button" class="btn btn-checkout" data-bs-toggle="modal" data-bs-target="#checkoutModal">
                            Tiến hành thanh toán <i class='bx bx-right-arrow-alt'></i>
                        </button>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <div class="modal fade" id="checkoutModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class='bx bxs-truck'></i> Thông Tin Giao Hàng</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Họ và tên người nhận</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class='bx bx-user'></i></span>
                                <input type="text" class="form-control" name="fullname" 
                                       value="${sessionScope.user != null ? sessionScope.user.fullname : ''}" required placeholder="Nhập họ tên">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Số điện thoại</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class='bx bx-phone'></i></span>
                                <input type="text" class="form-control" name="phone" required placeholder="Nhập số điện thoại">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Địa chỉ giao hàng</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class='bx bx-map'></i></span>
                                <textarea class="form-control" name="address" rows="2" required placeholder="Số nhà, đường, phường/xã..."></textarea>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Ghi chú (Tùy chọn)</label>
                            <textarea class="form-control" name="note" rows="2" placeholder="Ví dụ: Giao giờ hành chính..."></textarea>
                        </div>
                        
                        <input type="hidden" name="totalAmount" id="hiddenTotalAmount" value="${totalAmount}">

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success fw-bold py-2">
                                <i class='bx bx-check-circle'></i> XÁC NHẬN ĐẶT HÀNG
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function updateCart(inputElement) {
            // 1. Tìm hàng (row) chứa ô input vừa đổi
            let row = inputElement.closest('tr');
            
            // 2. Lấy giá gốc từ data-attribute và số lượng mới
            let price = parseFloat(row.querySelector('[data-price]').getAttribute('data-price'));
            let quantity = parseInt(inputElement.value);
            
            // 3. Tính thành tiền mới cho dòng này
            let newRowTotal = price * quantity;
            
            // 4. Cập nhật giao diện cột "Thành tiền" (Format tiền Việt)
            let formattedRowTotal = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(newRowTotal);
            // Sửa lỗi hiển thị chữ đ của Intl (nếu cần) hoặc dùng mặc định
            row.querySelector('.row-total').innerText = formattedRowTotal.replace('₫', 'đ');

            // 5. Tính lại TỔNG CỘNG cả giỏ hàng
            recalculateGrandTotal();
        }

        function recalculateGrandTotal() {
            let grandTotal = 0;
            
            // Duyệt qua tất cả các dòng
            document.querySelectorAll('.cart-row').forEach(row => {
                let price = parseFloat(row.querySelector('[data-price]').getAttribute('data-price'));
                let quantity = parseInt(row.querySelector('.qty-input').value);
                grandTotal += (price * quantity);
            });

            // Format tổng tiền
            let formattedGrandTotal = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(grandTotal).replace('₫', 'đ');
            
            // Cập nhật lên giao diện
            document.getElementById('cart-subtotal').innerText = formattedGrandTotal;
            document.getElementById('cart-total').innerText = formattedGrandTotal;
            
            // Cập nhật vào input ẩn trong form checkout
            document.getElementById('hiddenTotalAmount').value = grandTotal;
        }
    </script>
</body>
</html>