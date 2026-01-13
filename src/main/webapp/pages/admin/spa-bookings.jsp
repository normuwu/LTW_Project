<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="/components/meta.jsp" />
    <title>Quản lý Spa & Grooming - Admin</title>
    <jsp:include page="/components/head.jsp" />
    <jsp:include page="/components/admin-styles.jsp" />
    <style>
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
        }
        .stat-card h3 {
            font-size: 2.2rem;
            margin: 0 0 8px 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .stat-card p { margin: 0; opacity: 0.9; font-size: 0.95rem; }
        .stat-card.orange { background: linear-gradient(135deg, #ea580c 0%, #f97316 100%); }
        .stat-card.green { background: linear-gradient(135deg, #059669 0%, #10b981 100%); }
        .stat-card.purple { background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%); }
        .stat-card.pink { background: linear-gradient(135deg, #db2777 0%, #ec4899 100%); }

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
            background: linear-gradient(135deg, #db2777 0%, #ec4899 100%);
            color: white;
        }
        .table-title { 
            font-weight: 700; 
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.1rem;
        }
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th {
            text-align: left;
            padding: 16px 20px;
            font-size: 0.8rem;
            font-weight: 700;
            color: #475569;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            background: #f8fafc;
            border-bottom: 2px solid #e2e8f0;
        }
        .data-table td {
            padding: 18px 20px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.9rem;
            color: #334155;
            vertical-align: top;
        }
        .data-table tr:hover { background: #f8fafc; }
        
        .customer-name { font-weight: 700; color: #0f172a; }
        .customer-phone { font-size: 0.8rem; color: #94a3b8; margin-top: 3px; }
        .pet-info { display: flex; align-items: center; gap: 8px; }
        .pet-name { font-weight: 600; color: #1e293b; }
        .pet-type-badge {
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .pet-dog { background: #fef3c7; color: #92400e; }
        .pet-cat { background: #fce7f3; color: #9d174d; }
        .pet-other { background: #e0e7ff; color: #3730a3; }
        
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
        }
        .status-pending { background: #fef08a; color: #854d0e; }
        .status-confirmed { background: #86efac; color: #14532d; }
        .status-completed { background: #c084fc; color: #581c87; }
        .status-cancelled { background: #fca5a5; color: #7f1d1d; }
        
        .booking-details {
            background: #fdf2f8;
            border-radius: 8px;
            padding: 12px;
            font-size: 0.85rem;
            max-width: 280px;
        }
        .booking-details .detail-item {
            display: flex;
            gap: 8px;
            margin-bottom: 6px;
            color: #475569;
        }
        .booking-details .detail-item:last-child { margin-bottom: 0; }
        .booking-details .detail-label { 
            font-weight: 600; 
            color: #db2777;
            min-width: 50px;
        }
        
        .actions-cell {
            min-width: 260px;
        }
        .action-btn {
            padding: 10px 18px !important;
            border-radius: 10px !important;
            font-size: 0.9rem !important;
            font-weight: 700 !important;
            cursor: pointer;
            display: inline-flex !important;
            align-items: center !important;
            gap: 6px !important;
            transition: all 0.2s;
            margin-right: 16px;
            margin-bottom: 6px;
            white-space: nowrap;
            vertical-align: middle;
            border: none !important;
        }
        .action-btn i {
            font-size: 1rem !important;
        }
        .btn-approve { background: #22c55e !important; color: #ffffff !important; }
        .btn-approve:hover { background: #16a34a !important; }
        .btn-complete { background: #8b5cf6 !important; color: #ffffff !important; }
        .btn-complete:hover { background: #7c3aed !important; }
        .btn-cancel { background: #ef4444 !important; color: #ffffff !important; }
        .btn-cancel:hover { background: #dc2626 !important; }
        .btn-delete { background: #f87171 !important; color: #ffffff !important; }
        .btn-delete:hover { background: #ef4444 !important; }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #94a3b8;
        }
        .empty-state i { font-size: 4rem; margin-bottom: 16px; opacity: 0.4; }
        
        .filter-section {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 16px 20px;
            margin-bottom: 20px;
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
        }
        .filter-select {
            padding: 10px 14px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 0.9rem;
            min-width: 160px;
        }
        .search-box {
            position: relative;
            flex: 1;
            min-width: 200px;
        }
        .search-box input {
            width: 100%;
            padding: 10px 14px 10px 40px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 0.9rem;
        }
        .search-box i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
        }
    </style>
</head>
<body>
    <jsp:include page="/components/admin-sidebar.jsp">
        <jsp:param name="currentPage" value="spa"/>
    </jsp:include>

    <main class="admin-main">
        <div class="page-header">
            <h1 class="page-title"><i class='bx bxs-spa'></i> Quản lý Spa & Grooming</h1>
            <jsp:include page="/components/admin-header-dropdown.jsp" />
        </div>

        <!-- Stats -->
        <div class="stats-grid">
            <div class="stat-card orange">
                <h3><i class='bx bx-time-five'></i> ${totalPending}</h3>
                <p>Chờ xác nhận</p>
            </div>
            <div class="stat-card green">
                <h3><i class='bx bx-check-circle'></i> ${totalConfirmed}</h3>
                <p>Đã xác nhận</p>
            </div>
            <div class="stat-card purple">
                <h3><i class='bx bx-badge-check'></i> ${totalCompleted}</h3>
                <p>Hoàn thành</p>
            </div>
            <div class="stat-card pink">
                <h3><i class='bx bx-list-ul'></i> ${totalBookings}</h3>
                <p>Tổng lịch spa</p>
            </div>
        </div>

        <!-- Filter -->
        <div class="filter-section">
            <div class="search-box">
                <i class='bx bx-search'></i>
                <input type="text" id="searchInput" placeholder="Tìm theo tên, SĐT, thú cưng..." onkeyup="filterTable()">
            </div>
            <select class="filter-select" id="filterStatus" onchange="filterTable()">
                <option value="">Tất cả trạng thái</option>
                <option value="Pending">Chờ xác nhận</option>
                <option value="Confirmed">Đã xác nhận</option>
                <option value="Completed">Hoàn thành</option>
                <option value="Cancelled">Đã hủy</option>
            </select>
            <select class="filter-select" id="filterPetType" onchange="filterTable()">
                <option value="">Loại thú cưng</option>
                <option value="Chó">Chó</option>
                <option value="Mèo">Mèo</option>
                <option value="Khác">Khác</option>
            </select>
        </div>

        <!-- Table -->
        <div class="table-section">
            <div class="table-header">
                <span class="table-title">
                    <i class='bx bxs-spa'></i> Danh sách lịch Spa & Grooming
                </span>
            </div>
            
            <c:choose>
                <c:when test="${empty bookings}">
                    <div class="empty-state">
                        <i class='bx bxs-spa'></i>
                        <p>Chưa có lịch spa nào</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="data-table" id="bookingsTable">
                        <thead>
                            <tr>
                                <th>Khách hàng</th>
                                <th>Thú cưng</th>
                                <th>Ngày hẹn</th>
                                <th>Chi tiết dịch vụ</th>
                                <th>Trạng thái</th>
                                <th class="actions-cell">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${bookings}">
                                <tr data-status="${booking.status}" data-pettype="${booking.petType}">
                                    <td>
                                        <div class="customer-name">${booking.customerName}</div>
                                        <div class="customer-phone"><i class='bx bx-phone'></i> ${booking.phone}</div>
                                    </td>
                                    <td>
                                        <div class="pet-info">
                                            <span class="pet-name">${booking.petName}</span>
                                        </div>
                                        <c:choose>
                                            <c:when test="${booking.petType == 'Chó'}">
                                                <span class="pet-type-badge pet-dog">🐕 Chó</span>
                                            </c:when>
                                            <c:when test="${booking.petType == 'Mèo'}">
                                                <span class="pet-type-badge pet-cat">🐱 Mèo</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="pet-type-badge pet-other">🐾 ${booking.petType}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td>
                                        <div class="booking-details">
                                            <c:if test="${not empty booking.note}">
                                                <c:set var="noteLines" value="${booking.note}"/>
                                                <c:forTokens var="line" items="${noteLines}" delims="|">
                                                    <div class="detail-item">
                                                        <span>${line}</span>
                                                    </div>
                                                </c:forTokens>
                                            </c:if>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${booking.status == 'Pending'}">
                                                <span class="status-badge status-pending"><i class='bx bx-time'></i> Chờ xác nhận</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'Confirmed'}">
                                                <span class="status-badge status-confirmed"><i class='bx bx-check'></i> Đã xác nhận</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'Completed'}">
                                                <span class="status-badge status-completed"><i class='bx bx-badge-check'></i> Hoàn thành</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-cancelled"><i class='bx bx-x'></i> Đã hủy</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${booking.status == 'Pending'}">
                                            <form action="${pageContext.request.contextPath}/admin/spa-bookings" method="POST" style="display:inline;">
                                                <input type="hidden" name="action" value="updateStatus">
                                                <input type="hidden" name="id" value="${booking.id}">
                                                <input type="hidden" name="status" value="Confirmed">
                                                <button type="submit" class="action-btn btn-approve">
                                                    <i class='bx bx-check'></i> Duyệt
                                                </button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/admin/spa-bookings" method="POST" style="display:inline;">
                                                <input type="hidden" name="action" value="updateStatus">
                                                <input type="hidden" name="id" value="${booking.id}">
                                                <input type="hidden" name="status" value="Cancelled">
                                                <button type="submit" class="action-btn btn-cancel">
                                                    <i class='bx bx-x'></i> Từ chối
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${booking.status == 'Confirmed'}">
                                            <form action="${pageContext.request.contextPath}/admin/spa-bookings" method="POST" style="display:inline;">
                                                <input type="hidden" name="action" value="updateStatus">
                                                <input type="hidden" name="id" value="${booking.id}">
                                                <input type="hidden" name="status" value="Completed">
                                                <button type="submit" class="action-btn btn-complete">
                                                    <i class='bx bx-badge-check'></i> Hoàn thành
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${booking.status == 'Completed' || booking.status == 'Cancelled'}">
                                            <form action="${pageContext.request.contextPath}/admin/spa-bookings" method="POST" style="display:inline;" 
                                                  onsubmit="return confirm('Bạn có chắc muốn xóa lịch spa này?');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${booking.id}">
                                                <button type="submit" class="action-btn btn-delete">
                                                    <i class='bx bx-trash'></i> Xóa
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <jsp:include page="/components/toast.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterTable() {
            const searchText = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('filterStatus').value;
            const petTypeFilter = document.getElementById('filterPetType').value;
            const rows = document.querySelectorAll('#bookingsTable tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                const status = row.dataset.status;
                const petType = row.dataset.pettype;
                
                const matchSearch = text.includes(searchText);
                const matchStatus = !statusFilter || status === statusFilter;
                const matchPetType = !petTypeFilter || petType === petTypeFilter;
                
                row.style.display = (matchSearch && matchStatus && matchPetType) ? '' : 'none';
            });
        }
    </script>
</body>
</html>
