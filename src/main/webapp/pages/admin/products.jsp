<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Chuyển session messages sang request scope --%>
<c:if test="${not empty sessionScope.message}">
    <c:set var="message" value="${sessionScope.message}" scope="request"/>
    <c:set var="messageType" value="${sessionScope.messageType}" scope="request"/>
    <c:remove var="message" scope="session"/>
    <c:remove var="messageType" scope="session"/>
</c:if>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="/components/meta.jsp" />
    <title>Quản lý Sản phẩm - Admin</title>
    <jsp:include page="/components/head.jsp" />
    <style>
        :root {
            --bg-primary: #f8fafc;
            --bg-card: #ffffff;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --text-muted: #94a3b8;
            --border-color: #e2e8f0;
            --accent-blue: #3b82f6;
            --accent-green: #10b981;
            --accent-yellow: #f59e0b;
            --accent-red: #ef4444;
            --accent-purple: #8b5cf6;
            --accent-orange: #f97316;
        }
        
        body { background: var(--bg-primary); }

        .admin-main {
            margin-left: 250px;
            padding: 24px;
            min-height: 100vh;
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }
        .page-title { font-size: 1.5rem; font-weight: 600; color: var(--text-primary); margin: 0; }
        .admin-badge {
            background: var(--bg-card);
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 0.85rem;
            color: var(--text-secondary);
            border: 1px solid var(--border-color);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }
        .stat-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .stat-card:hover { border-color: var(--accent-blue); box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .stat-card.active { border-color: var(--accent-blue); background: #f0f9ff; }
        .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            margin-bottom: 12px;
        }
        .stat-icon.blue { background: #dbeafe; color: var(--accent-blue); }
        .stat-icon.green { background: #d1fae5; color: var(--accent-green); }
        .stat-icon.orange { background: #ffedd5; color: var(--accent-orange); }
        .stat-icon.purple { background: #ede9fe; color: var(--accent-purple); }
        .stat-number { font-size: 1.75rem; font-weight: 700; color: var(--text-primary); }
        .stat-label { font-size: 0.85rem; color: var(--text-secondary); margin-top: 4px; }

        .filter-section {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 16px 20px;
            margin-bottom: 16px;
        }
        .filter-row {
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
        }
        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }
        .search-box input {
            width: 100%;
            padding: 10px 12px 10px 40px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.9rem;
        }
        .search-box input:focus { outline: none; border-color: var(--accent-blue); }
        .search-box i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
        }
        .filter-select {
            padding: 10px 12px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.9rem;
            min-width: 160px;
            background: white;
        }
        .btn-reset {
            padding: 8px 14px;
            background: none;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.85rem;
            color: var(--text-secondary);
            cursor: pointer;
            display: none;
        }
        .btn-reset.show { display: inline-flex; align-items: center; gap: 6px; }

        .table-section {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            overflow: hidden;
        }
        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 20px;
            border-bottom: 1px solid var(--border-color);
        }
        .table-title { font-weight: 600; color: var(--text-primary); display: flex; align-items: center; gap: 8px; }
        .btn-add {
            padding: 10px 18px;
            background: var(--accent-blue);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .btn-add:hover { background: #2563eb; }
        
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th {
            text-align: left;
            padding: 12px 16px;
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--text-secondary);
            text-transform: uppercase;
            background: var(--bg-primary);
            border-bottom: 1px solid var(--border-color);
        }
        .data-table td {
            padding: 14px 16px;
            border-bottom: 1px solid var(--border-color);
            font-size: 0.9rem;
            color: var(--text-primary);
            vertical-align: middle;
        }
        .data-table tr:hover { background: var(--bg-primary); }
        
        .product-thumb {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid var(--border-color);
        }
        .product-name { font-weight: 500; }
        .price-current { font-weight: 600; color: var(--accent-red); }
        .price-old { text-decoration: line-through; color: var(--text-muted); font-size: 0.85rem; }
        .discount-badge {
            display: inline-block;
            padding: 4px 8px;
            background: #fef2f2;
            color: var(--accent-red);
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        .no-discount { color: var(--text-muted); }
        
        .table-actions { display: flex; gap: 6px; }
        .action-btn {
            width: 32px;
            height: 32px;
            border: 1px solid var(--border-color);
            background: white;
            border-radius: 6px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-secondary);
            transition: all 0.2s;
        }
        .action-btn:hover { background: var(--bg-primary); }
        .action-btn.edit:hover { border-color: var(--accent-blue); color: var(--accent-blue); }
        .action-btn.delete:hover { border-color: var(--accent-red); color: var(--accent-red); }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-muted);
        }
        .empty-state i { font-size: 3rem; margin-bottom: 16px; }
        
        .alert {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .alert-success { background: #dcfce7; color: #15803d; }
        .alert-error { background: #fee2e2; color: #b91c1c; }
        .alert-close { margin-left: auto; background: none; border: none; cursor: pointer; opacity: 0.7; }

        .modal-overlay {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0,0,0,0.4);
            z-index: 2000;
            display: none;
            align-items: center;
            justify-content: center;
        }
        .modal-overlay.show { display: flex; }
        .modal-box {
            background: white;
            border-radius: 12px;
            width: 100%;
            max-width: 500px;
            max-height: 90vh;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        .modal-header {
            padding: 20px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .modal-title { font-size: 1.1rem; font-weight: 600; margin: 0; }
        .modal-close {
            width: 32px; height: 32px;
            border: none;
            background: var(--bg-primary);
            border-radius: 6px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .modal-body { padding: 20px; overflow-y: auto; flex: 1; }
        .modal-footer {
            padding: 16px 20px;
            border-top: 1px solid var(--border-color);
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }
        
        .form-group { margin-bottom: 16px; }
        .form-label { 
            display: block; 
            font-size: 0.85rem; 
            font-weight: 500; 
            color: var(--text-primary); 
            margin-bottom: 6px; 
        }
        .form-label .required { color: var(--accent-red); }
        .form-input, .form-select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.9rem;
        }
        .form-input:focus, .form-select:focus { outline: none; border-color: var(--accent-blue); }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
        .input-hint { font-size: 0.75rem; color: var(--text-muted); margin-top: 4px; }
        
        .btn { 
            padding: 10px 20px; 
            border-radius: 8px; 
            font-size: 0.9rem; 
            cursor: pointer; 
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-weight: 500;
        }
        .btn-secondary { background: var(--bg-primary); color: var(--text-primary); border: 1px solid var(--border-color); }
        .btn-primary { background: var(--accent-blue); color: white; }
        .btn-danger { background: var(--accent-red); color: white; }

        .modal-sm { max-width: 400px; }
        .confirm-icon {
            width: 56px; height: 56px;
            border-radius: 50%;
            background: #fee2e2;
            color: var(--accent-red);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            font-size: 1.5rem;
        }
        .confirm-message { text-align: center; color: var(--text-secondary); }
    </style>
</head>
<body>

    <jsp:include page="/components/admin-sidebar.jsp">
        <jsp:param name="currentPage" value="products"/>
    </jsp:include>

    <main class="admin-main">
        <div class="page-header">
            <h1 class="page-title">Quản lý Sản phẩm</h1>
            <div class="admin-badge">
                <i class='bx bxs-user-circle'></i> ${sessionScope.user.fullname}
            </div>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-${messageType == 'error' ? 'error' : 'success'}">
                <i class='bx ${messageType == "error" ? "bx-error-circle" : "bx-check-circle"}'></i>
                ${message}
                <button class="alert-close" onclick="this.parentElement.remove()"><i class='bx bx-x'></i></button>
            </div>
        </c:if>

        <div class="stats-grid">
            <div class="stat-card" onclick="filterByDiscount('')">
                <div class="stat-icon blue"><i class='bx bx-package'></i></div>
                <div class="stat-number">${totalProducts}</div>
                <div class="stat-label">Tổng sản phẩm</div>
            </div>
            <div class="stat-card" onclick="filterByDiscount('yes')">
                <div class="stat-icon orange"><i class='bx bx-purchase-tag'></i></div>
                <div class="stat-number">${discountedProducts}</div>
                <div class="stat-label">Đang giảm giá</div>
            </div>
            <div class="stat-card" onclick="filterByDiscount('no')">
                <div class="stat-icon green"><i class='bx bx-check-circle'></i></div>
                <div class="stat-number">${totalProducts - discountedProducts}</div>
                <div class="stat-label">Giá gốc</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon purple"><i class='bx bx-store'></i></div>
                <div class="stat-number">${totalProducts}</div>
                <div class="stat-label">Đang bán</div>
            </div>
        </div>

        <div class="filter-section">
            <div class="filter-row">
                <div class="search-box">
                    <i class='bx bx-search'></i>
                    <input type="text" id="searchInput" placeholder="Tìm theo tên sản phẩm..." onkeyup="applyFilters()">
                </div>
                <select class="filter-select" id="filterDiscount" onchange="applyFilters()">
                    <option value="">Tất cả</option>
                    <option value="yes">Đang giảm giá</option>
                    <option value="no">Không giảm giá</option>
                </select>
                <button class="btn-reset" id="resetBtn" onclick="resetFilters()">
                    <i class='bx bx-x'></i> Xóa bộ lọc
                </button>
            </div>
        </div>

        <div class="table-section">
            <div class="table-header">
                <span class="table-title">
                    <i class='bx bx-list-ul'></i> Danh sách sản phẩm
                    <span id="resultCount" style="font-weight: normal; color: var(--text-muted); font-size: 0.85rem;"></span>
                </span>
                <button class="btn-add" onclick="openAddModal()">
                    <i class='bx bx-plus'></i> Thêm sản phẩm
                </button>
            </div>

            <table class="data-table">
                <thead>
                    <tr>
                        <th style="width: 50px;">#</th>
                        <th style="width: 80px;">Ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th style="width: 130px;">Giá bán</th>
                        <th style="width: 130px;">Giá gốc</th>
                        <th style="width: 100px;">Giảm giá</th>
                        <th style="width: 100px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody id="productsBody">
                    <c:if test="${empty products}">
                        <tr>
                            <td colspan="7">
                                <div class="empty-state">
                                    <i class='bx bx-package'></i>
                                    <p>Chưa có sản phẩm nào</p>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach items="${products}" var="p" varStatus="loop">
                        <tr data-id="${p.id}" data-name="${p.name}" data-image="${p.image}" 
                            data-price="${p.price}" data-oldprice="${p.oldPrice}" data-discount="${p.discount}">
                            <td><strong>${loop.index + 1}</strong></td>
                            <td>
                                <img src="${pageContext.request.contextPath}/assets/images/shop_pic/${p.image}" 
                                     alt="" class="product-thumb"
                                     onerror="this.src='${pageContext.request.contextPath}/assets/images/shop_pic/default.jpg'" loading="lazy">
                            </td>
                            <td><span class="product-name">${p.name}</span></td>
                            <td><span class="price-current">${p.formattedPrice}</span></td>
                            <td><span class="price-old">${p.formattedOldPrice}</span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.discount > 0}">
                                        <span class="discount-badge">-${p.discount}%</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="no-discount">-</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="table-actions">
                                    <button class="action-btn edit" onclick="openEditModal(this.closest('tr'))" title="Sửa">
                                        <i class='bx bx-edit-alt'></i>
                                    </button>
                                    <button class="action-btn delete" onclick="openDeleteModal(this.closest('tr'))" title="Xóa">
                                        <i class='bx bx-trash'></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

    <!-- Add/Edit Modal -->
    <div class="modal-overlay" id="productModal">
        <div class="modal-box">
            <div class="modal-header">
                <h3 class="modal-title" id="modalTitle">Thêm sản phẩm mới</h3>
                <button class="modal-close" onclick="closeModal()"><i class='bx bx-x'></i></button>
            </div>
            
            <form id="productForm" method="post">
                <input type="hidden" name="action" id="formAction" value="add">
                <input type="hidden" name="id" id="formId">
                
                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label">Tên sản phẩm <span class="required">*</span></label>
                        <input type="text" class="form-input" name="name" id="formName" required 
                               placeholder="Nhập tên sản phẩm...">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Ảnh sản phẩm</label>
                        <input type="text" class="form-input" name="image" id="formImage" 
                               placeholder="vd: product1.jpg">
                        <div class="input-hint">Đặt file ảnh vào thư mục /shop_pic/</div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Giá bán <span class="required">*</span></label>
                            <input type="number" class="form-input" name="price" id="formPrice" required
                                   placeholder="VD: 150000" min="0">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Giá gốc</label>
                            <input type="number" class="form-input" name="oldPrice" id="formOldPrice"
                                   placeholder="VD: 200000" min="0" value="0">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Giảm giá (%)</label>
                        <input type="number" class="form-input" name="discount" id="formDiscount"
                               placeholder="VD: 10" min="0" max="100" value="0">
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeModal()">
                        <i class='bx bx-x'></i> Hủy bỏ
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class='bx bx-save'></i> Lưu sản phẩm
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Delete Modal -->
    <div class="modal-overlay" id="deleteModal">
        <div class="modal-box modal-sm">
            <div class="modal-header">
                <h3 class="modal-title">Xóa sản phẩm?</h3>
                <button class="modal-close" onclick="closeDeleteModal()"><i class='bx bx-x'></i></button>
            </div>
            <div class="modal-body">
                <div class="confirm-icon"><i class='bx bx-trash'></i></div>
                <p class="confirm-message">Sản phẩm sẽ bị xóa vĩnh viễn và không thể khôi phục.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeDeleteModal()">
                    <i class='bx bx-x'></i> Hủy bỏ
                </button>
                <form method="post" style="display: inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" id="deleteId">
                    <button type="submit" class="btn btn-danger">
                        <i class='bx bx-trash'></i> Xác nhận xóa
                    </button>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/components/scripts.jsp" />


    <script>
        document.addEventListener('DOMContentLoaded', function() {
            updateResultCount();
        });

        function updateResultCount() {
            var visible = document.querySelectorAll('#productsBody tr[data-id]:not([style*="display: none"])').length;
            var total = document.querySelectorAll('#productsBody tr[data-id]').length;
            document.getElementById('resultCount').textContent = '(' + visible + '/' + total + ')';
        }

        function applyFilters() {
            var search = document.getElementById('searchInput').value.toLowerCase();
            var discount = document.getElementById('filterDiscount').value;
            var rows = document.querySelectorAll('#productsBody tr[data-id]');
            var hasFilter = search || discount;
            
            rows.forEach(function(row) {
                var name = (row.dataset.name || '').toLowerCase();
                var hasDiscount = parseInt(row.dataset.discount) > 0;
                
                var matchSearch = !search || name.indexOf(search) > -1;
                var matchDiscount = !discount || 
                    (discount === 'yes' && hasDiscount) || 
                    (discount === 'no' && !hasDiscount);
                
                row.style.display = (matchSearch && matchDiscount) ? '' : 'none';
            });
            
            var resetBtn = document.getElementById('resetBtn');
            if (hasFilter) {
                resetBtn.classList.add('show');
            } else {
                resetBtn.classList.remove('show');
            }
            
            updateResultCount();
        }

        function filterByDiscount(value) {
            document.getElementById('filterDiscount').value = value;
            document.getElementById('searchInput').value = '';
            applyFilters();
        }

        function resetFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('filterDiscount').value = '';
            applyFilters();
        }

        function openAddModal() {
            document.getElementById('modalTitle').textContent = 'Thêm sản phẩm mới';
            document.getElementById('formAction').value = 'add';
            document.getElementById('formId').value = '';
            document.getElementById('formName').value = '';
            document.getElementById('formImage').value = '';
            document.getElementById('formPrice').value = '';
            document.getElementById('formOldPrice').value = '0';
            document.getElementById('formDiscount').value = '0';
            document.getElementById('productModal').classList.add('show');
        }

        function openEditModal(row) {
            document.getElementById('modalTitle').textContent = 'Chỉnh sửa sản phẩm';
            document.getElementById('formAction').value = 'edit';
            document.getElementById('formId').value = row.dataset.id;
            document.getElementById('formName').value = row.dataset.name || '';
            document.getElementById('formImage').value = row.dataset.image || '';
            document.getElementById('formPrice').value = row.dataset.price || '';
            document.getElementById('formOldPrice').value = row.dataset.oldprice || '0';
            document.getElementById('formDiscount').value = row.dataset.discount || '0';
            document.getElementById('productModal').classList.add('show');
        }

        function closeModal() {
            document.getElementById('productModal').classList.remove('show');
        }

        function openDeleteModal(row) {
            document.getElementById('deleteId').value = row.dataset.id;
            document.getElementById('deleteModal').classList.add('show');
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').classList.remove('show');
        }

        document.querySelectorAll('.modal-overlay').forEach(function(overlay) {
            overlay.addEventListener('click', function(e) {
                if (e.target === overlay) overlay.classList.remove('show');
            });
        });

        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeModal();
                closeDeleteModal();
            }
        });
    </script>
</body>
</html>

