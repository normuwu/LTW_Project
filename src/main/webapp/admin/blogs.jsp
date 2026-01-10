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
    <title>Quản lý Bài viết - Admin</title>
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

        /* Main Content */
        .admin-main {
            margin-left: 250px;
            padding: 24px;
            min-height: 100vh;
        }
        
        /* Page Header */
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
        
        /* Stats Cards */
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
            position: relative;
        }
        .stat-card:hover { border-color: var(--accent-blue); box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .stat-card.active { border-color: var(--accent-blue); background: #f0f9ff; }
        .stat-card.active::after {
            content: '✓';
            position: absolute;
            top: 12px;
            right: 12px;
            width: 20px;
            height: 20px;
            background: var(--accent-blue);
            color: white;
            border-radius: 50%;
            font-size: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
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
        .stat-icon.purple { background: #ede9fe; color: var(--accent-purple); }
        .stat-icon.orange { background: #ffedd5; color: var(--accent-orange); }
        .stat-number { font-size: 1.75rem; font-weight: 700; color: var(--text-primary); }
        .stat-label { font-size: 0.85rem; color: var(--text-secondary); margin-top: 4px; }

        /* Filter Section */
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
            transition: border-color 0.2s;
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
        .filter-select:focus { outline: none; border-color: var(--accent-blue); }
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
        .btn-reset:hover { background: var(--bg-primary); }
        .btn-reset.show { display: inline-flex; align-items: center; gap: 6px; }

        /* Table Section */
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
            transition: background 0.2s;
        }
        .btn-add:hover { background: #2563eb; }
        
        /* Data Table */
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th {
            text-align: left;
            padding: 12px 16px;
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
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
        
        /* Table Cells */
        .table-thumb {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid var(--border-color);
        }
        .blog-title-cell { font-weight: 500; color: var(--text-primary); }
        .blog-summary-cell { 
            font-size: 0.8rem; 
            color: var(--text-muted); 
            margin-top: 4px;
            max-width: 250px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .category-badge {
            display: inline-block;
            padding: 4px 10px;
            background: #f1f5f9;
            border-radius: 6px;
            font-size: 0.8rem;
            color: var(--text-secondary);
        }
        
        /* Action Buttons */
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
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-muted);
        }
        .empty-state i { font-size: 3rem; margin-bottom: 16px; }
        
        /* Alert */
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

        /* Modal */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
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
            width: 32px;
            height: 32px;
            border: none;
            background: var(--bg-primary);
            border-radius: 6px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .modal-close:hover { background: #e2e8f0; }
        .modal-body { padding: 20px; overflow-y: auto; flex: 1; }
        .modal-footer {
            padding: 16px 20px;
            border-top: 1px solid var(--border-color);
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }
        
        /* Form */
        .form-group { margin-bottom: 16px; }
        .form-label { 
            display: block; 
            font-size: 0.85rem; 
            font-weight: 500; 
            color: var(--text-primary); 
            margin-bottom: 6px; 
        }
        .form-label .required { color: var(--accent-red); }
        .form-input, .form-select, .form-textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.9rem;
            transition: border-color 0.2s;
        }
        .form-input:focus, .form-select:focus, .form-textarea:focus { 
            outline: none; 
            border-color: var(--accent-blue); 
        }
        .form-textarea { resize: vertical; min-height: 100px; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
        .input-hint { font-size: 0.75rem; color: var(--text-muted); margin-top: 4px; }
        
        /* Buttons */
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
        .btn-secondary:hover { background: #e2e8f0; }
        .btn-primary { background: var(--accent-blue); color: white; }
        .btn-primary:hover { background: #2563eb; }
        .btn-danger { background: var(--accent-red); color: white; }
        .btn-danger:hover { background: #dc2626; }

        /* Delete Modal */
        .modal-sm { max-width: 400px; }
        .confirm-icon {
            width: 56px;
            height: 56px;
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

    <!-- Sidebar -->
    <jsp:include page="/components/admin-sidebar.jsp">
        <jsp:param name="currentPage" value="blogs"/>
    </jsp:include>

    <!-- Main Content -->
    <main class="admin-main">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">Quản lý Bài viết</h1>
            <div class="admin-badge">
                <i class='bx bxs-user-circle'></i> ${sessionScope.user.fullname}
            </div>
        </div>

        <!-- Alert Message -->
        <c:if test="${not empty message}">
            <div class="alert alert-${messageType == 'error' ? 'error' : 'success'}">
                <i class='bx ${messageType == "error" ? "bx-error-circle" : "bx-check-circle"}'></i>
                ${message}
                <button class="alert-close" onclick="this.parentElement.remove()">
                    <i class='bx bx-x'></i>
                </button>
            </div>
        </c:if>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card" onclick="filterByCategory('')">
                <div class="stat-icon blue"><i class='bx bx-file'></i></div>
                <div class="stat-number" id="countTotal">${totalBlogs}</div>
                <div class="stat-label">Tổng bài viết</div>
            </div>
            <div class="stat-card" onclick="filterByCategory('Sức khỏe')">
                <div class="stat-icon green"><i class='bx bx-plus-medical'></i></div>
                <div class="stat-number" id="countHealth">0</div>
                <div class="stat-label">Sức khỏe</div>
            </div>
            <div class="stat-card" onclick="filterByCategory('Chăm sóc')">
                <div class="stat-icon purple"><i class='bx bx-heart'></i></div>
                <div class="stat-number" id="countCare">0</div>
                <div class="stat-label">Chăm sóc</div>
            </div>
            <div class="stat-card" onclick="filterByCategory('Dinh dưỡng')">
                <div class="stat-icon orange"><i class='bx bx-bowl-rice'></i></div>
                <div class="stat-number" id="countNutrition">0</div>
                <div class="stat-label">Dinh dưỡng</div>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="filter-row">
                <div class="search-box">
                    <i class='bx bx-search'></i>
                    <input type="text" id="searchInput" placeholder="Tìm theo tiêu đề, tác giả..." onkeyup="applyFilters()">
                </div>
                <select class="filter-select" id="filterCategory" onchange="applyFilters()">
                    <option value="">Tất cả danh mục</option>
                    <option value="Sức khỏe">Sức khỏe</option>
                    <option value="Dinh dưỡng">Dinh dưỡng</option>
                    <option value="Chăm sóc">Chăm sóc</option>
                    <option value="Huấn luyện">Huấn luyện</option>
                    <option value="Tâm lý thú cưng">Tâm lý thú cưng</option>
                    <option value="Review Sản phẩm">Review Sản phẩm</option>
                    <option value="Chuyện bên lề">Chuyện bên lề</option>
                    <option value="Cấp cứu">Cấp cứu</option>
                    <option value="Góc nhìn">Góc nhìn</option>
                </select>
                <button class="btn-reset" id="resetBtn" onclick="resetFilters()">
                    <i class='bx bx-x'></i> Xóa bộ lọc
                </button>
            </div>
        </div>

        <!-- Table Section -->
        <div class="table-section">
            <div class="table-header">
                <span class="table-title">
                    <i class='bx bx-list-ul'></i> Danh sách bài viết
                    <span id="resultCount" style="font-weight: normal; color: var(--text-muted); font-size: 0.85rem;"></span>
                </span>
                <button class="btn-add" onclick="openAddModal()">
                    <i class='bx bx-plus'></i> Thêm bài viết
                </button>
            </div>

            <!-- Data Table -->
            <table class="data-table">
                <thead>
                    <tr>
                        <th style="width: 50px;">#</th>
                        <th style="width: 70px;">Ảnh</th>
                        <th>Tiêu đề</th>
                        <th style="width: 130px;">Danh mục</th>
                        <th style="width: 130px;">Tác giả</th>
                        <th style="width: 110px;">Ngày đăng</th>
                        <th style="width: 100px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody id="blogsBody">
                    <c:if test="${empty blogs}">
                        <tr>
                            <td colspan="7">
                                <div class="empty-state">
                                    <i class='bx bx-news'></i>
                                    <p>Chưa có bài viết nào</p>
                                    <button class="btn-add" onclick="openAddModal()" style="margin-top: 12px;">
                                        <i class='bx bx-plus'></i> Thêm bài viết
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach items="${blogs}" var="blog" varStatus="loop">
                        <tr data-id="${blog.id}" data-title="${blog.title}" data-category="${blog.category}" 
                            data-author="${blog.author}" data-image="${blog.image}" 
                            data-summary="${blog.summary}" data-date="${blog.date}">
                            <td><strong>${loop.index + 1}</strong></td>
                            <td>
                                <img src="${pageContext.request.contextPath}/community_pic/${blog.image}" 
                                     alt="" class="table-thumb"
                                     onerror="this.src='${pageContext.request.contextPath}/community_pic/default.jpg'">
                            </td>
                            <td>
                                <div class="blog-title-cell">${blog.title}</div>
                                <div class="blog-summary-cell">${blog.summary}</div>
                            </td>
                            <td><span class="category-badge">${blog.category}</span></td>
                            <td>${blog.author}</td>
                            <td>${blog.date}</td>
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
    <div class="modal-overlay" id="blogModal">
        <div class="modal-box">
            <div class="modal-header">
                <h3 class="modal-title" id="modalTitle">Thêm bài viết mới</h3>
                <button class="modal-close" onclick="closeModal()"><i class='bx bx-x'></i></button>
            </div>
            
            <form id="blogForm" method="post">
                <input type="hidden" name="action" id="formAction" value="add">
                <input type="hidden" name="id" id="formId">
                <input type="hidden" name="date" id="formDate">
                
                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label">Tiêu đề bài viết <span class="required">*</span></label>
                        <input type="text" class="form-input" name="title" id="formTitle" required 
                               placeholder="Nhập tiêu đề bài viết...">
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Danh mục <span class="required">*</span></label>
                            <select class="form-select" name="category" id="formCategory" required>
                                <option value="">Chọn danh mục</option>
                                <option value="Sức khỏe">Sức khỏe</option>
                                <option value="Dinh dưỡng">Dinh dưỡng</option>
                                <option value="Chăm sóc">Chăm sóc</option>
                                <option value="Huấn luyện">Huấn luyện</option>
                                <option value="Tâm lý thú cưng">Tâm lý thú cưng</option>
                                <option value="Review Sản phẩm">Review Sản phẩm</option>
                                <option value="Chuyện bên lề">Chuyện bên lề</option>
                                <option value="Cấp cứu">Cấp cứu</option>
                                <option value="Góc nhìn">Góc nhìn</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Tác giả <span class="required">*</span></label>
                            <input type="text" class="form-input" name="author" id="formAuthor" required
                                   placeholder="Tên tác giả">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Ảnh bìa</label>
                        <input type="text" class="form-input" name="image" id="formImage" 
                               placeholder="vd: blog1.jpg">
                        <div class="input-hint">Đặt file ảnh vào thư mục /community_pic/</div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Tóm tắt nội dung <span class="required">*</span></label>
                        <textarea class="form-textarea" name="summary" id="formSummary" required
                                  placeholder="Nhập tóm tắt nội dung bài viết..."></textarea>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeModal()">
                        <i class='bx bx-x'></i> Hủy bỏ
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class='bx bx-save'></i> Lưu bài viết
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Delete Confirm Modal -->
    <div class="modal-overlay" id="deleteModal">
        <div class="modal-box modal-sm">
            <div class="modal-header">
                <h3 class="modal-title">Xóa bài viết?</h3>
                <button class="modal-close" onclick="closeDeleteModal()"><i class='bx bx-x'></i></button>
            </div>
            
            <div class="modal-body">
                <div class="confirm-icon">
                    <i class='bx bx-trash'></i>
                </div>
                <p class="confirm-message">Bài viết sẽ bị xóa vĩnh viễn và không thể khôi phục.</p>
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
        // Count categories on load
        document.addEventListener('DOMContentLoaded', function() {
            countCategories();
            updateResultCount();
        });

        function countCategories() {
            var rows = document.querySelectorAll('#blogsBody tr[data-id]');
            var health = 0, care = 0, nutrition = 0;
            
            rows.forEach(function(row) {
                var cat = row.dataset.category;
                if (cat === 'Sức khỏe') health++;
                else if (cat === 'Chăm sóc') care++;
                else if (cat === 'Dinh dưỡng') nutrition++;
            });
            
            document.getElementById('countHealth').textContent = health;
            document.getElementById('countCare').textContent = care;
            document.getElementById('countNutrition').textContent = nutrition;
        }

        function updateResultCount() {
            var visible = document.querySelectorAll('#blogsBody tr[data-id]:not([style*="display: none"])').length;
            var total = document.querySelectorAll('#blogsBody tr[data-id]').length;
            document.getElementById('resultCount').textContent = '(' + visible + '/' + total + ')';
        }

        // Filter functions
        function applyFilters() {
            var search = document.getElementById('searchInput').value.toLowerCase();
            var category = document.getElementById('filterCategory').value;
            var rows = document.querySelectorAll('#blogsBody tr[data-id]');
            var hasFilter = search || category;
            
            rows.forEach(function(row) {
                var title = (row.dataset.title || '').toLowerCase();
                var author = (row.dataset.author || '').toLowerCase();
                var cat = row.dataset.category || '';
                
                var matchSearch = !search || title.indexOf(search) > -1 || author.indexOf(search) > -1;
                var matchCategory = !category || cat === category;
                
                row.style.display = (matchSearch && matchCategory) ? '' : 'none';
            });
            
            // Show/hide reset button
            var resetBtn = document.getElementById('resetBtn');
            if (hasFilter) {
                resetBtn.classList.add('show');
            } else {
                resetBtn.classList.remove('show');
            }
            
            // Update stat cards active state
            document.querySelectorAll('.stat-card').forEach(function(card) {
                card.classList.remove('active');
            });
            
            updateResultCount();
        }

        function filterByCategory(category) {
            document.getElementById('filterCategory').value = category;
            document.getElementById('searchInput').value = '';
            
            // Update active state
            document.querySelectorAll('.stat-card').forEach(function(card, index) {
                card.classList.remove('active');
                if ((index === 0 && !category) ||
                    (index === 1 && category === 'Sức khỏe') ||
                    (index === 2 && category === 'Chăm sóc') ||
                    (index === 3 && category === 'Dinh dưỡng')) {
                    card.classList.add('active');
                }
            });
            
            applyFilters();
        }

        function resetFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('filterCategory').value = '';
            document.querySelectorAll('.stat-card').forEach(function(card) {
                card.classList.remove('active');
            });
            applyFilters();
        }

        // Modal functions
        function openAddModal() {
            document.getElementById('modalTitle').textContent = 'Thêm bài viết mới';
            document.getElementById('formAction').value = 'add';
            document.getElementById('formId').value = '';
            document.getElementById('formTitle').value = '';
            document.getElementById('formCategory').value = '';
            document.getElementById('formAuthor').value = '';
            document.getElementById('formImage').value = '';
            document.getElementById('formSummary').value = '';
            document.getElementById('formDate').value = '';
            document.getElementById('blogModal').classList.add('show');
        }

        function openEditModal(row) {
            document.getElementById('modalTitle').textContent = 'Chỉnh sửa bài viết';
            document.getElementById('formAction').value = 'edit';
            document.getElementById('formId').value = row.dataset.id;
            document.getElementById('formTitle').value = row.dataset.title || '';
            document.getElementById('formCategory').value = row.dataset.category || '';
            document.getElementById('formAuthor').value = row.dataset.author || '';
            document.getElementById('formImage').value = row.dataset.image || '';
            document.getElementById('formSummary').value = row.dataset.summary || '';
            document.getElementById('formDate').value = row.dataset.date || '';
            document.getElementById('blogModal').classList.add('show');
        }

        function closeModal() {
            document.getElementById('blogModal').classList.remove('show');
        }

        function openDeleteModal(row) {
            document.getElementById('deleteId').value = row.dataset.id;
            document.getElementById('deleteModal').classList.add('show');
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').classList.remove('show');
        }

        // Close modal on overlay click
        document.querySelectorAll('.modal-overlay').forEach(function(overlay) {
            overlay.addEventListener('click', function(e) {
                if (e.target === overlay) {
                    overlay.classList.remove('show');
                }
            });
        });

        // Close modal on Escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeModal();
                closeDeleteModal();
            }
        });
    </script>
</body>
</html>
