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
    <title>Quản lý Lịch hẹn - Admin</title>
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
        .stat-card.orange { background: linear-gradient(135deg, #ea580c 0%, #f97316 100%); }
        .stat-card.green { background: linear-gradient(135deg, #059669 0%, #10b981 100%); }
        .stat-card.purple { background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%); }
        .stat-card.red { background: linear-gradient(135deg, #dc2626 0%, #ef4444 100%); }

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
            min-width: 140px;
            background: white;
        }
        .filter-select:focus { outline: none; border-color: var(--accent-blue); }
        
        /* Quick Filters */
        .quick-filters {
            display: flex;
            gap: 10px;
            margin-top: 14px;
            padding-top: 14px;
            border-top: 1px solid #e2e8f0;
        }
        .quick-btn {
            padding: 8px 16px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            background: white;
            font-size: 0.85rem;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 6px;
            font-weight: 500;
        }
        .quick-btn:hover { 
            border-color: #3b82f6; 
            color: #3b82f6;
            background: #eff6ff;
        }
        .quick-btn.active { 
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%); 
            color: white; 
            border-color: #3b82f6;
            box-shadow: 0 2px 8px rgba(59, 130, 246, 0.3);
        }
        .filter-tag {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
            color: #2563eb;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        .filter-tag button {
            background: none;
            border: none;
            color: #2563eb;
            cursor: pointer;
            padding: 0;
            font-size: 1.1rem;
            line-height: 1;
        }
        .btn-reset {
            padding: 8px 14px;
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 0.85rem;
            color: #64748b;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s;
        }
        .btn-reset:hover { 
            background: #fee2e2;
            border-color: #fecaca;
            color: #dc2626;
        }

        /* Table Section */
        .table-section {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 24px;
            border-bottom: 1px solid #e2e8f0;
            background: #f8fafc;
        }
        .table-title { 
            font-weight: 600; 
            color: #0f172a;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1rem;
        }
        .table-title i {
            color: #64748b;
        }
        .table-actions { display: flex; gap: 10px; }
        .btn-danger-outline {
            padding: 10px 18px;
            border: 1px solid #ef4444;
            background: white;
            color: #ef4444;
            border-radius: 10px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }
        .btn-danger-outline:hover { 
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            border-color: #ef4444;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }
        
        /* Bulk Actions Bar */
        .bulk-actions {
            display: none;
            padding: 14px 24px;
            background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
            border-bottom: 1px solid #bfdbfe;
            align-items: center;
            gap: 14px;
        }
        .bulk-actions.show { display: flex; }
        .bulk-count { 
            font-size: 0.95rem; 
            color: #2563eb; 
            font-weight: 600;
        }
        .bulk-btn {
            padding: 8px 16px;
            border: 1px solid #e2e8f0;
            background: white;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s;
        }
        .bulk-btn:hover { background: #f8fafc; }
        .bulk-btn.danger { 
            border-color: #ef4444; 
            color: #ef4444; 
        }
        .bulk-btn.danger:hover { 
            background: #fef2f2; 
        }
        .bulk-btn.success { 
            border-color: #10b981; 
            color: #10b981; 
        }
        .bulk-btn.success:hover { 
            background: #ecfdf5; 
        }
        
        /* Data Table */
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th {
            text-align: left;
            padding: 14px 20px;
            font-size: 0.8rem;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
        }
        .data-table th.sortable { cursor: pointer; user-select: none; }
        .data-table th.sortable:hover { color: #3b82f6; }
        .data-table th .sort-icon { margin-left: 4px; opacity: 0.5; }
        .data-table th.sorted .sort-icon { opacity: 1; color: #3b82f6; }
        .data-table td {
            padding: 16px 20px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.9rem;
            color: #334155;
            vertical-align: middle;
        }
        .data-table tr:hover { background: #f8fafc; }
        .data-table tr.selected { background: #eff6ff; }

        /* Cell Styles */
        .cell-customer { min-width: 140px; }
        .customer-name { font-weight: 600; color: #0f172a; }
        .customer-phone { font-size: 0.8rem; color: #94a3b8; margin-top: 2px; }
        
        .cell-pet { min-width: 100px; }
        .pet-name { font-weight: 600; }
        .pet-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-top: 4px;
        }
        .pet-badge.dog { background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%); color: #b45309; }
        .pet-badge.cat { background: linear-gradient(135deg, #fce7f3 0%, #fbcfe8 100%); color: #be185d; }
        .pet-badge.other { background: linear-gradient(135deg, #e0e7ff 0%, #c7d2fe 100%); color: #4338ca; }
        
        .service-badge {
            display: inline-block;
            padding: 6px 14px;
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            border-radius: 8px;
            font-size: 0.85rem;
            color: #475569;
            font-weight: 500;
        }
        
        .cell-note {
            max-width: 150px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: #94a3b8;
            font-size: 0.85rem;
        }
        
        /* Status Badges - Modern Design */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        .status-badge i { font-size: 0.9rem; }
        .status-pending { background: linear-gradient(135deg, #fef9c3 0%, #fef08a 100%); color: #a16207; }
        .status-confirmed { background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%); color: #15803d; }
        .status-completed { background: linear-gradient(135deg, #f3e8ff 0%, #e9d5ff 100%); color: #7e22ce; }
        .status-rejected { background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%); color: #b91c1c; }
        .status-cancelled { background: linear-gradient(135deg, #f3f4f6 0%, #e5e7eb 100%); color: #4b5563; }
        
        /* Actions Menu */
        .actions-cell { position: relative; }
        .action-menu-btn {
            width: 36px;
            height: 36px;
            border: 1px solid #e2e8f0;
            background: white;
            border-radius: 10px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #64748b;
            font-size: 1.1rem;
            transition: all 0.2s;
        }
        .action-menu-btn:hover { 
            background: #eff6ff; 
            border-color: #3b82f6; 
            color: #3b82f6;
        }
        .action-menu {
            position: absolute;
            right: 0;
            top: 100%;
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            min-width: 180px;
            z-index: 100;
            display: none;
            overflow: hidden;
        }
        .action-menu.show { display: block; }
        .action-menu-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 16px;
            font-size: 0.9rem;
            color: #334155;
            cursor: pointer;
            transition: background 0.15s;
            border: none;
            background: none;
            width: 100%;
            text-align: left;
            font-weight: 500;
        }
        .action-menu-item:hover { background: #f8fafc; }
        .action-menu-item.success { color: #10b981; }
        .action-menu-item.success:hover { background: #ecfdf5; }
        .action-menu-item.danger { color: #ef4444; }
        .action-menu-item.danger:hover { background: #fef2f2; }
        .action-menu-item i { font-size: 1.1rem; width: 20px; }
        .action-divider { height: 1px; background: #e2e8f0; margin: 4px 0; }

        /* Drawer */
        .drawer-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.3);
            z-index: 1000;
            display: none;
        }
        .drawer-overlay.show { display: block; }
        .drawer {
            position: fixed;
            top: 0;
            right: -420px;
            width: 420px;
            height: 100vh;
            background: white;
            box-shadow: -4px 0 20px rgba(0,0,0,0.1);
            z-index: 1001;
            transition: right 0.3s ease;
            display: flex;
            flex-direction: column;
        }
        .drawer.show { right: 0; }
        .drawer-header {
            padding: 20px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .drawer-title { font-size: 1.1rem; font-weight: 600; }
        .drawer-close {
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
        .drawer-body { flex: 1; overflow-y: auto; padding: 20px; }
        .drawer-footer {
            padding: 16px 20px;
            border-top: 1px solid var(--border-color);
            display: flex;
            gap: 10px;
        }
        .detail-section { margin-bottom: 24px; }
        .detail-section-title {
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 12px;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid var(--border-color);
        }
        .detail-label { color: var(--text-secondary); font-size: 0.9rem; }
        .detail-value { font-weight: 500; color: var(--text-primary); font-size: 0.9rem; }
        
        /* Modal */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
            z-index: 2000;
            display: none;
            align-items: center;
            justify-content: center;
        }
        .modal-overlay.show { display: flex; }
        .modal-box {
            background: white;
            border-radius: 20px;
            width: 100%;
            max-width: 420px;
            overflow: hidden;
            box-shadow: 0 25px 60px rgba(0,0,0,0.25);
            margin: 20px;
        }
        .modal-header {
            padding: 28px;
            text-align: center;
        }
        .modal-icon {
            width: 72px;
            height: 72px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2rem;
        }
        .modal-icon.danger { background: #fee2e2; color: #ef4444; }
        .modal-icon.warning { background: #fef3c7; color: #f59e0b; }
        .modal-title { font-size: 1.2rem; font-weight: 700; margin-bottom: 10px; color: #0f172a; }
        .modal-desc { font-size: 0.95rem; color: #64748b; }
        .modal-footer {
            padding: 20px 28px;
            display: flex;
            gap: 12px;
            border-top: 1px solid #e2e8f0;
            background: #f8fafc;
        }
        .btn { 
            padding: 12px 24px; 
            border-radius: 10px; 
            font-size: 0.95rem; 
            font-weight: 600;
            cursor: pointer; 
            flex: 1; 
            border: none;
            transition: all 0.2s;
        }
        .btn-secondary { 
            background: white; 
            color: #334155;
            border: 1px solid #e2e8f0;
        }
        .btn-secondary:hover { background: #f1f5f9; }
        .btn-danger { 
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%); 
            color: white;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }
        .btn-danger:hover { 
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
        }
        .btn-success { 
            background: linear-gradient(135deg, #10b981 0%, #059669 100%); 
            color: white;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }
        .btn-success:hover { 
            background: linear-gradient(135deg, #059669 0%, #047857 100%);
        }
        .btn-primary { 
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%); 
            color: white;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }
        .btn-primary:hover { 
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #94a3b8;
        }
        .empty-state i { font-size: 4rem; margin-bottom: 20px; opacity: 0.4; }
        
        /* Checkbox */
        .custom-checkbox {
            width: 20px;
            height: 20px;
            border: 2px solid #e2e8f0;
            border-radius: 6px;
            cursor: pointer;
            appearance: none;
            transition: all 0.15s;
        }
        .custom-checkbox:checked {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            border-color: #3b82f6;
            background-image: url("data:image/svg+xml,%3csvg viewBox='0 0 16 16' fill='white' xmlns='http://www.w3.org/2000/svg'%3e%3cpath d='M12.207 4.793a1 1 0 010 1.414l-5 5a1 1 0 01-1.414 0l-2-2a1 1 0 011.414-1.414L6.5 9.086l4.293-4.293a1 1 0 011.414 0z'/%3e%3c/svg%3e");
        }
        
        /* Alert */
        .alert {
            padding: 16px 20px;
            border-radius: 12px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 500;
        }
        .alert-success { 
            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%); 
            color: #15803d;
            border: 1px solid #86efac;
        }
        .alert-error { 
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%); 
            color: #b91c1c;
            border: 1px solid #fca5a5;
        }
        .alert-close { 
            margin-left: auto; 
            background: none; 
            border: none; 
            cursor: pointer; 
            opacity: 0.7;
            padding: 6px;
            border-radius: 6px;
        }
        .alert-close:hover { opacity: 1; background: rgba(0,0,0,0.05); }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <jsp:include page="/components/admin-sidebar.jsp">
        <jsp:param name="currentPage" value="appointments"/>
    </jsp:include>

    <!-- Main Content -->
    <main class="admin-main">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title"><i class='bx bx-calendar'></i> Quản lý Lịch hẹn</h1>
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

        <!-- Stats Cards - Giống Dashboard -->
        <div class="stats-grid">
            <div class="stat-card orange" data-filter="Pending" onclick="filterByStatus('Pending')">
                <h3><i class='bx bx-time-five'></i> ${totalPending}</h3>
                <p>Chờ duyệt</p>
            </div>
            <div class="stat-card green" data-filter="Confirmed" onclick="filterByStatus('Confirmed')">
                <h3><i class='bx bx-check-circle'></i> ${totalConfirmed}</h3>
                <p>Đã duyệt</p>
            </div>
            <div class="stat-card purple" data-filter="Completed" onclick="filterByStatus('Completed')">
                <h3><i class='bx bx-badge-check'></i> ${totalCompleted}</h3>
                <p>Hoàn thành</p>
            </div>
            <div class="stat-card red" data-filter="Rejected" onclick="filterByStatus('Rejected')">
                <h3><i class='bx bx-x-circle'></i> ${totalRejected}</h3>
                <p>Từ chối</p>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="filter-row">
                <div class="search-box">
                    <i class='bx bx-search'></i>
                    <input type="text" id="searchInput" placeholder="Tìm theo tên, SĐT, thú cưng, bác sĩ..." onkeyup="applyFilters()">
                </div>
                <select class="filter-select" id="filterStatus" onchange="applyFilters()">
                    <option value="">Tất cả trạng thái</option>
                    <option value="Pending">Chờ duyệt</option>
                    <option value="Confirmed">Đã duyệt</option>
                    <option value="Completed">Hoàn thành</option>
                    <option value="Rejected">Từ chối</option>
                    <option value="Cancelled">Đã hủy</option>
                </select>
                <select class="filter-select" id="filterPetType" onchange="applyFilters()">
                    <option value="">Loại thú cưng</option>
                    <option value="Chó">Chó</option>
                    <option value="Mèo">Mèo</option>
                    <option value="Khác">Khác</option>
                </select>
                <input type="date" class="filter-select" id="filterDateFrom" onchange="applyFilters()" title="Từ ngày">
                <input type="date" class="filter-select" id="filterDateTo" onchange="applyFilters()" title="Đến ngày">
            </div>
            <div class="quick-filters">
                <button class="quick-btn" onclick="quickFilter('today')">
                    <i class='bx bx-calendar'></i> Hôm nay
                </button>
                <button class="quick-btn" onclick="quickFilter('week')">
                    <i class='bx bx-calendar-week'></i> 7 ngày tới
                </button>
                <button class="quick-btn" onclick="quickFilter('pending')">
                    <i class='bx bx-loader-circle'></i> Chưa xử lý
                </button>
                <div id="activeFilters" style="display: flex; gap: 8px; margin-left: auto;"></div>
                <button class="btn-reset" onclick="resetFilters()" id="resetBtn" style="display: none;">
                    <i class='bx bx-reset'></i> Xóa bộ lọc
                </button>
            </div>
        </div>

        <!-- Table Section -->
        <div class="table-section">
            <div class="table-header">
                <span class="table-title">
                    <i class='bx bx-list-ul'></i> Danh sách lịch hẹn
                    <span id="resultCount" style="font-weight: normal; color: var(--text-muted); font-size: 0.85rem;"></span>
                </span>
                <div class="table-actions">
                    <button class="btn-danger-outline" onclick="showDeleteAllCancelledModal()">
                        <i class='bx bx-trash'></i> Xóa tất cả đã hủy
                    </button>
                </div>
            </div>

            <!-- Bulk Actions Bar -->
            <div class="bulk-actions" id="bulkActions">
                <span class="bulk-count"><span id="selectedCount">0</span> đã chọn</span>
                <button class="bulk-btn success" onclick="bulkAction('approve')" id="bulkApprove">
                    <i class='bx bx-check'></i> Duyệt
                </button>
                <button class="bulk-btn" onclick="bulkAction('reject')" id="bulkReject">
                    <i class='bx bx-x'></i> Từ chối
                </button>
                <button class="bulk-btn danger" onclick="bulkAction('delete')" id="bulkDelete">
                    <i class='bx bx-trash'></i> Xóa
                </button>
                <button class="bulk-btn" onclick="clearSelection()" style="margin-left: auto;">
                    Bỏ chọn
                </button>
            </div>

            <!-- Data Table -->
            <table class="data-table">
                <thead>
                    <tr>
                        <th style="width: 40px;">
                            <input type="checkbox" class="custom-checkbox" id="selectAll" onchange="toggleSelectAll()">
                        </th>
                        <th style="width: 60px;">#ID</th>
                        <th class="sortable" onclick="sortTable('customer')">
                            Khách hàng <i class='bx bx-sort sort-icon'></i>
                        </th>
                        <th>Thú cưng</th>
                        <th>Dịch vụ</th>
                        <th>Bác sĩ</th>
                        <th class="sortable sorted" onclick="sortTable('date')" data-sort="desc">
                            Ngày hẹn <i class='bx bx-sort-down sort-icon'></i>
                        </th>
                        <th>Ghi chú</th>
                        <th>Trạng thái</th>
                        <th style="width: 60px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody id="appointmentsBody">
                    <c:if test="${empty appointments}">
                        <tr>
                            <td colspan="10">
                                <div class="empty-state">
                                    <i class='bx bx-calendar-x'></i>
                                    <p>Chưa có lịch hẹn nào</p>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach items="${appointments}" var="apt">
                        <tr data-id="${apt.id}" data-status="${apt.status}" data-pet-type="${apt.petType}" 
                            data-date="${apt.bookingDate}" data-customer="${apt.customerName}" 
                            data-phone="${apt.phone}" data-pet="${apt.petName}" data-doctor="${apt.doctorName}">
                            <td>
                                <input type="checkbox" class="custom-checkbox row-checkbox" 
                                       value="${apt.id}" onchange="updateBulkActions()">
                            </td>
                            <td><strong>#${apt.id}</strong></td>
                            <td class="cell-customer">
                                <div class="customer-name">${apt.customerName}</div>
                                <div class="customer-phone"><i class='bx bx-phone'></i> ${apt.phone}</div>
                            </td>
                            <td class="cell-pet">
                                <div class="pet-name">${apt.petName}</div>
                                <span class="pet-badge ${apt.petType == 'Chó' ? 'dog' : (apt.petType == 'Mèo' ? 'cat' : 'other')}">
                                    ${apt.petType}
                                </span>
                            </td>
                            <td><span class="service-badge">${apt.serviceName}</span></td>
                            <td>${apt.doctorName}</td>
                            <td><strong>${apt.bookingDate}</strong></td>
                            <td class="cell-note" title="${apt.note}">${apt.note != null ? apt.note : '-'}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${apt.status == 'Pending'}">
                                        <span class="status-badge status-pending"><i class='bx bx-time-five'></i> Chờ duyệt</span>
                                    </c:when>
                                    <c:when test="${apt.status == 'Confirmed'}">
                                        <span class="status-badge status-confirmed"><i class='bx bx-check'></i> Đã duyệt</span>
                                    </c:when>
                                    <c:when test="${apt.status == 'Completed'}">
                                        <span class="status-badge status-completed"><i class='bx bx-badge-check'></i> Hoàn thành</span>
                                    </c:when>
                                    <c:when test="${apt.status == 'Rejected'}">
                                        <span class="status-badge status-rejected"><i class='bx bx-x'></i> Từ chối</span>
                                    </c:when>
                                    <c:when test="${apt.status == 'Cancelled'}">
                                        <span class="status-badge status-cancelled"><i class='bx bx-block'></i> Đã hủy</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td class="actions-cell">
                                <button class="action-menu-btn" onclick="toggleActionMenu(this, event)">
                                    <i class='bx bx-dots-vertical-rounded'></i>
                                </button>
                                <div class="action-menu" data-status="${apt.status}" data-id="${apt.id}">
                                    <!-- Menu items will be populated by JS based on status -->
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

    <!-- Detail Drawer -->
    <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer()"></div>
    <div class="drawer" id="detailDrawer">
        <div class="drawer-header">
            <span class="drawer-title">Chi tiết lịch hẹn <span id="drawerAptId"></span></span>
            <button class="drawer-close" onclick="closeDrawer()"><i class='bx bx-x'></i></button>
        </div>
        <div class="drawer-body">
            <div class="detail-section">
                <div class="detail-section-title">Thông tin khách hàng</div>
                <div class="detail-row">
                    <span class="detail-label">Họ tên</span>
                    <span class="detail-value" id="drawerCustomer">-</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Số điện thoại</span>
                    <span class="detail-value" id="drawerPhone">-</span>
                </div>
            </div>
            <div class="detail-section">
                <div class="detail-section-title">Thông tin thú cưng</div>
                <div class="detail-row">
                    <span class="detail-label">Tên</span>
                    <span class="detail-value" id="drawerPet">-</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Loại</span>
                    <span class="detail-value" id="drawerPetType">-</span>
                </div>
            </div>
            <div class="detail-section">
                <div class="detail-section-title">Thông tin lịch hẹn</div>
                <div class="detail-row">
                    <span class="detail-label">Dịch vụ</span>
                    <span class="detail-value" id="drawerService">-</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Bác sĩ</span>
                    <span class="detail-value" id="drawerDoctor">-</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Ngày hẹn</span>
                    <span class="detail-value" id="drawerDate">-</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Trạng thái</span>
                    <span class="detail-value" id="drawerStatus">-</span>
                </div>
            </div>
            <div class="detail-section">
                <div class="detail-section-title">Ghi chú</div>
                <p id="drawerNote" style="color: var(--text-secondary); font-size: 0.9rem;">-</p>
            </div>
        </div>
        <div class="drawer-footer" id="drawerActions">
            <!-- Actions based on status -->
        </div>
    </div>

    <!-- Confirm Modal -->
    <div class="modal-overlay" id="confirmModal">
        <div class="modal-box">
            <div class="modal-header">
                <div class="modal-icon" id="modalIcon"><i class='bx bx-error'></i></div>
                <div class="modal-title" id="modalTitle">Xác nhận</div>
                <div class="modal-desc" id="modalDesc">Bạn có chắc chắn muốn thực hiện?</div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal()">Hủy bỏ</button>
                <button class="btn" id="modalConfirmBtn" onclick="executeModalAction()">Xác nhận</button>
            </div>
        </div>
    </div>

    <!-- Hidden Form for Actions -->
    <form id="actionForm" method="post" style="display: none;">
        <input type="hidden" name="id" id="actionId">
        <input type="hidden" name="action" id="actionType">
        <input type="hidden" name="ids" id="actionIds">
    </form>

    <jsp:include page="/components/scripts.jsp" />

    <script>
        // State
        var currentSort = { field: 'date', order: 'desc' };
        var selectedIds = [];
        var modalAction = null;
        var modalData = null;

        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            initActionMenus();
            updateResultCount();
            document.addEventListener('click', closeAllMenus);
        });

        // Action Menus based on status
        function initActionMenus() {
            document.querySelectorAll('.action-menu').forEach(function(menu) {
                var status = menu.dataset.status;
                var id = menu.dataset.id;
                var html = '';
                
                if (status === 'Pending') {
                    html = '<button class="action-menu-item success" onclick="doAction(\'approve\', ' + id + ')">' +
                           '<i class="bx bx-check"></i> Duyệt</button>' +
                           '<button class="action-menu-item danger" onclick="showConfirm(\'reject\', ' + id + ')">' +
                           '<i class="bx bx-x"></i> Từ chối</button>' +
                           '<div class="action-divider"></div>' +
                           '<button class="action-menu-item" onclick="openDrawer(' + id + ')">' +
                           '<i class="bx bx-show"></i> Xem chi tiết</button>';
                } else if (status === 'Confirmed') {
                    html = '<button class="action-menu-item success" onclick="doAction(\'complete\', ' + id + ')">' +
                           '<i class="bx bx-badge-check"></i> Hoàn thành</button>' +
                           '<button class="action-menu-item danger" onclick="showConfirm(\'cancel\', ' + id + ')">' +
                           '<i class="bx bx-block"></i> Hủy lịch</button>' +
                           '<div class="action-divider"></div>' +
                           '<button class="action-menu-item" onclick="openDrawer(' + id + ')">' +
                           '<i class="bx bx-show"></i> Xem chi tiết</button>';
                } else if (status === 'Completed') {
                    html = '<button class="action-menu-item" onclick="openDrawer(' + id + ')">' +
                           '<i class="bx bx-show"></i> Xem chi tiết</button>';
                } else if (status === 'Cancelled' || status === 'Rejected') {
                    html = '<button class="action-menu-item danger" onclick="showConfirm(\'delete\', ' + id + ')">' +
                           '<i class="bx bx-trash"></i> Xóa</button>' +
                           '<div class="action-divider"></div>' +
                           '<button class="action-menu-item" onclick="openDrawer(' + id + ')">' +
                           '<i class="bx bx-show"></i> Xem chi tiết</button>';
                }
                menu.innerHTML = html;
            });
        }

        function toggleActionMenu(btn, e) {
            e.stopPropagation();
            var menu = btn.nextElementSibling;
            var wasOpen = menu.classList.contains('show');
            closeAllMenus();
            if (!wasOpen) menu.classList.add('show');
        }

        function closeAllMenus() {
            document.querySelectorAll('.action-menu').forEach(function(m) { m.classList.remove('show'); });
        }

        // Filter Functions
        function filterByStatus(status) {
            document.querySelectorAll('.stat-card').forEach(function(c) { c.classList.remove('active'); });
            var card = document.querySelector('.stat-card[data-filter="' + status + '"]');
            if (card) card.classList.add('active');
            document.getElementById('filterStatus').value = status;
            applyFilters();
        }

        function quickFilter(type) {
            document.querySelectorAll('.quick-btn').forEach(function(b) { b.classList.remove('active'); });
            event.target.classList.add('active');
            
            var today = new Date().toISOString().split('T')[0];
            var weekLater = new Date(Date.now() + 7*24*60*60*1000).toISOString().split('T')[0];
            
            if (type === 'today') {
                document.getElementById('filterDateFrom').value = today;
                document.getElementById('filterDateTo').value = today;
            } else if (type === 'week') {
                document.getElementById('filterDateFrom').value = today;
                document.getElementById('filterDateTo').value = weekLater;
            } else if (type === 'pending') {
                document.getElementById('filterStatus').value = '';
            }
            applyFilters();
        }

        function applyFilters() {
            var search = document.getElementById('searchInput').value.toLowerCase();
            var status = document.getElementById('filterStatus').value;
            var petType = document.getElementById('filterPetType').value;
            var dateFrom = document.getElementById('filterDateFrom').value;
            var dateTo = document.getElementById('filterDateTo').value;
            
            var visibleCount = 0;
            document.querySelectorAll('#appointmentsBody tr[data-id]').forEach(function(row) {
                var rowStatus = row.dataset.status;
                var rowPetType = row.dataset.petType;
                var rowDate = row.dataset.date;
                var rowCustomer = row.dataset.customer.toLowerCase();
                var rowPhone = row.dataset.phone.toLowerCase();
                var rowPet = row.dataset.pet.toLowerCase();
                var rowDoctor = row.dataset.doctor.toLowerCase();
                
                var show = true;
                
                if (search && rowCustomer.indexOf(search) === -1 && rowPhone.indexOf(search) === -1 
                    && rowPet.indexOf(search) === -1 && rowDoctor.indexOf(search) === -1) {
                    show = false;
                }
                if (status && rowStatus !== status) show = false;
                if (petType && rowPetType !== petType) show = false;
                if (dateFrom && rowDate < dateFrom) show = false;
                if (dateTo && rowDate > dateTo) show = false;
                
                row.style.display = show ? '' : 'none';
                if (show) visibleCount++;
            });
            
            updateResultCount(visibleCount);
            updateActiveFilters();
            updateResetButton();
        }

        function resetFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('filterStatus').value = '';
            document.getElementById('filterPetType').value = '';
            document.getElementById('filterDateFrom').value = '';
            document.getElementById('filterDateTo').value = '';
            document.querySelectorAll('.stat-card').forEach(function(c) { c.classList.remove('active'); });
            document.querySelectorAll('.quick-btn').forEach(function(b) { b.classList.remove('active'); });
            applyFilters();
        }

        function updateActiveFilters() {
            var container = document.getElementById('activeFilters');
            var status = document.getElementById('filterStatus').value;
            var html = '';
            if (status) {
                var labels = {Pending:'Chờ duyệt',Confirmed:'Đã duyệt',Completed:'Hoàn thành',Rejected:'Từ chối',Cancelled:'Đã hủy'};
                html += '<span class="filter-tag">' + labels[status] + ' <button onclick="document.getElementById(\'filterStatus\').value=\'\';applyFilters()">×</button></span>';
            }
            container.innerHTML = html;
        }

        function updateResetButton() {
            var hasFilters = document.getElementById('searchInput').value || 
                              document.getElementById('filterStatus').value ||
                              document.getElementById('filterPetType').value ||
                              document.getElementById('filterDateFrom').value ||
                              document.getElementById('filterDateTo').value;
            document.getElementById('resetBtn').style.display = hasFilters ? '' : 'none';
        }

        function updateResultCount(count) {
            var total = document.querySelectorAll('#appointmentsBody tr[data-id]').length;
            count = count !== undefined ? count : total;
            document.getElementById('resultCount').textContent = count < total ? '(' + count + '/' + total + ')' : '(' + total + ')';
        }

        // Sorting
        function sortTable(field) {
            var th = event.target.closest('th');
            var currentOrder = th.dataset.sort || 'asc';
            var newOrder = currentOrder === 'asc' ? 'desc' : 'asc';
            
            document.querySelectorAll('.data-table th').forEach(function(h) {
                h.classList.remove('sorted');
                h.dataset.sort = '';
                var icon = h.querySelector('.sort-icon');
                if (icon) icon.className = 'bx bx-sort sort-icon';
            });
            
            th.classList.add('sorted');
            th.dataset.sort = newOrder;
            th.querySelector('.sort-icon').className = 'bx bx-sort-' + (newOrder === 'asc' ? 'up' : 'down') + ' sort-icon';
            
            var tbody = document.getElementById('appointmentsBody');
            var rows = Array.from(tbody.querySelectorAll('tr[data-id]'));
            
            rows.sort(function(a, b) {
                var valA, valB;
                if (field === 'date') {
                    valA = a.dataset.date;
                    valB = b.dataset.date;
                } else if (field === 'customer') {
                    valA = a.dataset.customer;
                    valB = b.dataset.customer;
                }
                if (newOrder === 'asc') return valA > valB ? 1 : -1;
                return valA < valB ? 1 : -1;
            });
            
            rows.forEach(function(row) { tbody.appendChild(row); });
        }

        // Selection & Bulk Actions
        function toggleSelectAll() {
            var checked = document.getElementById('selectAll').checked;
            document.querySelectorAll('.row-checkbox').forEach(function(cb) {
                if (cb.closest('tr').style.display !== 'none') {
                    cb.checked = checked;
                }
            });
            updateBulkActions();
        }

        function updateBulkActions() {
            var checkboxes = document.querySelectorAll('.row-checkbox:checked');
            selectedIds = Array.from(checkboxes).map(function(cb) { return cb.value; });
            
            var bulkBar = document.getElementById('bulkActions');
            if (selectedIds.length > 0) {
                bulkBar.classList.add('show');
                document.getElementById('selectedCount').textContent = selectedIds.length;
                
                var statuses = new Set();
                checkboxes.forEach(function(cb) {
                    statuses.add(cb.closest('tr').dataset.status);
                });
                
                document.getElementById('bulkApprove').style.display = statuses.has('Pending') ? '' : 'none';
                document.getElementById('bulkReject').style.display = statuses.has('Pending') ? '' : 'none';
                document.getElementById('bulkDelete').style.display = 
                    (statuses.has('Cancelled') || statuses.has('Rejected')) ? '' : 'none';
            } else {
                bulkBar.classList.remove('show');
            }
            
            document.querySelectorAll('#appointmentsBody tr').forEach(function(row) {
                row.classList.toggle('selected', row.querySelector('.row-checkbox:checked') !== null);
            });
        }

        function clearSelection() {
            document.getElementById('selectAll').checked = false;
            document.querySelectorAll('.row-checkbox').forEach(function(cb) { cb.checked = false; });
            updateBulkActions();
        }

        function bulkAction(action) {
            if (selectedIds.length === 0) return;
            
            var messages = {
                approve: { title: 'Duyệt lịch hẹn', desc: 'Duyệt ' + selectedIds.length + ' lịch hẹn đã chọn?', type: 'success' },
                reject: { title: 'Từ chối lịch hẹn', desc: 'Từ chối ' + selectedIds.length + ' lịch hẹn đã chọn?', type: 'warning' },
                delete: { title: 'Xóa lịch hẹn', desc: 'Xóa vĩnh viễn ' + selectedIds.length + ' lịch hẹn? Không thể hoàn tác!', type: 'danger' }
            };
            
            showModal(messages[action].title, messages[action].desc, messages[action].type, function() {
                document.getElementById('actionIds').value = selectedIds.join(',');
                document.getElementById('actionType').value = 'bulk_' + action;
                document.getElementById('actionForm').submit();
            });
        }

        // Single Actions
        function doAction(action, id) {
            document.getElementById('actionId').value = id;
            document.getElementById('actionType').value = action;
            document.getElementById('actionForm').submit();
        }

        function showConfirm(action, id) {
            closeAllMenus();
            var messages = {
                reject: { title: 'Từ chối lịch hẹn?', desc: 'Lịch hẹn sẽ bị từ chối và thông báo cho khách hàng.', type: 'warning' },
                cancel: { title: 'Hủy lịch hẹn?', desc: 'Lịch hẹn đã duyệt sẽ bị hủy.', type: 'warning' },
                delete: { title: 'Xóa lịch hẹn?', desc: 'Lịch hẹn sẽ bị xóa vĩnh viễn. Không thể hoàn tác!', type: 'danger' }
            };
            
            showModal(messages[action].title, messages[action].desc, messages[action].type, function() {
                doAction(action, id);
            });
        }

        function showDeleteAllCancelledModal() {
            var cancelledCount = document.querySelectorAll('tr[data-status="Cancelled"]').length;
            if (cancelledCount === 0) {
                alert('Không có lịch hẹn đã hủy nào để xóa.');
                return;
            }
            showModal(
                'Xóa tất cả lịch đã hủy?',
                'Sẽ xóa vĩnh viễn ' + cancelledCount + ' lịch hẹn đã hủy. Không thể hoàn tác!',
                'danger',
                function() {
                    document.getElementById('actionType').value = 'delete_all_cancelled';
                    document.getElementById('actionForm').submit();
                }
            );
        }

        // Modal
        function showModal(title, desc, type, callback) {
            document.getElementById('modalTitle').textContent = title;
            document.getElementById('modalDesc').textContent = desc;
            
            var icon = document.getElementById('modalIcon');
            var btn = document.getElementById('modalConfirmBtn');
            
            icon.className = 'modal-icon ' + (type === 'danger' ? 'danger' : 'warning');
            icon.innerHTML = type === 'danger' ? '<i class="bx bx-trash"></i>' : '<i class="bx bx-error"></i>';
            
            btn.className = 'btn ' + (type === 'danger' ? 'btn-danger' : (type === 'success' ? 'btn-success' : 'btn-primary'));
            btn.textContent = type === 'danger' ? 'Xóa' : 'Xác nhận';
            
            modalAction = callback;
            document.getElementById('confirmModal').classList.add('show');
        }

        function closeModal() {
            document.getElementById('confirmModal').classList.remove('show');
            modalAction = null;
        }

        function executeModalAction() {
            if (modalAction) modalAction();
            closeModal();
        }

        // Drawer
        function openDrawer(id) {
            closeAllMenus();
            var row = document.querySelector('tr[data-id="' + id + '"]');
            if (!row) return;
            
            document.getElementById('drawerAptId').textContent = '#' + id;
            document.getElementById('drawerCustomer').textContent = row.dataset.customer;
            document.getElementById('drawerPhone').textContent = row.dataset.phone;
            document.getElementById('drawerPet').textContent = row.dataset.pet;
            document.getElementById('drawerPetType').textContent = row.dataset.petType;
            document.getElementById('drawerService').textContent = row.querySelector('.service-badge').textContent;
            document.getElementById('drawerDoctor').textContent = row.dataset.doctor;
            document.getElementById('drawerDate').textContent = row.dataset.date;
            document.getElementById('drawerStatus').innerHTML = row.querySelector('.status-badge').outerHTML;
            document.getElementById('drawerNote').textContent = row.querySelector('.cell-note').textContent || '-';
            
            var status = row.dataset.status;
            var actionsHtml = '';
            if (status === 'Pending') {
                actionsHtml = '<button class="btn btn-success" onclick="doAction(\'approve\', ' + id + ')"><i class="bx bx-check"></i> Duyệt</button>' +
                              '<button class="btn btn-secondary" onclick="showConfirm(\'reject\', ' + id + ')">Từ chối</button>';
            } else if (status === 'Confirmed') {
                actionsHtml = '<button class="btn btn-primary" onclick="doAction(\'complete\', ' + id + ')"><i class="bx bx-badge-check"></i> Hoàn thành</button>' +
                              '<button class="btn btn-secondary" onclick="showConfirm(\'cancel\', ' + id + ')">Hủy lịch</button>';
            } else if (status === 'Cancelled' || status === 'Rejected') {
                actionsHtml = '<button class="btn btn-danger" onclick="showConfirm(\'delete\', ' + id + ')"><i class="bx bx-trash"></i> Xóa</button>';
            }
            document.getElementById('drawerActions').innerHTML = actionsHtml || '<span style="color:var(--text-muted)">Không có thao tác</span>';
            
            document.getElementById('drawerOverlay').classList.add('show');
            document.getElementById('detailDrawer').classList.add('show');
        }

        function closeDrawer() {
            document.getElementById('drawerOverlay').classList.remove('show');
            document.getElementById('detailDrawer').classList.remove('show');
        }

        // Close modal on Escape
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeModal();
                closeDrawer();
            }
        });
    </script>
</body>
</html>
