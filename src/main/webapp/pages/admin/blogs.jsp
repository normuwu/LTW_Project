<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String message = (String) session.getAttribute("message");
    String messageType = (String) session.getAttribute("messageType");
    session.removeAttribute("message");
    session.removeAttribute("messageType");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="/components/meta.jsp" />
    <title>Quản lý Bài viết - Admin</title>
    <jsp:include page="/components/head.jsp" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
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
        
        * { font-family: 'Open Sans', sans-serif; }
        h1, h2, h3, h4, h5, h6, .heading { font-family: 'Poppins', sans-serif; }
        body { background: var(--bg-primary); margin: 0; }
        
        /* Sidebar - Consistent with appointments.jsp */
        .sidebar {
            min-height: 100vh;
            background: var(--text-primary);
            width: 240px;
            position: fixed;
            left: 0;
            top: 0;
        }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .sidebar-brand h5 { color: white; margin: 0; font-weight: 600; font-family: 'Poppins', sans-serif; }
        .sidebar-nav { padding: 15px 0; }
        .sidebar-nav a {
            display: flex; align-items: center; gap: 12px;
            padding: 12px 20px; color: rgba(255,255,255,0.7);
            text-decoration: none; font-size: 0.9rem; transition: all 0.2s;
        }
        .sidebar-nav a:hover, .sidebar-nav a.active { background: rgba(255,255,255,0.1); color: white; }
        .sidebar-nav a i { font-size: 1.2rem; }
        
        /* Main Content */
        .main-content { margin-left: 240px; padding: 24px; min-height: 100vh; }
        
        /* Page Header */
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; }
        .page-title { font-size: 1.5rem; font-weight: 600; color: var(--text-primary); margin: 0; font-family: 'Poppins', sans-serif; }
        .admin-badge {
            background: var(--bg-primary);
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 0.85rem;
            color: var(--text-secondary);
        }

        /* Stats Cards - Bento Grid Style */
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
            transition: all 0.2s ease;
        }
        .stat-card:hover { 
            border-color: var(--accent-blue); 
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            transform: translateY(-2px);
        }
        .stat-card.active { border-color: var(--accent-blue); background: #f0f9ff; }
        .stat-icon {
            width: 44px; height: 44px;
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.3rem;
            margin-bottom: 12px;
        }
        .stat-icon.blue { background: #dbeafe; color: var(--accent-blue); }
        .stat-icon.green { background: #d1fae5; color: var(--accent-green); }
        .stat-icon.purple { background: #ede9fe; color: var(--accent-purple); }
        .stat-icon.orange { background: #ffedd5; color: var(--accent-orange); }
        .stat-number { font-size: 1.75rem; font-weight: 700; color: var(--text-primary); font-family: 'Poppins', sans-serif; }
        .stat-label { font-size: 0.85rem; color: var(--text-secondary); margin-top: 4px; }

        /* Content Section */
        .content-section {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            overflow: hidden;
        }
        .section-header {
            padding: 16px 20px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .section-title { 
            font-weight: 600; 
            color: var(--text-primary); 
            display: flex; 
            align-items: center; 
            gap: 8px;
            font-family: 'Poppins', sans-serif;
        }
        .btn-add {
            padding: 10px 18px;
            background: var(--accent-blue);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 0.9rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: background 0.2s;
            font-weight: 500;
        }
        .btn-add:hover { background: #2563eb; }
        
        /* Filter Bar */
        .filter-bar {
            padding: 16px 20px;
            border-bottom: 1px solid var(--border-color);
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
            border-radius: 6px;
            font-size: 0.85rem;
            color: var(--text-secondary);
            cursor: pointer;
            display: none;
        }
        .btn-reset:hover { background: var(--bg-primary); }
        .btn-reset.show { display: flex; align-items: center; gap: 4px; }

        /* View Toggle */
        .view-toggle {
            display: flex;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            overflow: hidden;
        }
        .view-btn {
            padding: 8px 12px;
            background: white;
            border: none;
            cursor: pointer;
            color: var(--text-muted);
            transition: all 0.2s;
        }
        .view-btn:hover { background: var(--bg-primary); }
        .view-btn.active { background: var(--accent-blue); color: white; }
        .view-btn:first-child { border-right: 1px solid var(--border-color); }
</style>
</head>
<body>

    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-brand">
            <h5><i class='bx bxs-dog'></i> Admin Panel</h5>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/pages/admin/dashboard">
                <i class='bx bxs-dashboard'></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/pages/admin/appointments">
                <i class='bx bxs-calendar-check'></i> Quản lý Lịch hẹn
            </a>
            <a href="${pageContext.request.contextPath}/pages/admin/blogs" class="active">
                <i class='bx bxs-news'></i> Quản lý Bài viết
            </a>
            <a href="${pageContext.request.contextPath}/shop">
                <i class='bx bxs-shopping-bag'></i> Quản lý Sản phẩm
            </a>
            <div style="border-top: 1px solid rgba(255,255,255,0.1); margin: 15px 20px;"></div>
            <a href="${pageContext.request.contextPath}/home">
                <i class='bx bx-home'></i> Về trang chủ
            </a>
            <a href="${pageContext.request.contextPath}/logout">
                <i class='bx bx-log-out'></i> Đăng xuất
            </a>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title"><i class='bx bxs-news'></i> Quản lý Bài viết</h1>
            <div class="admin-badge">
                <i class='bx bxs-user-circle'></i> <%= user.getFullname() %>
            </div>
        </div>

        <!-- Alert -->
        <% if (message != null) { %>
            <div class="alert alert-<%= "error".equals(messageType) ? "error" : "success" %>">
                <i class='bx <%= "error".equals(messageType) ? "bx-error-circle" : "bx-check-circle" %>'></i>
                <%= message %>
                <button class="alert-close" onclick="this.parentElement.remove()"><i class='bx bx-x'></i></button>
            </div>
        <% } %>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card" onclick="filterByCategory('')">
                <div class="stat-icon blue"><i class='bx bx-file'></i></div>
                <div class="stat-number">${totalBlogs}</div>
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

        <!-- Content Section -->
        <div class="content-section">
            <div class="section-header">
                <span class="section-title">
                    <i class='bx bx-list-ul'></i> Danh sách bài viết
                    <span id="resultCount" style="font-weight: normal; color: var(--text-muted); font-size: 0.85rem;">(${totalBlogs})</span>
                </span>
                <button class="btn-add" onclick="openAddModal()">
                    <i class='bx bx-plus'></i> Thêm bài viết
                </button>
            </div>
            
            <!-- Filter Bar -->
            <div class="filter-bar">
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
                    <i class='bx bx-reset'></i> Xóa bộ lọc
                </button>
                <div class="view-toggle">
                    <button class="view-btn active" onclick="setView('grid')" title="Dạng lưới">
                        <i class='bx bx-grid-alt'></i>
                    </button>
                    <button class="view-btn" onclick="setView('table')" title="Dạng bảng">
                        <i class='bx bx-list-ul'></i>
                    </button>
                </div>
            </div>
            
            <!-- Blog Grid View -->
            <div class="blog-grid" id="blogGrid">
                <c:if test="${empty blogs}">
                    <div class="empty-state" style="grid-column: 1/-1;">
                        <i class='bx bx-news'></i>
                        <p>Chưa có bài viết nào</p>
                        <button class="btn-add" onclick="openAddModal()" style="margin-top: 12px;">
                            <i class='bx bx-plus'></i> Thêm bài viết đầu tiên
                        </button>
                    </div>
                </c:if>
                
                <c:forEach items="${blogs}" var="blog">
                    <div class="blog-card" data-id="${blog.id}" data-title="${blog.title}" 
                         data-category="${blog.category}" data-author="${blog.author}"
                         data-image="${blog.image}" data-summary="${blog.summary}" data-date="${blog.date}">
                        <div class="blog-image-wrapper">
                            <img src="${pageContext.request.contextPath}/assets/images/community_pic/${blog.image}" 
                                 alt="${blog.title}" class="blog-image"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/community_pic/default.jpg'">
                            <span class="blog-category">${blog.category}</span>
                        </div>
                        <div class="blog-content">
                            <h3 class="blog-title">${blog.title}</h3>
                            <p class="blog-summary">${blog.summary}</p>
                            <div class="blog-meta">
                                <div class="blog-author">
                                    <i class='bx bx-user-circle'></i>
                                    <span>${blog.author}</span>
                                </div>
                                <span class="blog-date"><i class='bx bx-calendar'></i> ${blog.date}</span>
                            </div>
                        </div>
                        <div class="blog-actions">
                            <button class="action-btn" onclick="openEditModal(this.closest('.blog-card').dataset.id)" title="Chỉnh sửa">
                                <i class='bx bx-edit'></i>
                            </button>
                            <button class="action-btn danger" onclick="confirmDeleteFromCard(this.closest('.blog-card'))" title="Xóa">
                                <i class='bx bx-trash'></i>
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Blog Table View (Hidden by default) -->
            <div class="blog-table-wrapper" id="blogTable" style="display: none;">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th style="width: 50px;">#</th>
                            <th style="width: 80px;">Ảnh</th>
                            <th>Tiêu đề</th>
                            <th style="width: 120px;">Danh mục</th>
                            <th style="width: 140px;">Tác giả</th>
                            <th style="width: 110px;">Ngày đăng</th>
                            <th style="width: 100px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="blogTableBody">
                        <c:forEach items="${blogs}" var="blog" varStatus="loop">
                            <tr data-id="${blog.id}" data-title="${blog.title}" 
                                data-category="${blog.category}" data-author="${blog.author}">
                                <td><strong>${loop.index + 1}</strong></td>
                                <td>
                                    <img src="${pageContext.request.contextPath}/assets/images/community_pic/${blog.image}" 
                                         alt="" class="table-thumb"
                                         onerror="this.src='${pageContext.request.contextPath}/assets/images/community_pic/default.jpg'">
                                </td>
                                <td>
                                    <div class="table-title">${blog.title}</div>
                                    <div class="table-summary">${blog.summary}</div>
                                </td>
                                <td><span class="category-badge">${blog.category}</span></td>
                                <td>${blog.author}</td>
                                <td>${blog.date}</td>
                                <td>
                                    <div class="table-actions">
                                        <button class="action-btn-sm" onclick="openEditModal(this.closest('tr').dataset.id)" title="Sửa">
                                            <i class='bx bx-edit'></i>
                                        </button>
                                        <button class="action-btn-sm danger" onclick="confirmDeleteFromRow(this.closest('tr'))" title="Xóa">
                                            <i class='bx bx-trash'></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>

<!-- Add/Edit Modal -->
<div class="modal-overlay" id="blogModal">
    <div class="modal-box">
        <div class="modal-header">
            <span class="modal-title" id="modalTitle">Thêm bài viết mới</span>
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
                    <div class="image-input-wrapper">
                        <input type="text" class="form-input" name="image" id="formImage" 
                               placeholder="vd: blog1.jpg">
                        <span class="input-hint">Đặt file ảnh vào thư mục /community_pic/</span>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Tóm tắt nội dung <span class="required">*</span></label>
                    <textarea class="form-textarea" name="summary" id="formSummary" required
                              placeholder="Nhập tóm tắt nội dung bài viết..." rows="4"></textarea>
                </div>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeModal()">Hủy</button>
                <button type="submit" class="btn btn-primary" id="submitBtn">
                    <i class='bx bx-save'></i> Lưu bài viết
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Delete Confirm Modal -->
<div class="modal-overlay" id="deleteModal">
    <div class="modal-box modal-sm">
        <div class="modal-header" style="border: none; padding-bottom: 0;">
            <span></span>
            <button class="modal-close" onclick="closeDeleteModal()"><i class='bx bx-x'></i></button>
        </div>
        <div class="modal-confirm-content">
            <div class="modal-icon danger">
                <i class='bx bx-trash'></i>
            </div>
            <h3 class="modal-confirm-title">Xóa bài viết?</h3>
            <p class="modal-confirm-desc" id="deleteMessage">Bài viết sẽ bị xóa vĩnh viễn.</p>
        </div>
        <div class="modal-footer" style="justify-content: center;">
            <button class="btn btn-secondary" onclick="closeDeleteModal()">Hủy</button>
            <form method="post" style="display: inline;">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" id="deleteId">
                <button type="submit" class="btn btn-danger"><i class='bx bx-trash'></i> Xóa</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/components/scripts.jsp" />

<style>
    /* Blog Grid */
    .blog-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 20px;
        padding: 20px;
    }
    .blog-card {
        background: var(--bg-card);
        border: 1px solid var(--border-color);
        border-radius: 12px;
        overflow: hidden;
        transition: all 0.2s ease;
        cursor: pointer;
        display: flex;
        flex-direction: column;
    }
    .blog-card:hover { 
        box-shadow: 0 8px 24px rgba(0,0,0,0.08); 
        transform: translateY(-4px);
        border-color: var(--accent-blue);
    }
    .blog-image-wrapper {
        position: relative;
        height: 180px;
        overflow: hidden;
    }
    .blog-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.3s ease;
    }
    .blog-card:hover .blog-image { transform: scale(1.05); }
    .blog-category {
        position: absolute;
        top: 12px;
        left: 12px;
        padding: 5px 12px;
        background: rgba(255,255,255,0.95);
        color: var(--accent-blue);
        border-radius: 6px;
        font-size: 0.75rem;
        font-weight: 600;
        backdrop-filter: blur(4px);
    }
    .blog-content { padding: 16px; flex: 1; }
    .blog-title {
        font-size: 1rem;
        font-weight: 600;
        color: var(--text-primary);
        margin: 0 0 8px 0;
        line-height: 1.4;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        font-family: 'Poppins', sans-serif;
    }
    .blog-summary {
        font-size: 0.85rem;
        color: var(--text-secondary);
        line-height: 1.5;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        margin: 0 0 12px 0;
    }
    .blog-meta {
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 0.8rem;
        color: var(--text-muted);
    }
    .blog-author { display: flex; align-items: center; gap: 6px; }
    .blog-author i { font-size: 1.1rem; }
    .blog-date { display: flex; align-items: center; gap: 4px; }
    .blog-actions {
        display: flex;
        gap: 8px;
        padding: 12px 16px;
        border-top: 1px solid var(--border-color);
        justify-content: flex-end;
        background: var(--bg-primary);
    }
    .action-btn {
        width: 36px; height: 36px;
        border: 1px solid var(--border-color);
        background: white;
        border-radius: 8px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--text-secondary);
        transition: all 0.2s;
    }
    .action-btn:hover { 
        background: var(--accent-blue); 
        color: white; 
        border-color: var(--accent-blue); 
    }
    .action-btn.danger:hover { 
        background: var(--accent-red); 
        border-color: var(--accent-red); 
    }

    /* Table View */
    .blog-table-wrapper { overflow-x: auto; }
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
    .table-thumb {
        width: 60px;
        height: 45px;
        object-fit: cover;
        border-radius: 6px;
    }
    .table-title {
        font-weight: 500;
        color: var(--text-primary);
        margin-bottom: 4px;
    }
    .table-summary {
        font-size: 0.8rem;
        color: var(--text-muted);
        display: -webkit-box;
        -webkit-line-clamp: 1;
        line-clamp: 1;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
    .category-badge {
        display: inline-block;
        padding: 4px 10px;
        background: #eff6ff;
        color: var(--accent-blue);
        border-radius: 4px;
        font-size: 0.75rem;
        font-weight: 500;
    }
    .table-actions { display: flex; gap: 6px; }
    .action-btn-sm {
        width: 32px; height: 32px;
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
    .action-btn-sm:hover { background: var(--bg-primary); color: var(--accent-blue); }
    .action-btn-sm.danger:hover { color: var(--accent-red); }

    /* Modal */
    .modal-overlay {
        position: fixed;
        top: 0; left: 0; right: 0; bottom: 0;
        background: rgba(15, 23, 42, 0.5);
        z-index: 1000;
        display: none;
        align-items: center;
        justify-content: center;
        backdrop-filter: blur(4px);
    }
    .modal-overlay.show { display: flex; }
    .modal-box {
        background: white;
        border-radius: 16px;
        width: 100%;
        max-width: 560px;
        max-height: 90vh;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        box-shadow: 0 20px 60px rgba(0,0,0,0.2);
    }
    .modal-box.modal-sm { max-width: 400px; }
    .modal-header {
        padding: 20px 24px;
        border-bottom: 1px solid var(--border-color);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .modal-title { 
        font-size: 1.1rem; 
        font-weight: 600; 
        color: var(--text-primary);
        font-family: 'Poppins', sans-serif;
    }
    .modal-close {
        width: 32px; height: 32px;
        border: none;
        background: var(--bg-primary);
        border-radius: 8px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: background 0.2s;
    }
    .modal-close:hover { background: #e2e8f0; }
    .modal-body { padding: 24px; overflow-y: auto; flex: 1; }
    .modal-footer {
        padding: 16px 24px;
        border-top: 1px solid var(--border-color);
        display: flex;
        gap: 12px;
        justify-content: flex-end;
    }
    .modal-confirm-content { text-align: center; padding: 0 24px 24px; }
    .modal-icon {
        width: 64px; height: 64px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 16px;
        font-size: 1.75rem;
    }
    .modal-icon.danger { background: #fee2e2; color: var(--accent-red); }
    .modal-confirm-title { 
        margin: 0 0 8px 0; 
        color: var(--text-primary);
        font-family: 'Poppins', sans-serif;
    }
    .modal-confirm-desc { color: var(--text-secondary); font-size: 0.9rem; margin: 0; }
    
    /* Form */
    .form-group { margin-bottom: 20px; }
    .form-label {
        display: block;
        font-size: 0.9rem;
        font-weight: 500;
        color: var(--text-primary);
        margin-bottom: 8px;
    }
    .form-label .required { color: var(--accent-red); }
    .form-input, .form-select, .form-textarea {
        width: 100%;
        padding: 12px;
        border: 1px solid var(--border-color);
        border-radius: 8px;
        font-size: 0.9rem;
        transition: border-color 0.2s, box-shadow 0.2s;
        box-sizing: border-box;
    }
    .form-input:focus, .form-select:focus, .form-textarea:focus {
        outline: none;
        border-color: var(--accent-blue);
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
    }
    .form-textarea { resize: vertical; min-height: 100px; }
    .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
    .input-hint { font-size: 0.8rem; color: var(--text-muted); margin-top: 6px; display: block; }
    
    /* Buttons */
    .btn {
        padding: 10px 20px;
        border-radius: 8px;
        font-size: 0.9rem;
        cursor: pointer;
        border: none;
        transition: all 0.2s;
        font-weight: 500;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }
    .btn-secondary { background: var(--bg-primary); color: var(--text-primary); }
    .btn-secondary:hover { background: #e2e8f0; }
    .btn-primary { background: var(--accent-blue); color: white; }
    .btn-primary:hover { background: #2563eb; }
    .btn-danger { background: var(--accent-red); color: white; }
    .btn-danger:hover { background: #dc2626; }
    
    /* Alert */
    .alert {
        padding: 14px 16px;
        border-radius: 10px;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .alert-success { background: #dcfce7; color: #15803d; border: 1px solid #bbf7d0; }
    .alert-error { background: #fee2e2; color: #b91c1c; border: 1px solid #fecaca; }
    .alert-close { 
        margin-left: auto; 
        background: none; 
        border: none; 
        cursor: pointer; 
        opacity: 0.7;
        padding: 4px;
    }
    .alert-close:hover { opacity: 1; }
    
    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: var(--text-muted);
    }
    .empty-state i { font-size: 3.5rem; margin-bottom: 16px; opacity: 0.5; }
    .empty-state p { margin: 0 0 16px 0; font-size: 1rem; }
</style>

<script>
    var currentView = 'grid';
    
    // Initialize
    document.addEventListener('DOMContentLoaded', function() {
        updateCategoryCounts();
        updateResultCount();
    });
    
    // Update category counts
    function updateCategoryCounts() {
        var cards = document.querySelectorAll('.blog-card');
        var healthCount = 0, careCount = 0, nutritionCount = 0;
        
        cards.forEach(function(card) {
            var cat = card.dataset.category;
            if (cat === 'Sức khỏe') healthCount++;
            else if (cat === 'Chăm sóc') careCount++;
            else if (cat === 'Dinh dưỡng') nutritionCount++;
        });
        
        document.getElementById('countHealth').textContent = healthCount;
        document.getElementById('countCare').textContent = careCount;
        document.getElementById('countNutrition').textContent = nutritionCount;
    }
    
    // Filter by category from stats card
    function filterByCategory(category) {
        document.querySelectorAll('.stat-card').forEach(function(c) { c.classList.remove('active'); });
        if (category) {
            event.currentTarget.classList.add('active');
        }
        document.getElementById('filterCategory').value = category;
        applyFilters();
    }
    
    // Apply filters
    function applyFilters() {
        var search = document.getElementById('searchInput').value.toLowerCase();
        var category = document.getElementById('filterCategory').value;
        
        var visibleCount = 0;
        
        // Filter grid view
        document.querySelectorAll('.blog-card').forEach(function(card) {
            var title = card.dataset.title.toLowerCase();
            var author = card.dataset.author.toLowerCase();
            var cardCategory = card.dataset.category;
            
            var matchSearch = !search || title.indexOf(search) !== -1 || author.indexOf(search) !== -1;
            var matchCategory = !category || cardCategory === category;
            
            var show = matchSearch && matchCategory;
            card.style.display = show ? '' : 'none';
            if (show) visibleCount++;
        });
        
        // Filter table view
        document.querySelectorAll('#blogTableBody tr').forEach(function(row) {
            var title = row.dataset.title.toLowerCase();
            var author = row.dataset.author.toLowerCase();
            var rowCategory = row.dataset.category;
            
            var matchSearch = !search || title.indexOf(search) !== -1 || author.indexOf(search) !== -1;
            var matchCategory = !category || rowCategory === category;
            
            row.style.display = (matchSearch && matchCategory) ? '' : 'none';
        });
        
        updateResultCount(visibleCount);
        updateResetButton();
    }
    
    // Reset filters
    function resetFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('filterCategory').value = '';
        document.querySelectorAll('.stat-card').forEach(function(c) { c.classList.remove('active'); });
        applyFilters();
    }
    
    // Update result count
    function updateResultCount(count) {
        var total = document.querySelectorAll('.blog-card').length;
        count = count !== undefined ? count : total;
        var text = count < total ? '(' + count + '/' + total + ')' : '(' + total + ')';
        document.getElementById('resultCount').textContent = text;
    }
    
    // Update reset button visibility
    function updateResetButton() {
        var hasFilters = document.getElementById('searchInput').value || 
                          document.getElementById('filterCategory').value;
        var btn = document.getElementById('resetBtn');
        btn.classList.toggle('show', hasFilters);
    }
    
    // Toggle view
    function setView(view) {
        currentView = view;
        document.querySelectorAll('.view-btn').forEach(function(b) { b.classList.remove('active'); });
        event.currentTarget.classList.add('active');
        
        document.getElementById('blogGrid').style.display = view === 'grid' ? 'grid' : 'none';
        document.getElementById('blogTable').style.display = view === 'table' ? 'block' : 'none';
    }
    
    // Open Add Modal
    function openAddModal() {
        document.getElementById('modalTitle').textContent = 'Thêm bài viết mới';
        document.getElementById('formAction').value = 'add';
        document.getElementById('formId').value = '';
        document.getElementById('formDate').value = '';
        document.getElementById('formTitle').value = '';
        document.getElementById('formCategory').value = '';
        document.getElementById('formAuthor').value = '';
        document.getElementById('formImage').value = '';
        document.getElementById('formSummary').value = '';
        document.getElementById('submitBtn').innerHTML = '<i class="bx bx-save"></i> Lưu bài viết';
        document.getElementById('blogModal').classList.add('show');
    }
    
    // Open Edit Modal
    function openEditModal(id) {
        var card = document.querySelector('.blog-card[data-id="' + id + '"]');
        if (!card) return;
        
        document.getElementById('modalTitle').textContent = 'Chỉnh sửa bài viết';
        document.getElementById('formAction').value = 'edit';
        document.getElementById('formId').value = id;
        document.getElementById('formDate').value = card.dataset.date;
        document.getElementById('formTitle').value = card.dataset.title;
        document.getElementById('formCategory').value = card.dataset.category;
        document.getElementById('formAuthor').value = card.dataset.author;
        document.getElementById('formImage').value = card.dataset.image;
        document.getElementById('formSummary').value = card.dataset.summary;
        document.getElementById('submitBtn').innerHTML = '<i class="bx bx-save"></i> Cập nhật';
        document.getElementById('blogModal').classList.add('show');
    }
    
    // Close Modal
    function closeModal() {
        document.getElementById('blogModal').classList.remove('show');
    }
    
    // Confirm Delete from card
    function confirmDeleteFromCard(card) {
        var id = card.dataset.id;
        var title = card.dataset.title;
        confirmDelete(id, title);
    }
    
    // Confirm Delete from table row
    function confirmDeleteFromRow(row) {
        var id = row.dataset.id;
        var title = row.dataset.title;
        confirmDelete(id, title);
    }
    
    // Confirm Delete
    function confirmDelete(id, title) {
        document.getElementById('deleteId').value = id;
        document.getElementById('deleteMessage').textContent = 'Bài viết "' + title + '" sẽ bị xóa vĩnh viễn.';
        document.getElementById('deleteModal').classList.add('show');
    }
    
    // Close Delete Modal
    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.remove('show');
    }
    
    // Close on Escape
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeModal();
            closeDeleteModal();
        }
    });
    
    // Close modal on overlay click
    document.querySelectorAll('.modal-overlay').forEach(function(overlay) {
        overlay.addEventListener('click', function(e) {
            if (e.target === overlay) {
                closeModal();
                closeDeleteModal();
            }
        });
    });
</script>


