<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Lịch Sử Tiêm Chủng - Animal Doctors</title>
    
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
        
        nav#navbar-main, nav#navbar-main * {
            font-family: 'Montserrat', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
        }
        nav#navbar-main i.bx { font-family: 'boxicons' !important; }
        
        .dropdown-menu { z-index: 999999 !important; position: absolute !important; }
        nav#navbar-main .dropdown-menu { z-index: 999999 !important; position: absolute !important; top: 100% !important; right: 0 !important; left: auto !important; }
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
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
        .page-header h1 { font-weight: 800; font-size: 2.2rem; position: relative; z-index: 1; }
        .page-header h1 i { margin-right: 12px; }
        .page-header p { opacity: 0.9; position: relative; z-index: 1; }
        .page-header .btn-light {
            background: white;
            color: #059669;
            border: none;
            padding: 12px 28px;
            border-radius: 50px;
            font-weight: 700;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s;
            text-decoration: none;
        }
        .page-header .btn-light:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        /* Stats Cards */
        .stats-row { margin-top: -60px; position: relative; z-index: 10; }
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
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 15px 40px rgba(0,0,0,0.12); }
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
        .stat-icon.completed { background: linear-gradient(135deg, #34d399, #10b981); }
        .stat-icon.upcoming { background: linear-gradient(135deg, #fbbf24, #f59e0b); }
        .stat-number { font-size: 2rem; font-weight: 800; color: var(--dark); line-height: 1; }
        .stat-label { font-size: 0.9rem; color: var(--gray); margin-top: 4px; }

        /* Filter Section */
        .filter-section {
            background: white;
            border-radius: 16px;
            padding: 20px 24px;
            margin-bottom: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
            display: flex;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }
        .filter-label { font-weight: 700; color: var(--dark); }
        .filter-select {
            padding: 12px 20px;
            border: 2px solid var(--light-gray);
            border-radius: 12px;
            font-size: 0.95rem;
            font-weight: 600;
            min-width: 220px;
            transition: all 0.2s;
        }
        .filter-select:focus { border-color: var(--primary); outline: none; box-shadow: 0 0 0 3px rgba(0, 191, 165, 0.15); }

        /* Selected Pet Info */
        .selected-pet-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            padding: 24px;
            margin-bottom: 30px;
            color: white;
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .selected-pet-icon {
            width: 70px;
            height: 70px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .selected-pet-icon i { font-size: 2rem; }
        .selected-pet-name { font-size: 1.4rem; font-weight: 800; margin-bottom: 4px; }
        .selected-pet-info { font-size: 0.95rem; opacity: 0.9; }

        /* Timeline */
        .timeline { position: relative; padding-left: 40px; }
        .timeline::before {
            content: '';
            position: absolute;
            left: 15px;
            top: 0;
            bottom: 0;
            width: 3px;
            background: linear-gradient(180deg, var(--success), var(--primary-light));
            border-radius: 3px;
        }
        
        .timeline-item { position: relative; margin-bottom: 30px; }
        .timeline-dot {
            position: absolute;
            left: -33px;
            top: 24px;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background: var(--success);
            border: 4px solid white;
            box-shadow: 0 2px 10px rgba(16, 185, 129, 0.4);
        }
        
        .timeline-card {
            background: white;
            border-radius: 20px;
            padding: 24px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
            border: 1px solid rgba(0,0,0,0.03);
            transition: all 0.3s;
        }
        .timeline-card:hover { box-shadow: 0 12px 40px rgba(0,0,0,0.1); transform: translateX(5px); }
        
        .timeline-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 12px;
        }
        .timeline-vaccine { font-size: 1.2rem; font-weight: 800; color: var(--dark); }
        .timeline-date {
            background: linear-gradient(135deg, #d1fae5, #a7f3d0);
            color: #047857;
            padding: 8px 16px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        
        .timeline-details { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 16px; }
        .timeline-detail {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            background: var(--light-gray);
            border-radius: 12px;
        }
        .timeline-detail i { color: var(--primary); font-size: 1.2rem; }
        .timeline-detail-label { font-size: 0.75rem; color: var(--gray); text-transform: uppercase; letter-spacing: 0.5px; }
        .timeline-detail-value { font-size: 0.95rem; font-weight: 700; color: var(--dark); }
        
        .timeline-notes {
            margin-top: 16px;
            padding: 14px 18px;
            background: linear-gradient(135deg, #fff8e1, #ffecb3);
            border-radius: 12px;
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }
        .timeline-notes i { color: #ff8f00; font-size: 1.2rem; flex-shrink: 0; }
        .timeline-notes span { font-size: 0.9rem; color: #5d4037; font-style: italic; }

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
            background: linear-gradient(135deg, #d1fae5, #a7f3d0);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
        }
        .empty-icon i { font-size: 4rem; color: var(--success); }
        .empty-state h4 { color: var(--dark); margin-bottom: 12px; font-weight: 700; font-size: 1.4rem; }
        .empty-state p { color: var(--gray); margin-bottom: 30px; font-size: 1rem; line-height: 1.6; }
        .btn-book {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: 14px 32px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1rem;
            box-shadow: 0 4px 20px rgba(0, 191, 165, 0.35);
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }
        .btn-book:hover { transform: translateY(-3px); box-shadow: 0 8px 30px rgba(0, 191, 165, 0.45); color: white; }

        /* Upcoming Section */
        .upcoming-section { margin-top: 50px; }
        .section-title {
            font-size: 1.4rem;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .section-title i { color: var(--warning); font-size: 1.6rem; }
        
        .upcoming-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 20px; }
        .upcoming-card {
            background: white;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
            border-left: 4px solid var(--warning);
            transition: all 0.3s;
        }
        .upcoming-card:hover { transform: translateY(-5px); box-shadow: 0 12px 40px rgba(0,0,0,0.1); }
        .upcoming-card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .upcoming-card-pet { font-weight: 800; color: var(--dark); font-size: 1.1rem; }
        .upcoming-card-badge {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            color: #b45309;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
        }
        .upcoming-card-vaccine { color: var(--gray); font-size: 0.95rem; margin-bottom: 12px; }
        .upcoming-card-date { display: flex; align-items: center; gap: 8px; font-weight: 700; color: var(--warning); }
        .upcoming-card-date i { font-size: 1.1rem; }
    </style>
</head>
<body>
    <jsp:include page="/components/navbar.jsp" />

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1><i class='bx bx-injection'></i> Lịch Sử Tiêm Chủng</h1>
                    <p class="mb-0">Theo dõi lịch sử và nhắc nhở tiêm chủng cho thú cưng của bạn</p>
                </div>
                <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <a href="${pageContext.request.contextPath}/user/my-pets" class="btn btn-light btn-lg">
                        <i class='bx bx-arrow-back'></i> Quay lại
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Row -->
    <section class="container stats-row">
        <div class="row g-3">
            <div class="col-md-6">
                <div class="stat-card">
                    <div class="stat-icon completed"><i class='bx bx-check-circle'></i></div>
                    <div>
                        <div class="stat-number">${totalRecords}</div>
                        <div class="stat-label">Mũi tiêm đã hoàn thành</div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="stat-card">
                    <div class="stat-icon upcoming"><i class='bx bx-bell'></i></div>
                    <div>
                        <div class="stat-number">${upcomingCount}</div>
                        <div class="stat-label">Sắp đến hạn tiêm</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <section class="py-5">
        <div class="container">
            <!-- Filter -->
            <div class="filter-section">
                <span class="filter-label"><i class='bx bx-filter-alt'></i> Lọc theo thú cưng:</span>
                <select class="filter-select" onchange="filterByPet(this.value)">
                    <option value="">Tất cả thú cưng</option>
                    <c:forEach var="pet" items="${pets}">
                        <option value="${pet.id}" ${selectedPetId == pet.id ? 'selected' : ''}>${pet.name} (${pet.species})</option>
                    </c:forEach>
                </select>
            </div>
            
            <!-- Selected Pet Info -->
            <c:if test="${not empty selectedPet}">
                <div class="selected-pet-card">
                    <div class="selected-pet-icon">
                        <i class='bx ${selectedPet.speciesIcon}'></i>
                    </div>
                    <div>
                        <div class="selected-pet-name">${selectedPet.name}</div>
                        <div class="selected-pet-info">${selectedPet.species} • ${selectedPet.breed != null ? selectedPet.breed : 'Chưa xác định giống'} • ${selectedPet.age}</div>
                    </div>
                </div>
            </c:if>
            
            <!-- Timeline -->
            <c:choose>
                <c:when test="${empty records}">
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class='bx bx-injection'></i>
                        </div>
                        <h4>Chưa có lịch sử tiêm chủng</h4>
                        <p>Đặt lịch tiêm chủng cho thú cưng của bạn<br>để bảo vệ sức khỏe tốt nhất!</p>
                        <a href="${pageContext.request.contextPath}/booking" class="btn-book">
                            <i class='bx bx-calendar-plus'></i> Đặt lịch ngay
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="timeline">
                        <c:forEach var="record" items="${records}">
                            <div class="timeline-item">
                                <div class="timeline-dot"></div>
                                <div class="timeline-card">
                                    <div class="timeline-header">
                                        <div class="timeline-vaccine">${record.vaccineName}</div>
                                        <div class="timeline-date">
                                            <i class='bx bx-calendar'></i>
                                            <fmt:formatDate value="${record.vaccinationDate}" pattern="dd/MM/yyyy"/>
                                        </div>
                                    </div>
                                    
                                    <div class="timeline-details">
                                        <div class="timeline-detail">
                                            <i class='bx bxs-dog'></i>
                                            <div>
                                                <div class="timeline-detail-label">Thú cưng</div>
                                                <div class="timeline-detail-value">${record.petName}</div>
                                            </div>
                                        </div>
                                        <div class="timeline-detail">
                                            <i class='bx bx-injection'></i>
                                            <div>
                                                <div class="timeline-detail-label">Mũi số</div>
                                                <div class="timeline-detail-value">${record.doseNumber}</div>
                                            </div>
                                        </div>
                                        <c:if test="${not empty record.doctorName}">
                                            <div class="timeline-detail">
                                                <i class='bx bx-user-circle'></i>
                                                <div>
                                                    <div class="timeline-detail-label">Bác sĩ</div>
                                                    <div class="timeline-detail-value">${record.doctorName}</div>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty record.batchNumber}">
                                            <div class="timeline-detail">
                                                <i class='bx bx-barcode'></i>
                                                <div>
                                                    <div class="timeline-detail-label">Số lô</div>
                                                    <div class="timeline-detail-value">${record.batchNumber}</div>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty record.nextDueDate}">
                                            <div class="timeline-detail" style="background: linear-gradient(135deg, #fef3c7, #fde68a);">
                                                <i class='bx bx-time' style="color: #b45309;"></i>
                                                <div>
                                                    <div class="timeline-detail-label" style="color: #92400e;">Mũi tiếp theo</div>
                                                    <div class="timeline-detail-value" style="color: #b45309;">
                                                        <fmt:formatDate value="${record.nextDueDate}" pattern="dd/MM/yyyy"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                    
                                    <c:if test="${not empty record.notes}">
                                        <div class="timeline-notes">
                                            <i class='bx bx-note'></i>
                                            <span>${record.notes}</span>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
            
            <!-- Upcoming Vaccinations -->
            <c:if test="${not empty upcomingVaccinations}">
                <div class="upcoming-section">
                    <h2 class="section-title">
                        <i class='bx bx-bell'></i> Nhắc nhở tiêm chủng
                    </h2>
                    <div class="upcoming-grid">
                        <c:forEach var="record" items="${upcomingVaccinations}">
                            <div class="upcoming-card">
                                <div class="upcoming-card-header">
                                    <span class="upcoming-card-pet">${record.petName}</span>
                                    <span class="upcoming-card-badge">Sắp đến hạn</span>
                                </div>
                                <div class="upcoming-card-vaccine">${record.vaccineName} - Mũi ${record.doseNumber + 1}</div>
                                <div class="upcoming-card-date">
                                    <i class='bx bx-calendar'></i>
                                    <fmt:formatDate value="${record.nextDueDate}" pattern="dd/MM/yyyy"/>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterByPet(petId) {
            if (petId) {
                window.location.href = '${pageContext.request.contextPath}/user/vaccination-history?petId=' + petId;
            } else {
                window.location.href = '${pageContext.request.contextPath}/user/vaccination-history';
            }
        }
    </script>
</body>
</html>
