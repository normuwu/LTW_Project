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
    <jsp:include page="/components/admin-styles.jsp" />
    <style>
        /* Stats Grid Override - Giống Dashboard */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 28px;
        }
        .stat-card {
            border-radius: 14px;
            padding: 24px;
            color: white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
            cursor: pointer;
        }
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .stat-card h3 {
            font-size: 2.2rem;
            margin: 0 0 8px 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .stat-card p {
            margin: 0;
            opacity: 0.9;
            font-size: 0.95rem;
        }
        .stat-card.blue { background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%); }
        .stat-card.green { background: linear-gradient(135deg, #059669 0%, #10b981 100%); }
        .stat-card.orange { background: linear-gradient(135deg, #ea580c 0%, #f97316 100%); }
        .stat-card.purple { background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%); }
        
        /* Product Table Styles */
        .product-thumb {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }
        .product-name { 
            font-weight: 600; 
            color: #0f172a;
        }
        .price-current { 
            font-weight: 700; 
            color: #dc2626;
            font-size: 0.95rem;
        }
        .price-old { 
            text-decoration: line-through; 
            color: #94a3b8; 
            font-size: 0.85rem; 
        }
        .discount-badge {
            display: inline-block;
            padding: 5px 12px;
            background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%);
            color: #dc2626;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
        }
        .no-discount { color: #94a3b8; }

        /* Image Upload Styles */
        .image-upload-area {
            border: 2px dashed #e2e8f0;
            border-radius: 14px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s;
            background: #f8fafc;
            min-height: 120px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .image-upload-area.dragover {
            border-color: #3b82f6;
            background: #eff6ff;
        }
        .upload-placeholder i {
            font-size: 2.5rem;
            color: #94a3b8;
            margin-bottom: 10px;
        }
        .upload-placeholder p {
            margin: 4px 0;
            color: #64748b;
            font-size: 0.9rem;
        }
        .upload-placeholder .upload-hint {
            font-size: 0.8rem;
            color: #94a3b8;
        }
        .upload-btn {
            display: inline-block;
            padding: 8px 18px;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.85rem;
            font-weight: 600;
            margin: 8px 0;
            transition: all 0.2s;
            box-shadow: 0 2px 8px rgba(59, 130, 246, 0.3);
        }
        .upload-btn:hover {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            transform: translateY(-1px);
        }
        .image-preview {
            position: relative;
            display: inline-block;
        }
        .image-preview img {
            max-width: 180px;
            max-height: 120px;
            border-radius: 10px;
            object-fit: cover;
            border: 1px solid #e2e8f0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .remove-image {
            position: absolute;
            top: -10px;
            right: -10px;
            width: 26px;
            height: 26px;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            box-shadow: 0 2px 8px rgba(239, 68, 68, 0.4);
            transition: all 0.2s;
        }
        .remove-image:hover {
            transform: scale(1.1);
        }
        
        /* Price Input with VND format */
        .price-input-wrapper {
            position: relative;
        }
        .price-input-wrapper input {
            padding-right: 50px;
        }
        .price-suffix {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            font-weight: 600;
            font-size: 0.85rem;
        }
        .price-display {
            font-size: 0.8rem;
            color: #3b82f6;
            margin-top: 4px;
            font-weight: 500;
        }
    </style>
</head>
<body>

    <jsp:include page="/components/admin-sidebar.jsp">
        <jsp:param name="currentPage" value="products"/>
    </jsp:include>

    <main class="admin-main">
        <div class="page-header">
            <h1 class="page-title"><i class='bx bx-package'></i> Quản lý Sản phẩm</h1>
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

        <!-- Stats Cards - Giống Dashboard -->
        <div class="stats-grid">
            <div class="stat-card blue" onclick="filterByDiscount('')">
                <h3><i class='bx bx-package'></i> ${totalProducts}</h3>
                <p>Tổng sản phẩm</p>
            </div>
            <div class="stat-card orange" onclick="filterByDiscount('yes')">
                <h3><i class='bx bx-purchase-tag'></i> ${discountedProducts}</h3>
                <p>Đang giảm giá</p>
            </div>
            <div class="stat-card green" onclick="filterByDiscount('no')">
                <h3><i class='bx bx-check-circle'></i> ${totalProducts - discountedProducts}</h3>
                <p>Giá gốc</p>
            </div>
            <div class="stat-card purple">
                <h3><i class='bx bx-store'></i> ${totalProducts}</h3>
                <p>Đang bán</p>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
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

        <!-- Table Section -->
        <div class="table-section">
            <div class="table-header">
                <span class="table-title">
                    <i class='bx bx-list-ul'></i> Danh sách sản phẩm
                    <span id="resultCount" style="font-weight: normal; color: #94a3b8; font-size: 0.85rem;"></span>
                </span>
                <button class="btn-add" onclick="openAddModal()">
                    <i class='bx bx-plus'></i> Thêm sản phẩm
                </button>
            </div>

            <table class="data-table">
                <thead>
                    <tr>
                        <th style="width: 50px;">#</th>
                        <th style="width: 90px;">Ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th style="width: 140px;">Giá bán</th>
                        <th style="width: 140px;">Giá gốc</th>
                        <th style="width: 100px;">Giảm giá</th>
                        <th style="width: 110px;">Thao tác</th>
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
                        
                        <!-- Image Upload Area -->
                        <div class="image-upload-area" id="imageUploadArea">
                            <div class="upload-placeholder" id="uploadPlaceholder">
                                <i class='bx bx-cloud-upload'></i>
                                <p>Kéo thả ảnh vào đây hoặc</p>
                                <label for="imageFile" class="upload-btn">Chọn file</label>
                                <p class="upload-hint">Hoặc nhấn Ctrl+V để dán ảnh</p>
                            </div>
                            <div class="image-preview" id="imagePreview" style="display: none;">
                                <img id="previewImg" src="" alt="Preview">
                                <button type="button" class="remove-image" onclick="removeImage()">
                                    <i class='bx bx-x'></i>
                                </button>
                            </div>
                        </div>
                        <input type="file" id="imageFile" accept="image/*" style="display: none;" onchange="handleFileSelect(event)">
                        <input type="hidden" name="image" id="formImage">
                        <input type="hidden" name="imageData" id="formImageData">
                        
                        <div class="input-hint">Hỗ trợ: JPG, PNG, GIF. Tối đa 5MB</div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Giá bán <span class="required">*</span></label>
                            <div class="price-input-wrapper">
                                <input type="text" class="form-input" name="priceDisplay" id="formPriceDisplay" required
                                       placeholder="VD: 150,000" oninput="formatPriceInput(this, 'formPrice')">
                                <span class="price-suffix">VNĐ</span>
                            </div>
                            <input type="hidden" name="price" id="formPrice">
                            <div class="price-display" id="pricePreview"></div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Giá gốc</label>
                            <div class="price-input-wrapper">
                                <input type="text" class="form-input" name="oldPriceDisplay" id="formOldPriceDisplay"
                                       placeholder="VD: 200,000" oninput="formatPriceInput(this, 'formOldPrice')">
                                <span class="price-suffix">VNĐ</span>
                            </div>
                            <input type="hidden" name="oldPrice" id="formOldPrice" value="0">
                            <div class="price-display" id="oldPricePreview"></div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Giảm giá (%)</label>
                        <input type="number" class="form-input" name="discount" id="formDiscount"
                               placeholder="VD: 10" min="0" max="100" value="0" step="1">
                        <div class="input-hint">Nhập phần trăm giảm giá (0-100)</div>
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
        <div class="modal-box" style="max-width: 420px;">
            <div class="modal-header">
                <h3 class="modal-title">Xóa sản phẩm?</h3>
                <button class="modal-close" onclick="closeDeleteModal()"><i class='bx bx-x'></i></button>
            </div>
            <div class="modal-body" style="text-align: center; padding: 30px;">
                <div style="width: 72px; height: 72px; border-radius: 50%; background: #fee2e2; color: #ef4444; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px; font-size: 2rem;">
                    <i class='bx bx-trash'></i>
                </div>
                <p style="color: #64748b; font-size: 0.95rem; margin: 0;">Sản phẩm sẽ bị xóa vĩnh viễn và không thể khôi phục.</p>
            </div>
            <div class="modal-footer" style="justify-content: center;">
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
        // ========== FORMAT PRICE VND ==========
        function formatVND(number) {
            return new Intl.NumberFormat('vi-VN').format(number);
        }
        
        function parseVND(str) {
            return parseInt(str.replace(/[^\d]/g, '')) || 0;
        }
        
        function formatPriceInput(input, hiddenId) {
            var value = input.value.replace(/[^\d]/g, '');
            var number = parseInt(value) || 0;
            
            if (value) {
                input.value = formatVND(number);
            }
            
            document.getElementById(hiddenId).value = number;
            
            // Update preview
            var previewId = hiddenId === 'formPrice' ? 'pricePreview' : 'oldPricePreview';
            if (number > 0) {
                document.getElementById(previewId).textContent = '= ' + formatVND(number) + ' đ';
            } else {
                document.getElementById(previewId).textContent = '';
            }
        }
        
        // ========== FILTER FUNCTIONS ==========
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

        // ========== MODAL FUNCTIONS ==========
        function openAddModal() {
            document.getElementById('modalTitle').textContent = 'Thêm sản phẩm mới';
            document.getElementById('formAction').value = 'add';
            document.getElementById('formId').value = '';
            document.getElementById('formName').value = '';
            document.getElementById('formImage').value = '';
            document.getElementById('formPriceDisplay').value = '';
            document.getElementById('formPrice').value = '';
            document.getElementById('formOldPriceDisplay').value = '';
            document.getElementById('formOldPrice').value = '0';
            document.getElementById('formDiscount').value = '0';
            document.getElementById('pricePreview').textContent = '';
            document.getElementById('oldPricePreview').textContent = '';
            removeImage();
            document.getElementById('productModal').classList.add('show');
        }

        function openEditModal(row) {
            document.getElementById('modalTitle').textContent = 'Chỉnh sửa sản phẩm';
            document.getElementById('formAction').value = 'edit';
            document.getElementById('formId').value = row.dataset.id;
            document.getElementById('formName').value = row.dataset.name || '';
            document.getElementById('formImage').value = row.dataset.image || '';
            
            // Format price for display
            var price = parseInt(row.dataset.price) || 0;
            var oldPrice = parseInt(row.dataset.oldprice) || 0;
            
            document.getElementById('formPriceDisplay').value = price > 0 ? formatVND(price) : '';
            document.getElementById('formPrice').value = price;
            document.getElementById('pricePreview').textContent = price > 0 ? '= ' + formatVND(price) + ' đ' : '';
            
            document.getElementById('formOldPriceDisplay').value = oldPrice > 0 ? formatVND(oldPrice) : '';
            document.getElementById('formOldPrice').value = oldPrice;
            document.getElementById('oldPricePreview').textContent = oldPrice > 0 ? '= ' + formatVND(oldPrice) + ' đ' : '';
            
            document.getElementById('formDiscount').value = row.dataset.discount || '0';
            
            // Show existing image
            var existingImage = row.dataset.image;
            if (existingImage) {
                document.getElementById('previewImg').src = '${pageContext.request.contextPath}/assets/images/shop_pic/' + existingImage;
                document.getElementById('previewImg').onerror = function() {
                    removeImage();
                };
                document.getElementById('uploadPlaceholder').style.display = 'none';
                document.getElementById('imagePreview').style.display = 'block';
                document.getElementById('formImageData').value = '';
            } else {
                removeImage();
            }
            
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

        // ========== IMAGE UPLOAD FUNCTIONS ==========
        var uploadArea = document.getElementById('imageUploadArea');
        var uploadPlaceholder = document.getElementById('uploadPlaceholder');
        var imagePreview = document.getElementById('imagePreview');
        var previewImg = document.getElementById('previewImg');
        var formImage = document.getElementById('formImage');
        var formImageData = document.getElementById('formImageData');

        // Drag and Drop
        uploadArea.addEventListener('dragover', function(e) {
            e.preventDefault();
            uploadArea.classList.add('dragover');
        });

        uploadArea.addEventListener('dragleave', function(e) {
            e.preventDefault();
            uploadArea.classList.remove('dragover');
        });

        uploadArea.addEventListener('drop', function(e) {
            e.preventDefault();
            uploadArea.classList.remove('dragover');
            var files = e.dataTransfer.files;
            if (files.length > 0 && files[0].type.startsWith('image/')) {
                processImage(files[0]);
            }
        });

        // File Select
        function handleFileSelect(event) {
            var file = event.target.files[0];
            if (file && file.type.startsWith('image/')) {
                processImage(file);
            }
        }

        // Paste Image (Ctrl+V)
        document.addEventListener('paste', function(e) {
            if (!document.getElementById('productModal').classList.contains('show')) return;
            
            var items = e.clipboardData.items;
            for (var i = 0; i < items.length; i++) {
                if (items[i].type.startsWith('image/')) {
                    var file = items[i].getAsFile();
                    processImage(file);
                    e.preventDefault();
                    break;
                }
            }
        });

        // Process Image
        function processImage(file) {
            if (file.size > 5 * 1024 * 1024) {
                alert('File quá lớn! Vui lòng chọn ảnh dưới 5MB.');
                return;
            }

            var reader = new FileReader();
            reader.onload = function(e) {
                previewImg.src = e.target.result;
                uploadPlaceholder.style.display = 'none';
                imagePreview.style.display = 'block';
                
                formImageData.value = e.target.result;
                
                var ext = file.name.split('.').pop() || 'jpg';
                var filename = 'product_' + Date.now() + '.' + ext;
                formImage.value = filename;
            };
            reader.readAsDataURL(file);
        }

        // Remove Image
        function removeImage() {
            previewImg.src = '';
            uploadPlaceholder.style.display = 'block';
            imagePreview.style.display = 'none';
            formImage.value = '';
            formImageData.value = '';
            document.getElementById('imageFile').value = '';
        }
    </script>
</body>
</html>
