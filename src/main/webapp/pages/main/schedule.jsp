<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Chuyển session messages sang request scope để hiển thị và xóa --%>
<c:if test="${not empty sessionScope.success}">
    <c:set var="success" value="${sessionScope.success}" scope="request"/>
    <c:remove var="success" scope="session"/>
</c:if>
<c:if test="${not empty sessionScope.error}">
    <c:set var="error" value="${sessionScope.error}" scope="request"/>
    <c:remove var="error" scope="session"/>
</c:if>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Lịch Hẹn Của Tôi - Animal Doctors</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap');
        
        :root {
            --primary: #00bfa5;
            --primary-dark: #00897b;
            --primary-light: #e0f2f1;
            --secondary: #ff7043;
            --dark: #263238;
            --gray: #607d8b;
            --light-gray: #eceff1;
            --white: #ffffff;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --purple: #8b5cf6;
        }
        
        body {
            font-family: 'Nunito', sans-serif;
            background: linear-gradient(135deg, #e0f7fa 0%, #f5f5f5 50%, #fff8e1 100%);
            min-height: 100vh;
            padding-top: 80px !important;
        }
        
        /* Navbar font override - giữ nguyên Montserrat cho navbar */
        nav#navbar-main,
        nav#navbar-main * {
            font-family: 'Montserrat', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
        }
        nav#navbar-main i.bx {
            font-family: 'boxicons' !important;
        }
        
        /* Fix dropdown z-index - CRITICAL */
        .dropdown-menu {
            z-index: 999999 !important;
            position: absolute !important;
        }
        
        /* Fix navbar dropdown */
        nav#navbar-main .dropdown-menu {
            z-index: 999999 !important;
            position: absolute !important;
            top: 100% !important;
            right: 0 !important;
            left: auto !important;
        }
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
            padding: 60px 0 100px;
            color: white;
            position: relative;
            overflow: hidden;
        }
        .page-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 400px;
            height: 400px;
            background: rgba(255,255,255,0.08);
            border-radius: 50%;
        }
        .page-header::after {
            content: '';
            position: absolute;
            bottom: -30%;
            left: -5%;
            width: 300px;
            height: 300px;
            background: rgba(255,255,255,0.05);
            border-radius: 50%;
        }
        .page-header h1 { 
            font-weight: 800; 
            font-size: 2.2rem;
            position: relative;
            z-index: 1;
        }
        .page-header h1 i {
            margin-right: 12px;
        }
        .page-header p { 
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }
        .page-header .btn-light {
            background: white;
            color: var(--primary-dark);
            border: none;
            padding: 12px 28px;
            border-radius: 50px;
            font-weight: 700;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s;
        }
        .page-header .btn-light:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        /* Stats Cards */
        .stats-row {
            margin-top: -60px;
            position: relative;
            z-index: 10;
        }
        .stat-card {
            background: white;
            border-radius: 20px;
            padding: 24px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
            display: flex;
            align-items: center;
            gap: 18px;
            transition: all 0.3s;
            border: 1px solid rgba(0,0,0,0.03);
        }
        .stat-card:hover { 
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.12);
        }
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            color: white;
        }
        .stat-icon.pending { background: linear-gradient(135deg, #fbbf24, #f59e0b); }
        .stat-icon.confirmed { background: linear-gradient(135deg, #34d399, #10b981); }
        .stat-icon.completed { background: linear-gradient(135deg, #a78bfa, #8b5cf6); }
        .stat-number { 
            font-size: 2rem; 
            font-weight: 800; 
            color: var(--dark);
            line-height: 1;
        }
        .stat-label { 
            font-size: 0.9rem; 
            color: var(--gray);
            margin-top: 4px;
        }

        /* Appointment Cards */
        .appointment-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
            overflow: hidden;
            transition: all 0.3s ease;
            border: 1px solid rgba(0,0,0,0.03);
            margin-bottom: 24px;
        }
        .appointment-card:hover {
            box-shadow: 0 12px 40px rgba(0,0,0,0.12);
            transform: translateY(-6px);
        }
        .card-status-bar {
            height: 5px;
            width: 100%;
        }
        .card-status-bar.pending { background: linear-gradient(90deg, #fbbf24, #f59e0b); }
        .card-status-bar.confirmed { background: linear-gradient(90deg, #34d399, #10b981); }
        .card-status-bar.completed { background: linear-gradient(90deg, #a78bfa, #8b5cf6); }
        .card-status-bar.rejected { background: linear-gradient(90deg, #f87171, #ef4444); }
        .card-status-bar.cancelled { background: linear-gradient(90deg, #9ca3af, #6b7280); }

        .card-header-custom {
            padding: 24px 24px 12px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }
        .appointment-id {
            font-size: 0.8rem;
            color: var(--gray);
            margin-bottom: 6px;
            font-weight: 600;
        }
        .service-name {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--dark);
        }
        
        /* Status Badges */
        .status-badge {
            padding: 8px 16px;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .status-badge i { font-size: 1rem; }
        .status-pending { background: #fef3c7; color: #b45309; }
        .status-confirmed { background: #d1fae5; color: #047857; }
        .status-completed { background: #ede9fe; color: #6d28d9; }
        .status-rejected { background: #fee2e2; color: #b91c1c; }
        .status-cancelled { background: #f3f4f6; color: #4b5563; }

        /* Card Body */
        .card-body-custom { padding: 12px 24px 24px; }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
            margin-bottom: 18px;
        }
        .info-item {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .info-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            background: var(--primary-light);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-dark);
            font-size: 1.1rem;
        }
        .info-label { 
            font-size: 0.75rem; 
            color: var(--gray);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .info-value { 
            font-size: 0.95rem; 
            font-weight: 600; 
            color: var(--dark);
        }

        /* Note Section */
        .note-section {
            background: linear-gradient(135deg, #fff8e1, #ffecb3);
            border-radius: 12px;
            padding: 14px 18px;
            margin-bottom: 18px;
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }
        .note-section i { 
            color: #ff8f00;
            font-size: 1.2rem;
            flex-shrink: 0;
        }
        .note-section span { 
            font-size: 0.9rem; 
            color: #5d4037;
            line-height: 1.5;
        }

        /* Action Buttons */
        .card-actions {
            display: flex;
            gap: 12px;
            padding-top: 18px;
            border-top: 1px solid var(--light-gray);
        }
        .btn-action {
            flex: 1;
            padding: 14px 20px;
            border-radius: 12px;
            font-size: 0.95rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.25s;
            border: none;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        .btn-edit {
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            color: white;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.35);
        }
        .btn-edit:hover { 
            background: linear-gradient(135deg, #4f46e5, #4338ca);
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(99, 102, 241, 0.45);
        }
        .btn-cancel {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.35);
        }
        .btn-cancel:hover { 
            background: linear-gradient(135deg, #dc2626, #b91c1c);
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(239, 68, 68, 0.45);
        }
        .btn-rebook {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.35);
        }
        .btn-rebook:hover { 
            background: linear-gradient(135deg, #059669, #047857);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.45);
        }
        .btn-detail {
            background: linear-gradient(135deg, #64748b, #475569);
            color: white;
            box-shadow: 0 4px 15px rgba(100, 116, 139, 0.3);
        }
        .btn-detail:hover {
            background: linear-gradient(135deg, #475569, #334155);
            transform: translateY(-3px);
        }
        .btn-delete {
            background: linear-gradient(135deg, #f87171, #ef4444);
            color: white;
            box-shadow: 0 4px 15px rgba(248, 113, 113, 0.35);
        }
        .btn-delete:hover { 
            background: linear-gradient(135deg, #ef4444, #dc2626);
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(248, 113, 113, 0.45);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 100px 20px;
            background: white;
            border-radius: 24px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
        }
        .empty-icon {
            width: 140px;
            height: 140px;
            background: linear-gradient(135deg, var(--primary-light), #b2dfdb);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
        }
        .empty-icon i { 
            font-size: 4rem; 
            color: var(--primary);
        }
        .empty-state h4 { 
            color: var(--dark); 
            margin-bottom: 12px;
            font-weight: 700;
            font-size: 1.4rem;
        }
        .empty-state p { 
            color: var(--gray); 
            margin-bottom: 30px;
            font-size: 1rem;
            line-height: 1.6;
        }

        /* Filter Tabs */
        .filter-tabs {
            display: flex;
            gap: 12px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        .filter-tab {
            padding: 10px 22px;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 600;
            border: 2px solid var(--light-gray);
            background: white;
            color: var(--gray);
            cursor: pointer;
            transition: all 0.2s;
        }
        .filter-tab:hover { 
            border-color: var(--primary); 
            color: var(--primary);
        }
        .filter-tab.active {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            border-color: var(--primary);
            box-shadow: 0 4px 15px rgba(0, 191, 165, 0.3);
        }

        /* Card Inactive State */
        .appointment-card.inactive {
            opacity: 0.7;
            background: #fafafa;
        }
        .appointment-card.inactive .service-name,
        .appointment-card.inactive .info-value { color: var(--gray); }


</head>
<body>
    <jsp:include page="/components/navbar.jsp" />
    <jsp:include page="/components/toast-notification.jsp" />

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1><i class='bx bx-calendar-check'></i> Lịch Hẹn Của Tôi</h1>
                    <p class="mb-0">Quản lý và theo dõi các lịch hẹn khám bệnh cho thú cưng của bạn</p>
                </div>
                <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <a href="${pageContext.request.contextPath}/booking" class="btn btn-light btn-lg">
                        <i class='bx bx-plus'></i> Đặt lịch mới
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Row -->
    <section class="container stats-row">
        <div class="row g-3">
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-icon pending"><i class='bx bx-time-five'></i></div>
                    <div>
                        <div class="stat-number" id="countPending">0</div>
                        <div class="stat-label">Chờ xác nhận</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-icon confirmed"><i class='bx bx-check-circle'></i></div>
                    <div>
                        <div class="stat-number" id="countConfirmed">0</div>
                        <div class="stat-label">Đã xác nhận</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-icon completed"><i class='bx bx-badge-check'></i></div>
                    <div>
                        <div class="stat-number" id="countCompleted">0</div>
                        <div class="stat-label">Hoàn thành</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <section class="py-5">
        <div class="container">            <!-- Filter Tabs -->
            <div class="filter-tabs">
                <button class="filter-tab active" data-filter="all">Tất cả</button>
                <button class="filter-tab" data-filter="Pending">Chờ xác nhận</button>
                <button class="filter-tab" data-filter="Confirmed">Đã xác nhận</button>
                <button class="filter-tab" data-filter="Completed">Hoàn thành</button>
                <button class="filter-tab" data-filter="Cancelled">Đã hủy</button>
            </div>

            <!-- Appointments List -->
            <c:choose>
                <c:when test="${empty mySchedule}">
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class='bx bx-calendar-x'></i>
                        </div>
                        <h4>Chưa có lịch hẹn nào</h4>
                        <p>Bạn chưa đặt lịch hẹn khám bệnh cho thú cưng.<br>Hãy đặt lịch ngay để được chăm sóc tốt nhất!</p>
                        <a href="${pageContext.request.contextPath}/booking" class="btn btn-rebook btn-lg px-4">
                            <i class='bx bx-plus'></i> Đặt lịch ngay
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row" id="appointmentsList">
                        <c:forEach items="${mySchedule}" var="apt">
                            <div class="col-lg-6 col-12 appointment-item" data-status="${apt.status}" data-id="${apt.id}">
                                <div class="appointment-card ${apt.status == 'Cancelled' ? 'inactive' : ''}">
                                    <div class="card-status-bar ${apt.status.toLowerCase()}"></div>
                                    <div class="card-header-custom">
                                        <div>
                                            <div class="appointment-id">#${apt.id}</div>
                                            <div class="service-name">${apt.serviceName}</div>
                                        </div>
                                        <c:choose>
                                            <c:when test="${apt.status == 'Pending'}">
                                                <span class="status-badge status-pending">
                                                    <i class='bx bx-time-five'></i> Chờ xác nhận
                                                </span>
                                            </c:when>
                                            <c:when test="${apt.status == 'Confirmed'}">
                                                <span class="status-badge status-confirmed">
                                                    <i class='bx bx-check-circle'></i> Đã xác nhận
                                                </span>
                                            </c:when>
                                            <c:when test="${apt.status == 'Completed'}">
                                                <span class="status-badge status-completed">
                                                    <i class='bx bx-badge-check'></i> Hoàn thành
                                                </span>
                                            </c:when>
                                            <c:when test="${apt.status == 'Rejected'}">
                                                <span class="status-badge status-rejected">
                                                    <i class='bx bx-x-circle'></i> Từ chối
                                                </span>
                                            </c:when>
                                            <c:when test="${apt.status == 'Cancelled'}">
                                                <span class="status-badge status-cancelled">
                                                    <i class='bx bx-block'></i> Đã hủy
                                                </span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                    <div class="card-body-custom">
                                        <div class="info-grid">
                                            <div class="info-item">
                                                <div class="info-icon"><i class='bx bx-user'></i></div>
                                                <div>
                                                    <div class="info-label">Khách hàng</div>
                                                    <div class="info-value">${apt.customerName}</div>
                                                </div>
                                            </div>
                                            <div class="info-item">
                                                <div class="info-icon"><i class='bx bx-phone'></i></div>
                                                <div>
                                                    <div class="info-label">Số điện thoại</div>
                                                    <div class="info-value">${apt.phone}</div>
                                                </div>
                                            </div>
                                            <div class="info-item">
                                                <div class="info-icon"><i class='bx bxs-dog'></i></div>
                                                <div>
                                                    <div class="info-label">Thú cưng</div>
                                                    <div class="info-value">${apt.petName} (${apt.petType})</div>
                                                </div>
                                            </div>
                                            <div class="info-item">
                                                <div class="info-icon"><i class='bx bx-calendar'></i></div>
                                                <div>
                                                    <div class="info-label">Ngày hẹn</div>
                                                    <div class="info-value">${apt.bookingDate}</div>
                                                </div>
                                            </div>
                                            <div class="info-item">
                                                <div class="info-icon"><i class='bx bx-user-circle'></i></div>
                                                <div>
                                                    <div class="info-label">Bác sĩ</div>
                                                    <div class="info-value">${apt.doctorName}</div>
                                                </div>
                                            </div>
                                        </div>

                                        <c:if test="${not empty apt.note}">
                                            <div class="note-section">
                                                <i class='bx bx-note me-2'></i>
                                                <span>${apt.note}</span>
                                            </div>
                                        </c:if>

                                        <div class="card-actions">
                                            <c:choose>
                                                <c:when test="${apt.status == 'Pending'}">
                                                    <button class="btn-action btn-edit" onclick="showEditModal(${apt.id})">
                                                        <i class='bx bx-edit'></i> Chỉnh sửa
                                                    </button>
                                                    <button class="btn-action btn-cancel" 
                                                            onclick="showCancelModal(${apt.id}, '${apt.customerName}', '${apt.bookingDate}', '${apt.doctorName}', '${apt.serviceName}', '${apt.status}')">
                                                        <i class='bx bx-x-circle'></i> Hủy lịch
                                                    </button>
                                                </c:when>
                                                <c:when test="${apt.status == 'Confirmed'}">
                                                    <button class="btn-action btn-detail" disabled>
                                                        <i class='bx bx-info-circle'></i> Vui lòng đến đúng giờ
                                                    </button>
                                                </c:when>
                                                <c:when test="${apt.status == 'Cancelled' || apt.status == 'Rejected'}">
                                                    <a href="${pageContext.request.contextPath}/booking" class="btn-action btn-rebook">
                                                        <i class='bx bx-calendar-plus'></i> Đặt lại
                                                    </a>
                                                    <button class="btn-action btn-delete" onclick="showDeleteModal(${apt.id}, '${apt.serviceName}', '${apt.bookingDate}')">
                                                        <i class='bx bx-trash'></i> Xóa
                                                    </button>
                                                </c:when>
                                                <c:when test="${apt.status == 'Completed'}">
                                                    <button class="btn-action btn-detail" style="flex: 1;">
                                                        <i class='bx bx-check-circle'></i> Cảm ơn bạn đã sử dụng dịch vụ
                                                    </button>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />

    <!-- Cancel Confirmation Modal -->
    <div class="modal fade" id="cancelModal" tabindex="-1" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header-custom">
                    <button type="button" class="btn-close position-absolute top-0 end-0 m-3" data-bs-dismiss="modal"></button>
                    <div class="w-100">
                        <div class="modal-icon">
                            <i class='bx bx-calendar-x'></i>
                        </div>
                        <h5 class="modal-title-custom">Xác nhận hủy lịch hẹn?</h5>
                    </div>
                </div>
                <div class="modal-body-custom">
                    <div class="appointment-preview">
                        <div class="preview-row">
                            <span class="preview-label">Khách hàng</span>
                            <span class="preview-value" id="previewCustomer">-</span>
                        </div>
                        <div class="preview-row">
                            <span class="preview-label">Dịch vụ</span>
                            <span class="preview-value" id="previewService">-</span>
                        </div>
                        <div class="preview-row">
                            <span class="preview-label">Ngày hẹn</span>
                            <span class="preview-value" id="previewDate">-</span>
                        </div>
                        <div class="preview-row">
                            <span class="preview-label">Bác sĩ</span>
                            <span class="preview-value" id="previewDoctor">-</span>
                        </div>
                    </div>
                    <div class="reason-section">
                        <label><i class='bx bx-message-detail me-1'></i> Lý do hủy (tùy chọn)</label>
                        <select class="form-select" id="cancelReason">
                            <option value="">-- Chọn lý do --</option>
                            <option value="Thay đổi lịch trình">Thay đổi lịch trình</option>
                            <option value="Thú cưng đã khỏe">Thú cưng đã khỏe</option>
                            <option value="Chọn phòng khám khác">Chọn phòng khám khác</option>
                            <option value="Lý do cá nhân">Lý do cá nhân</option>
                            <option value="other">Lý do khác...</option>
                        </select>
                        <textarea class="form-control mt-2 d-none" id="customReason" rows="2" placeholder="Nhập lý do của bạn..."></textarea>
                    </div>
                    <input type="hidden" id="cancelAppointmentId">
                    <input type="hidden" id="cancelPreviousStatus">
                </div>
                <div class="modal-footer modal-footer-custom">
                    <button type="button" class="btn-keep" data-bs-dismiss="modal">
                        <i class='bx bx-x me-1'></i> Giữ lịch
                    </button>
                    <button type="button" class="btn-confirm-cancel" id="btnConfirmCancel" onclick="confirmCancel()">
                        <span class="normal-text"><i class='bx bx-check me-1'></i> Xác nhận hủy</span>
                        <span class="loading-text d-none">
                            <span class="spinner-border spinner-border-sm me-2"></span> Đang hủy...
                        </span>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Appointment Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content" style="border-radius: 20px; border: none; overflow: hidden;">
                <div class="modal-header-custom" style="background: linear-gradient(135deg, #6366f1, #4f46e5); padding: 30px; text-align: center;">
                    <button type="button" class="btn-close btn-close-white position-absolute top-0 end-0 m-3" data-bs-dismiss="modal"></button>
                    <div class="w-100">
                        <div style="width: 70px; height: 70px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.15);">
                            <i class='bx bx-edit' style="font-size: 2rem; color: #4f46e5;"></i>
                        </div>
                        <h5 style="color: white; font-weight: 700; margin: 0; font-size: 1.3rem;">Chỉnh sửa lịch hẹn</h5>
                    </div>
                </div>
                <form id="editForm" method="POST" action="${pageContext.request.contextPath}/schedule">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" id="editAppointmentId">
                    <div class="modal-body" style="padding: 30px;">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label" style="font-weight: 600; color: #374151;">Họ tên khách hàng <span style="color: #ef4444;">*</span></label>
                                <input type="text" class="form-control" name="customerName" id="editCustomerName" required style="border-radius: 10px; padding: 12px 16px; border: 2px solid #e5e7eb;">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" style="font-weight: 600; color: #374151;">Số điện thoại <span style="color: #ef4444;">*</span></label>
                                <input type="tel" class="form-control" name="phone" id="editPhone" required pattern="[0-9]{10,11}" style="border-radius: 10px; padding: 12px 16px; border: 2px solid #e5e7eb;">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" style="font-weight: 600; color: #374151;">Tên thú cưng <span style="color: #ef4444;">*</span></label>
                                <input type="text" class="form-control" name="petName" id="editPetName" required style="border-radius: 10px; padding: 12px 16px; border: 2px solid #e5e7eb;">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" style="font-weight: 600; color: #374151;">Loại thú cưng <span style="color: #ef4444;">*</span></label>
                                <select class="form-select" name="petType" id="editPetType" required style="border-radius: 10px; padding: 12px 16px; border: 2px solid #e5e7eb;">
                                    <option value="Chó">🐕 Chó</option>
                                    <option value="Mèo">🐱 Mèo</option>
                                    <option value="Hamster">🐹 Hamster</option>
                                    <option value="Thỏ">🐰 Thỏ</option>
                                    <option value="Chim">🐦 Chim</option>
                                    <option value="Khác">🐾 Khác</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" style="font-weight: 600; color: #374151;">Dịch vụ <span style="color: #ef4444;">*</span></label>
                                <select class="form-select" name="serviceId" id="editServiceId" required style="border-radius: 10px; padding: 12px 16px; border: 2px solid #e5e7eb;">
                                    <option value="1">💊 Khám & Điều trị</option>
                                    <option value="2">🔪 Phẫu thuật</option>
                                    <option value="3">💉 Tiêm phòng Vaccine</option>
                                    <option value="4">✨ Spa & Làm đẹp</option>
                                    <option value="5">🏨 Khách Sạn Thú Cưng</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" style="font-weight: 600; color: #374151;">Ngày hẹn <span style="color: #ef4444;">*</span></label>
                                <input type="date" class="form-control" name="bookingDate" id="editBookingDate" required style="border-radius: 10px; padding: 12px 16px; border: 2px solid #e5e7eb;">
                            </div>
                            <div class="col-12">
                                <label class="form-label" style="font-weight: 600; color: #374151;">Ghi chú</label>
                                <textarea class="form-control" name="note" id="editNote" rows="3" placeholder="Triệu chứng, yêu cầu đặc biệt..." style="border-radius: 10px; padding: 12px 16px; border: 2px solid #e5e7eb;"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer" style="padding: 20px 30px; border-top: 1px solid #e5e7eb; gap: 12px;">
                        <button type="button" class="btn" data-bs-dismiss="modal" style="background: #f3f4f6; color: #374151; padding: 12px 24px; border-radius: 10px; font-weight: 600; border: none;">
                            <i class='bx bx-x me-1'></i> Hủy bỏ
                        </button>
                        <button type="submit" class="btn" style="background: linear-gradient(135deg, #6366f1, #4f46e5); color: white; padding: 12px 24px; border-radius: 10px; font-weight: 600; border: none; box-shadow: 0 4px 15px rgba(99, 102, 241, 0.35);">
                            <span class="normal-text"><i class='bx bx-check me-1'></i> Lưu thay đổi</span>
                            <span class="loading-text d-none">
                                <span class="spinner-border spinner-border-sm me-2"></span> Đang lưu...
                            </span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content" style="border-radius: 16px; border: none; overflow: hidden;">
                <div style="background: linear-gradient(135deg, #ef4444, #dc2626); padding: 25px; text-align: center;">
                    <button type="button" class="btn-close btn-close-white position-absolute top-0 end-0 m-3" data-bs-dismiss="modal"></button>
                    <div style="width: 60px; height: 60px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 12px;">
                        <i class='bx bx-trash' style="font-size: 1.8rem; color: #ef4444;"></i>
                    </div>
                    <h6 style="color: white; font-weight: 700; margin: 0; font-size: 1.1rem;">Xóa lịch hẹn?</h6>
                </div>
                <div class="text-center" style="padding: 20px;">
                    <p class="text-muted mb-2" style="font-size: 0.9rem;">
                        <strong id="deleteServiceName">-</strong><br>
                        <small id="deleteDate">-</small>
                    </p>
                    <p class="text-danger small mb-0">
                        <i class='bx bx-error-circle'></i> Hành động này không thể hoàn tác
                    </p>
                    <input type="hidden" id="deleteAppointmentId">
                </div>
                <div style="padding: 15px 20px 20px; display: flex; gap: 10px;">
                    <button type="button" class="btn flex-fill" data-bs-dismiss="modal" style="background: #f3f4f6; color: #374151; padding: 12px; border-radius: 10px; font-weight: 600; border: none;">
                        Hủy bỏ
                    </button>
                    <button type="button" class="btn flex-fill" onclick="confirmDelete()" style="background: linear-gradient(135deg, #ef4444, #dc2626); color: white; padding: 12px; border-radius: 10px; font-weight: 600; border: none; box-shadow: 0 4px 15px rgba(239, 68, 68, 0.35);">
                        <span class="normal-text"><i class='bx bx-trash me-1'></i> Xóa</span>
                        <span class="loading-text d-none">
                            <span class="spinner-border spinner-border-sm"></span>
                        </span>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast Container -->
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <!-- Success Toast -->
        <div id="successToast" class="toast custom-toast toast-success" data-bs-autohide="false">
            <div class="toast-body-custom">
                <div class="toast-message">
                    <i class='bx bx-check-circle'></i>
                    <span>Đã hủy lịch hẹn thành công</span>
                </div>
                <button class="btn-undo" onclick="undoCancel()">
                    <i class='bx bx-undo'></i> Hoàn tác <span class="countdown-badge">(10)</span>
                </button>
            </div>
            <div class="undo-progress">
                <div class="undo-progress-bar"></div>
            </div>
        </div>
        
        <!-- Error Toast -->
        <div id="errorToast" class="toast custom-toast toast-error">
            <div class="toast-body-custom">
                <div class="toast-message">
                    <i class='bx bx-error-circle'></i>
                    <span id="errorMessage">Có lỗi xảy ra</span>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
            </div>
        </div>
        
        <!-- Undo Success Toast -->
        <div id="undoSuccessToast" class="toast custom-toast toast-info">
            <div class="toast-body-custom">
                <div class="toast-message">
                    <i class='bx bx-revision'></i>
                    <span>Đã khôi phục lịch hẹn</span>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
            </div>
        </div>
    </div>

    <script>
        const contextPath = '${pageContext.request.contextPath}';
        let cancelModal, deleteModal, editModal, successToast, errorToast, undoSuccessToast;
        let undoTimer, undoCountdown = 10;
        let currentCancelData = null;

        // Store appointment data for editing
        const appointmentsData = {};
        <c:forEach items="${mySchedule}" var="apt">
        appointmentsData[${apt.id}] = {
            id: ${apt.id},
            customerName: "<c:out value='${apt.customerName}' escapeXml='false'/>",
            phone: "<c:out value='${apt.phone}'/>",
            petName: "<c:out value='${apt.petName}' escapeXml='false'/>",
            petType: "<c:out value='${apt.petType}'/>",
            serviceId: ${apt.serviceId},
            bookingDate: "<c:out value='${apt.bookingDate}'/>",
            note: "<c:out value='${apt.note}' escapeXml='false'/>"
        };
        </c:forEach>

        document.addEventListener('DOMContentLoaded', function() {
            // Initialize Bootstrap components
            cancelModal = new bootstrap.Modal(document.getElementById('cancelModal'));
            deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
            editModal = new bootstrap.Modal(document.getElementById('editModal'));
            successToast = new bootstrap.Toast(document.getElementById('successToast'), {autohide: false});
            errorToast = new bootstrap.Toast(document.getElementById('errorToast'), {delay: 5000});
            undoSuccessToast = new bootstrap.Toast(document.getElementById('undoSuccessToast'), {delay: 3000});

            // Count stats
            updateStats();

            // Filter tabs
            document.querySelectorAll('.filter-tab').forEach(tab => {
                tab.addEventListener('click', function() {
                    document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                    filterAppointments(this.dataset.filter);
                });
            });

            // Cancel reason dropdown
            document.getElementById('cancelReason').addEventListener('change', function() {
                const customReason = document.getElementById('customReason');
                if (this.value === 'other') {
                    customReason.classList.remove('d-none');
                } else {
                    customReason.classList.add('d-none');
                }
            });

            // Set min date for booking date input
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('editBookingDate').setAttribute('min', today);

            // Edit form submit handler
            document.getElementById('editForm').addEventListener('submit', function(e) {
                const btn = this.querySelector('button[type="submit"]');
                btn.disabled = true;
                btn.querySelector('.normal-text').classList.add('d-none');
                btn.querySelector('.loading-text').classList.remove('d-none');
            });
        });

        function updateStats() {
            const items = document.querySelectorAll('.appointment-item');
            let pending = 0, confirmed = 0, completed = 0;
            items.forEach(item => {
                const status = item.dataset.status;
                if (status === 'Pending') pending++;
                else if (status === 'Confirmed') confirmed++;
                else if (status === 'Completed') completed++;
            });
            document.getElementById('countPending').textContent = pending;
            document.getElementById('countConfirmed').textContent = confirmed;
            document.getElementById('countCompleted').textContent = completed;
        }

        function filterAppointments(filter) {
            document.querySelectorAll('.appointment-item').forEach(item => {
                if (filter === 'all' || item.dataset.status === filter) {
                    item.style.display = '';
                } else {
                    item.style.display = 'none';
                }
            });
        }

        function showCancelModal(id, customer, date, doctor, service, status) {
            document.getElementById('cancelAppointmentId').value = id;
            document.getElementById('cancelPreviousStatus').value = status;
            document.getElementById('previewCustomer').textContent = customer;
            document.getElementById('previewService').textContent = service;
            document.getElementById('previewDate').textContent = date;
            document.getElementById('previewDoctor').textContent = doctor;
            document.getElementById('cancelReason').value = '';
            document.getElementById('customReason').value = '';
            document.getElementById('customReason').classList.add('d-none');
            
            currentCancelData = { id, customer, date, doctor, service, status };
            cancelModal.show();
        }

        function confirmCancel() {
            const btn = document.getElementById('btnConfirmCancel');
            const id = document.getElementById('cancelAppointmentId').value;
            
            // Set loading state
            btn.disabled = true;
            btn.querySelector('.normal-text').classList.add('d-none');
            btn.querySelector('.loading-text').classList.remove('d-none');

            // Get reason
            let reason = document.getElementById('cancelReason').value;
            if (reason === 'other') {
                reason = document.getElementById('customReason').value;
            }

            // Submit form
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = contextPath + '/schedule';
            
            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'id';
            idInput.value = id;
            form.appendChild(idInput);
            
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'cancel';
            form.appendChild(actionInput);

            document.body.appendChild(form);
            form.submit();
        }

        function showEditModal(id) {
            const apt = appointmentsData[id];
            if (!apt) {
                alert('Không tìm thấy thông tin lịch hẹn!');
                return;
            }
            
            document.getElementById('editAppointmentId').value = apt.id;
            document.getElementById('editCustomerName').value = apt.customerName;
            document.getElementById('editPhone').value = apt.phone;
            document.getElementById('editPetName').value = apt.petName;
            document.getElementById('editPetType').value = apt.petType;
            document.getElementById('editServiceId').value = apt.serviceId;
            document.getElementById('editBookingDate').value = apt.bookingDate;
            document.getElementById('editNote').value = apt.note;
            
            editModal.show();
        }

        function showDeleteModal(id, serviceName, date) {
            document.getElementById('deleteAppointmentId').value = id;
            document.getElementById('deleteServiceName').textContent = serviceName;
            document.getElementById('deleteDate').textContent = date;
            deleteModal.show();
        }

        function confirmDelete() {
            const btn = document.querySelector('#deleteModal .btn-confirm-cancel');
            const id = document.getElementById('deleteAppointmentId').value;
            
            btn.disabled = true;
            btn.querySelector('.normal-text').classList.add('d-none');
            btn.querySelector('.loading-text').classList.remove('d-none');

            const form = document.createElement('form');
            form.method = 'POST';
            form.action = contextPath + '/schedule';
            
            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'id';
            idInput.value = id;
            form.appendChild(idInput);
            
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'delete';
            form.appendChild(actionInput);

            document.body.appendChild(form);
            form.submit();
        }

        function undoCancel() {
            if (!currentCancelData) return;
            clearInterval(undoTimer);
            successToast.hide();
            
            // Show undo success
            undoSuccessToast.show();
            
            // Restore would need backend support
            // For now, reload page
            setTimeout(() => location.reload(), 1000);
        }

        function startUndoCountdown() {
            undoCountdown = 10;
            updateCountdownDisplay();
            
            // Reset progress bar
            const progressBar = document.querySelector('.undo-progress-bar');
            progressBar.style.animation = 'none';
            progressBar.offsetHeight;
            progressBar.style.animation = 'countdown 10s linear forwards';

            undoTimer = setInterval(() => {
                undoCountdown--;
                updateCountdownDisplay();
                if (undoCountdown <= 0) {
                    clearInterval(undoTimer);
                    successToast.hide();
                    currentCancelData = null;
                }
            }, 1000);
        }

        function updateCountdownDisplay() {
            document.querySelector('.countdown-badge').textContent = '(' + undoCountdown + ')';
        }
    </script>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

