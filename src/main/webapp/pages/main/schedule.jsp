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
    <jsp:include page="/components/navbar.jsp" />
    <title>Lịch Hẹn Của Tôi - Animal Doctors</title>
    <jsp:include page="/components/head.jsp" />
    <jsp:include page="/components/navbar-styles.jsp" />
    <style>
        :root {
            --primary-color: #0b1a33;
            --primary-light: #1a3a5c;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --purple-color: #8b5cf6;
            --gray-color: #6b7280;
        }
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
            padding: 50px 0 80px;
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
            background: rgba(255,255,255,0.05);
            border-radius: 50%;
        }
        .page-header h1 { font-weight: 700; font-size: 2.2rem; }
        .page-header p { opacity: 0.9; }

        /* Stats Cards */
        .stats-row {
            margin-top: -50px;
            position: relative;
            z-index: 10;
        }
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            display: flex;
            align-items: center;
            gap: 15px;
            transition: transform 0.3s;
        }
        .stat-card:hover { transform: translateY(-3px); }
        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
        }
        .stat-icon.pending { background: linear-gradient(135deg, #fbbf24, #f59e0b); }
        .stat-icon.confirmed { background: linear-gradient(135deg, #34d399, #10b981); }
        .stat-icon.completed { background: linear-gradient(135deg, #a78bfa, #8b5cf6); }
        .stat-number { font-size: 1.8rem; font-weight: 700; color: var(--primary-color); }
        .stat-label { font-size: 0.85rem; color: var(--gray-color); }

        /* Appointment Cards */
        .appointment-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.06);
            overflow: hidden;
            transition: all 0.3s ease;
            border: none;
            margin-bottom: 20px;
        }
        .appointment-card:hover {
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
            transform: translateY(-4px);
        }
        .card-status-bar {
            height: 4px;
            width: 100%;
        }
        .card-status-bar.pending { background: linear-gradient(90deg, #fbbf24, #f59e0b); }
        .card-status-bar.confirmed { background: linear-gradient(90deg, #34d399, #10b981); }
        .card-status-bar.completed { background: linear-gradient(90deg, #a78bfa, #8b5cf6); }
        .card-status-bar.rejected { background: linear-gradient(90deg, #f87171, #ef4444); }
        .card-status-bar.cancelled { background: linear-gradient(90deg, #9ca3af, #6b7280); }

        .card-header-custom {
            padding: 20px 20px 10px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }
        .appointment-id {
            font-size: 0.8rem;
            color: var(--gray-color);
            margin-bottom: 5px;
        }
        .service-name {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--primary-color);
        }
        
        /* Status Badges */
        .status-badge {
            padding: 6px 14px;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        .status-badge i { font-size: 0.9rem; }
        .status-pending { background: #fef3c7; color: #b45309; }
        .status-confirmed { background: #d1fae5; color: #047857; }
        .status-completed { background: #ede9fe; color: #6d28d9; }
        .status-rejected { background: #fee2e2; color: #b91c1c; }
        .status-cancelled { background: #f3f4f6; color: #4b5563; }

        /* Card Body */
        .card-body-custom { padding: 10px 20px 20px; }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-bottom: 15px;
        }
        .info-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .info-icon {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            background: #f3f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
        }
        .info-label { font-size: 0.75rem; color: var(--gray-color); }
        .info-value { font-size: 0.9rem; font-weight: 500; color: #1f2937; }

        /* Note Section */
        .note-section {
            background: #f9fafb;
            border-radius: 10px;
            padding: 12px 15px;
            margin-bottom: 15px;
        }
        .note-section i { color: var(--warning-color); }
        .note-section span { font-size: 0.85rem; color: #4b5563; }

        /* Action Buttons */
        .card-actions {
            display: flex;
            gap: 10px;
            padding-top: 15px;
            border-top: 1px solid #f3f4f6;
        }
        .btn-action {
            flex: 1;
            padding: 10px 15px;
            border-radius: 10px;
            font-size: 0.85rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all 0.2s;
            border: none;
        }
        .btn-edit {
            background: #e0e7ff;
            color: #4338ca;
        }
        .btn-edit:hover { background: #c7d2fe; color: #3730a3; }
        .btn-cancel {
            background: #fee2e2;
            color: #dc2626;
        }
        .btn-cancel:hover { background: #fecaca; color: #b91c1c; }
        .btn-rebook {
            background: var(--primary-color);
            color: white;
        }
        .btn-rebook:hover { background: var(--primary-light); }
        .btn-detail {
            background: #f3f4f6;
            color: #374151;
        }
        .btn-detail:hover { background: #e5e7eb; }
        .btn-delete {
            background: #fef2f2;
            color: #dc2626;
        }
        .btn-delete:hover { background: #fee2e2; color: #b91c1c; }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.06);
        }
        .empty-icon {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #f3f4f6, #e5e7eb);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
        }
        .empty-icon i { font-size: 3.5rem; color: #9ca3af; }
        .empty-state h4 { color: var(--primary-color); margin-bottom: 10px; }
        .empty-state p { color: var(--gray-color); margin-bottom: 25px; }

        /* Cancel Modal */
        .modal-content { border: none; border-radius: 20px; overflow: hidden; }
        .modal-header-custom {
            background: linear-gradient(135deg, #fef2f2, #fee2e2);
            padding: 25px;
            border: none;
        }
        .modal-icon {
            width: 60px;
            height: 60px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            box-shadow: 0 4px 15px rgba(239,68,68,0.2);
        }
        .modal-icon i { font-size: 1.8rem; color: #ef4444; }
        .modal-title-custom {
            text-align: center;
            font-size: 1.3rem;
            font-weight: 600;
            color: #1f2937;
            margin: 0;
        }
        .modal-body-custom { padding: 25px; }
        .appointment-preview {
            background: #f9fafb;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 20px;
        }
        .preview-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px dashed #e5e7eb;
        }
        .preview-row:last-child { border: none; }
        .preview-label { color: var(--gray-color); font-size: 0.85rem; }
        .preview-value { font-weight: 500; color: #1f2937; }
        .reason-section label {
            font-weight: 500;
            color: #374151;
            margin-bottom: 8px;
            display: block;
        }
        .reason-section select, .reason-section textarea {
            border-radius: 10px;
            border: 1px solid #e5e7eb;
            padding: 12px;
        }
        .reason-section select:focus, .reason-section textarea:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(11,26,51,0.1);
        }
        .modal-footer-custom {
            padding: 20px 25px 25px;
            border: none;
            gap: 12px;
        }
        .btn-keep {
            flex: 1;
            padding: 12px;
            border-radius: 10px;
            background: #f3f4f6;
            color: #374151;
            font-weight: 500;
            border: none;
        }
        .btn-keep:hover { background: #e5e7eb; }
        .btn-confirm-cancel {
            flex: 1;
            padding: 12px;
            border-radius: 10px;
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            font-weight: 500;
            border: none;
        }
        .btn-confirm-cancel:hover { background: linear-gradient(135deg, #dc2626, #b91c1c); }
        .btn-confirm-cancel:disabled { opacity: 0.7; cursor: not-allowed; }

        /* Toast Notifications */
        .toast-container { z-index: 1100; }
        .custom-toast {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            min-width: 350px;
        }
        .toast-success { background: linear-gradient(135deg, #10b981, #059669); }
        .toast-error { background: linear-gradient(135deg, #ef4444, #dc2626); }
        .toast-info { background: linear-gradient(135deg, #3b82f6, #2563eb); }
        .toast-body-custom {
            padding: 15px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            color: white;
        }
        .toast-message { display: flex; align-items: center; gap: 10px; }
        .toast-message i { font-size: 1.3rem; }
        .btn-undo {
            background: rgba(255,255,255,0.2);
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .btn-undo:hover { background: rgba(255,255,255,0.3); color: white; }
        .undo-progress {
            height: 3px;
            background: rgba(255,255,255,0.3);
        }
        .undo-progress-bar {
            height: 100%;
            background: white;
            animation: countdown 10s linear forwards;
        }
        @keyframes countdown {
            from { width: 100%; }
            to { width: 0%; }
        }

        /* Card Inactive State */
        .appointment-card.inactive {
            opacity: 0.7;
            background: #f9fafb;
        }
        .appointment-card.inactive .service-name,
        .appointment-card.inactive .info-value { color: var(--gray-color); }

        /* Loading State */
        .appointment-card.loading { pointer-events: none; position: relative; }
        .appointment-card.loading::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(255,255,255,0.8);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10;
        }

        /* Filter Tabs */
        .filter-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }
        .filter-tab {
            padding: 8px 18px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
            border: 1px solid #e5e7eb;
            background: white;
            color: var(--gray-color);
            cursor: pointer;
            transition: all 0.2s;
        }
        .filter-tab:hover { border-color: var(--primary-color); color: var(--primary-color); }
        .filter-tab.active {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
    </style>
</head>
<body>
    <jsp:include page="/components/navbar.jsp" />

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
        <div class="container">
            <!-- Alert Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show rounded-3" role="alert">
                    <i class='bx bx-check-circle me-2'></i> ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show rounded-3" role="alert">
                    <i class='bx bx-error-circle me-2'></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Filter Tabs -->
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
            <div class="modal-content">
                <div class="modal-header-custom" style="background: linear-gradient(135deg, #e0e7ff, #c7d2fe);">
                    <button type="button" class="btn-close position-absolute top-0 end-0 m-3" data-bs-dismiss="modal"></button>
                    <div class="w-100">
                        <div class="modal-icon" style="box-shadow: 0 4px 15px rgba(67,56,202,0.2);">
                            <i class='bx bx-edit' style="font-size: 1.8rem; color: #4338ca;"></i>
                        </div>
                        <h5 class="modal-title-custom">Chỉnh sửa lịch hẹn</h5>
                    </div>
                </div>
                <form id="editForm" method="POST" action="${pageContext.request.contextPath}/schedule">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" id="editAppointmentId">
                    <div class="modal-body-custom">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-500">Họ tên khách hàng <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="customerName" id="editCustomerName" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-500">Số điện thoại <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" name="phone" id="editPhone" required pattern="[0-9]{10,11}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-500">Tên thú cưng <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="petName" id="editPetName" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-500">Loại thú cưng <span class="text-danger">*</span></label>
                                <select class="form-select" name="petType" id="editPetType" required>
                                    <option value="Chó">Chó</option>
                                    <option value="Mèo">Mèo</option>
                                    <option value="Hamster">Hamster</option>
                                    <option value="Thỏ">Thỏ</option>
                                    <option value="Chim">Chim</option>
                                    <option value="Khác">Khác</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-500">Dịch vụ <span class="text-danger">*</span></label>
                                <select class="form-select" name="serviceId" id="editServiceId" required>
                                    <option value="1">Khám & Điều trị</option>
                                    <option value="2">Phẫu thuật</option>
                                    <option value="3">Tiêm phòng Vaccine</option>
                                    <option value="4">Spa & Làm đẹp</option>
                                    <option value="5">Khách Sạn Thú Cưng</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-500">Ngày hẹn <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" name="bookingDate" id="editBookingDate" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-500">Ghi chú</label>
                                <textarea class="form-control" name="note" id="editNote" rows="3" placeholder="Triệu chứng, yêu cầu đặc biệt..."></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer modal-footer-custom">
                        <button type="button" class="btn-keep" data-bs-dismiss="modal">
                            <i class='bx bx-x me-1'></i> Hủy bỏ
                        </button>
                        <button type="submit" class="btn-confirm-cancel" style="background: linear-gradient(135deg, #4338ca, #3730a3);">
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
            <div class="modal-content">
                <div class="modal-header-custom" style="background: linear-gradient(135deg, #fef2f2, #fee2e2); padding: 20px;">
                    <button type="button" class="btn-close position-absolute top-0 end-0 m-3" data-bs-dismiss="modal"></button>
                    <div class="w-100 text-center">
                        <div class="modal-icon" style="width: 50px; height: 50px; margin-bottom: 10px;">
                            <i class='bx bx-trash' style="font-size: 1.5rem;"></i>
                        </div>
                        <h6 class="modal-title-custom" style="font-size: 1.1rem;">Xóa lịch hẹn?</h6>
                    </div>
                </div>
                <div class="modal-body-custom text-center" style="padding: 20px;">
                    <p class="text-muted mb-2" style="font-size: 0.9rem;">
                        <strong id="deleteServiceName">-</strong><br>
                        <small id="deleteDate">-</small>
                    </p>
                    <p class="text-danger small mb-0">
                        <i class='bx bx-error-circle'></i> Hành động này không thể hoàn tác
                    </p>
                    <input type="hidden" id="deleteAppointmentId">
                </div>
                <div class="modal-footer modal-footer-custom" style="padding: 15px 20px 20px;">
                    <button type="button" class="btn-keep" data-bs-dismiss="modal" style="padding: 10px;">
                        Hủy bỏ
                    </button>
                    <button type="button" class="btn-confirm-cancel" onclick="confirmDelete()" style="padding: 10px;">
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

    <jsp:include page="/components/scripts.jsp" />

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
</body>
</html>

