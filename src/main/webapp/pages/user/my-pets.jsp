<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Thú Cưng Của Tôi - Animal Doctors</title>
    
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
        .page-header h1 { font-weight: 800; font-size: 2.2rem; position: relative; z-index: 1; }
        .page-header h1 i { margin-right: 12px; }
        .page-header p { opacity: 0.9; position: relative; z-index: 1; }
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
        .stat-icon.pets { background: linear-gradient(135deg, #667eea, #764ba2); }
        .stat-icon.vaccines { background: linear-gradient(135deg, #34d399, #10b981); }
        .stat-icon.upcoming { background: linear-gradient(135deg, #fbbf24, #f59e0b); }
        .stat-number { font-size: 2rem; font-weight: 800; color: var(--dark); line-height: 1; }
        .stat-label { font-size: 0.9rem; color: var(--gray); margin-top: 4px; }

        /* Pet Cards */
        .pet-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
            overflow: hidden;
            transition: all 0.3s ease;
            border: 1px solid rgba(0,0,0,0.03);
            margin-bottom: 24px;
        }
        .pet-card:hover { box-shadow: 0 12px 40px rgba(0,0,0,0.12); transform: translateY(-6px); }
        
        .pet-image {
            height: 180px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        .pet-image i { font-size: 80px; color: rgba(255,255,255,0.8); }
        .pet-image img { width: 100%; height: 100%; object-fit: cover; }
        .pet-species-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255,255,255,0.95);
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
            color: var(--dark);
        }
        
        .pet-info { padding: 24px; }
        .pet-name { font-size: 1.4rem; font-weight: 800; color: var(--dark); margin-bottom: 6px; }
        .pet-breed { color: var(--gray); font-size: 0.95rem; margin-bottom: 20px; }
        
        .pet-details { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 20px; }
        .pet-detail {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 14px;
            background: var(--light-gray);
            border-radius: 12px;
        }
        .pet-detail i { color: var(--primary); font-size: 1.1rem; }
        .pet-detail span { font-size: 0.9rem; color: var(--dark); font-weight: 600; }
        
        .pet-vaccines-box {
            background: linear-gradient(135deg, var(--primary-light), #b2dfdb);
            border-radius: 14px;
            padding: 16px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .pet-vaccines-box .label { font-size: 0.9rem; color: var(--primary-dark); font-weight: 600; }
        .pet-vaccines-box .count { font-size: 1.5rem; font-weight: 800; color: var(--primary-dark); }
        
        .pet-actions { display: flex; gap: 10px; }
        .btn-action {
            flex: 1;
            padding: 12px 16px;
            border-radius: 12px;
            font-size: 0.9rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all 0.25s;
            border: none;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-history {
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            color: white;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.35);
        }
        .btn-history:hover { background: linear-gradient(135deg, #4f46e5, #4338ca); transform: translateY(-2px); color: white; }
        .btn-booking-pet {
            background: linear-gradient(135deg, #00bfa5, #00897b);
            color: white;
            box-shadow: 0 4px 15px rgba(0, 191, 165, 0.35);
        }
        .btn-booking-pet:hover { background: linear-gradient(135deg, #00897b, #00695c); transform: translateY(-2px); color: white; }
        .btn-edit-pet {
            background: linear-gradient(135deg, #fbbf24, #f59e0b);
            color: white;
            box-shadow: 0 4px 15px rgba(251, 191, 36, 0.35);
            padding: 12px 14px;
            flex: 0;
        }
        .btn-edit-pet:hover { background: linear-gradient(135deg, #f59e0b, #d97706); transform: translateY(-2px); color: white; }
        .btn-delete-pet {
            background: linear-gradient(135deg, #f87171, #ef4444);
            color: white;
            box-shadow: 0 4px 15px rgba(248, 113, 113, 0.35);
            padding: 12px 14px;
            flex: 0;
        }
        .btn-delete-pet:hover { background: linear-gradient(135deg, #ef4444, #dc2626); transform: translateY(-2px); }

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
        .empty-icon i { font-size: 4rem; color: var(--primary); }
        .empty-state h4 { color: var(--dark); margin-bottom: 12px; font-weight: 700; font-size: 1.4rem; }
        .empty-state p { color: var(--gray); margin-bottom: 30px; font-size: 1rem; line-height: 1.6; }
        .btn-add-new {
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
        }
        .btn-add-new:hover { transform: translateY(-3px); box-shadow: 0 8px 30px rgba(0, 191, 165, 0.45); color: white; }

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
        
        .upcoming-card {
            background: white;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
            border-left: 4px solid var(--warning);
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 16px;
            transition: all 0.3s;
        }
        .upcoming-card:hover { transform: translateX(5px); box-shadow: 0 8px 30px rgba(0,0,0,0.1); }
        .upcoming-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #fff3e0, #ffe0b2);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .upcoming-icon i { font-size: 1.4rem; color: var(--warning); }
        .upcoming-info { flex: 1; }
        .upcoming-pet { font-weight: 700; color: var(--dark); font-size: 1rem; }
        .upcoming-vaccine { font-size: 0.9rem; color: var(--gray); }
        .upcoming-date { text-align: right; }
        .upcoming-date-value { font-weight: 700; color: var(--warning); font-size: 1rem; }
        .upcoming-date-label { font-size: 0.8rem; color: var(--gray); }

        /* Modal Styles */
        .modal-content { border-radius: 20px; border: none; overflow: hidden; }
        .modal-header-custom {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            padding: 30px;
            text-align: center;
            color: white;
            position: relative;
        }
        .modal-icon {
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
        }
        .modal-icon i { font-size: 2.5rem; color: white; }
        .modal-title-custom { font-weight: 700; font-size: 1.3rem; margin: 0; }
        .modal-body-custom { padding: 30px; }
        .form-label { font-weight: 600; color: var(--dark); margin-bottom: 8px; }
        .form-control, .form-select {
            border-radius: 12px;
            padding: 12px 16px;
            border: 2px solid var(--light-gray);
            font-size: 0.95rem;
            transition: all 0.2s;
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(0, 191, 165, 0.15);
        }
        .btn-submit {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: 14px 28px;
            border-radius: 12px;
            font-weight: 700;
            width: 100%;
            font-size: 1rem;
            transition: all 0.3s;
        }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0, 191, 165, 0.4); color: white; }

        /* Delete Modal */
        .delete-modal-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #fee2e2, #fecaca);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
        }
        .delete-modal-icon i { font-size: 2.5rem; color: var(--danger); }
    </style>
</head>
<body>
    <jsp:include page="/components/navbar.jsp" />
    <jsp:include page="/components/toast-notification.jsp" />

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1><i class='bx bxs-dog'></i> Thú Cưng Của Tôi</h1>
                    <p class="mb-0">Quản lý thông tin và theo dõi lịch tiêm chủng cho thú cưng của bạn</p>
                </div>
                <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <button class="btn btn-light btn-lg" data-bs-toggle="modal" data-bs-target="#petModal" onclick="resetForm()">
                        <i class='bx bx-plus'></i> Thêm thú cưng
                    </button>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Row -->
    <section class="container stats-row">
        <div class="row g-3">
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-icon pets"><i class='bx bxs-dog'></i></div>
                    <div>
                        <div class="stat-number">${totalPets}</div>
                        <div class="stat-label">Thú cưng</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-icon vaccines"><i class='bx bx-injection'></i></div>
                    <div>
                        <div class="stat-number">${totalVaccinations}</div>
                        <div class="stat-label">Mũi tiêm hoàn thành</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card">
                    <div class="stat-icon upcoming"><i class='bx bx-bell'></i></div>
                    <div>
                        <div class="stat-number">${upcomingVaccinations.size()}</div>
                        <div class="stat-label">Sắp đến hạn tiêm</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <section class="py-5">
        <div class="container">
            <c:choose>
                <c:when test="${empty pets}">
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class='bx bxs-dog'></i>
                        </div>
                        <h4>Chưa có thú cưng nào</h4>
                        <p>Hãy thêm thú cưng đầu tiên của bạn để quản lý<br>lịch tiêm chủng và chăm sóc sức khỏe!</p>
                        <button class="btn-add-new" data-bs-toggle="modal" data-bs-target="#petModal" onclick="resetForm()">
                            <i class='bx bx-plus'></i> Thêm thú cưng ngay
                        </button>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row">
                        <c:forEach var="pet" items="${pets}">
                            <div class="col-lg-4 col-md-6">
                                <div class="pet-card">
                                    <div class="pet-image">
                                        <c:choose>
                                            <c:when test="${not empty pet.image}">
                                                <img src="${pageContext.request.contextPath}/assets/uploads/${pet.image}" alt="${pet.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <i class='bx ${pet.speciesIcon}'></i>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="pet-species-badge">${pet.species}</span>
                                    </div>
                                    <div class="pet-info">
                                        <h3 class="pet-name">${pet.name}</h3>
                                        <p class="pet-breed">${pet.breed != null ? pet.breed : 'Chưa xác định giống'}</p>
                                        
                                        <div class="pet-details">
                                            <div class="pet-detail">
                                                <i class='bx bx-calendar'></i>
                                                <span>${pet.age}</span>
                                            </div>
                                            <div class="pet-detail">
                                                <i class='bx bx-male-female'></i>
                                                <span>${pet.gender}</span>
                                            </div>
                                            <div class="pet-detail">
                                                <i class='bx bx-body'></i>
                                                <span>${pet.weight > 0 ? pet.weight : '?'} kg</span>
                                            </div>
                                            <div class="pet-detail">
                                                <i class='bx bx-palette'></i>
                                                <span>${pet.color != null ? pet.color : 'N/A'}</span>
                                            </div>
                                        </div>
                                        
                                        <div class="pet-vaccines-box">
                                            <span class="label"><i class='bx bx-injection'></i> Số mũi đã tiêm</span>
                                            <span class="count">${pet.vaccinationCount}</span>
                                        </div>
                                        
                                        <div class="pet-actions">
                                            <a href="${pageContext.request.contextPath}/booking?petId=${pet.id}&petName=${pet.name}&petType=${pet.species}" class="btn-action btn-booking-pet">
                                                <i class='bx bx-calendar-plus'></i> Đặt lịch
                                            </a>
                                            <a href="${pageContext.request.contextPath}/user/vaccination-history?petId=${pet.id}" class="btn-action btn-history">
                                                <i class='bx bx-history'></i> Lịch sử
                                            </a>
                                            <button class="btn-action btn-edit-pet" onclick="openEditModal(${pet.id}, '${pet.name}', '${pet.species}', '${pet.breed}', '${pet.gender}', '${pet.birthDate}', ${pet.weight}, '${pet.color}', '${pet.notes}')">
                                                <i class='bx bx-edit'></i>
                                            </button>
                                            <button class="btn-action btn-delete-pet" onclick="confirmDelete(${pet.id}, '${pet.name}')">
                                                <i class='bx bx-trash'></i>
                                            </button>
                                        </div>
                                    </div>
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
                        <i class='bx bx-bell'></i> Mũi tiêm sắp đến hạn
                    </h2>
                    <div class="row">
                        <c:forEach var="record" items="${upcomingVaccinations}">
                            <div class="col-lg-6">
                                <div class="upcoming-card">
                                    <div class="upcoming-icon">
                                        <i class='bx bx-injection'></i>
                                    </div>
                                    <div class="upcoming-info">
                                        <div class="upcoming-pet">${record.petName}</div>
                                        <div class="upcoming-vaccine">${record.vaccineName} - Mũi ${record.doseNumber + 1}</div>
                                    </div>
                                    <div class="upcoming-date">
                                        <div class="upcoming-date-value">
                                            <fmt:formatDate value="${record.nextDueDate}" pattern="dd/MM/yyyy"/>
                                        </div>
                                        <div class="upcoming-date-label">Ngày tiêm tiếp</div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>
    </section>

    <jsp:include page="/components/footer.jsp" />

    <!-- Add/Edit Pet Modal -->
    <div class="modal fade" id="petModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header-custom">
                    <button type="button" class="btn-close btn-close-white position-absolute top-0 end-0 m-3" data-bs-dismiss="modal"></button>
                    <div class="w-100">
                        <div class="modal-icon">
                            <i class='bx bxs-dog'></i>
                        </div>
                        <h5 class="modal-title-custom" id="modalTitle">Thêm thú cưng mới</h5>
                    </div>
                </div>
                <div class="modal-body-custom">
                    <form id="petForm" method="POST" action="${pageContext.request.contextPath}/user/my-pets">
                        <input type="hidden" name="action" id="formAction" value="add">
                        <input type="hidden" name="id" id="petId">
                        
                        <div class="mb-3">
                            <label class="form-label">Tên thú cưng *</label>
                            <input type="text" class="form-control" name="name" id="petName" required placeholder="VD: Kiki, Miu...">
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-6">
                                <label class="form-label">Loài</label>
                                <select class="form-select" name="species" id="petSpecies">
                                    <option value="Chó">Chó</option>
                                    <option value="Mèo">Mèo</option>
                                    <option value="Khác">Khác</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <label class="form-label">Giới tính</label>
                                <select class="form-select" name="gender" id="petGender">
                                    <option value="Đực">Đực</option>
                                    <option value="Cái">Cái</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Giống</label>
                            <input type="text" class="form-control" name="breed" id="petBreed" placeholder="VD: Poodle, Mèo Anh lông ngắn...">
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-6">
                                <label class="form-label">Ngày sinh</label>
                                <input type="date" class="form-control" name="birthDate" id="petBirthDate">
                            </div>
                            <div class="col-6">
                                <label class="form-label">Cân nặng (kg)</label>
                                <input type="number" class="form-control" name="weight" id="petWeight" step="0.1" min="0" placeholder="VD: 4.5">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Màu lông</label>
                            <input type="text" class="form-control" name="color" id="petColor" placeholder="VD: Trắng, Vàng, Đen...">
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label">Ghi chú</label>
                            <textarea class="form-control" name="notes" id="petNotes" rows="2" placeholder="Thông tin thêm về thú cưng..."></textarea>
                        </div>
                        
                        <button type="submit" class="btn-submit" id="submitBtn">
                            <i class='bx bx-plus'></i> Thêm thú cưng
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content">
                <div class="modal-body text-center py-4">
                    <div class="delete-modal-icon">
                        <i class='bx bx-error-circle'></i>
                    </div>
                    <h5 class="fw-bold mb-2">Xác nhận xóa?</h5>
                    <p class="text-muted mb-4">Bạn có chắc muốn xóa <strong id="deletePetName"></strong>?<br>Tất cả lịch sử tiêm chủng cũng sẽ bị xóa.</p>
                    <form id="deleteForm" method="POST" action="${pageContext.request.contextPath}/user/my-pets">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="deletePetId">
                        <div class="d-flex gap-2 justify-content-center">
                            <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-danger px-4">Xóa</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Show toast if message exists
        <c:if test="${not empty sessionScope.message}">
            showToast('${sessionScope.message}', '${sessionScope.messageType}');
        </c:if>
        <% session.removeAttribute("message"); session.removeAttribute("messageType"); %>
        
        function resetForm() {
            document.getElementById('modalTitle').textContent = 'Thêm thú cưng mới';
            document.getElementById('submitBtn').innerHTML = '<i class="bx bx-plus"></i> Thêm thú cưng';
            document.getElementById('formAction').value = 'add';
            document.getElementById('petForm').reset();
            document.getElementById('petId').value = '';
        }
        
        function openEditModal(id, name, species, breed, gender, birthDate, weight, color, notes) {
            document.getElementById('modalTitle').textContent = 'Chỉnh sửa thú cưng';
            document.getElementById('submitBtn').innerHTML = '<i class="bx bx-check"></i> Cập nhật';
            document.getElementById('formAction').value = 'edit';
            document.getElementById('petId').value = id;
            document.getElementById('petName').value = name || '';
            document.getElementById('petSpecies').value = species || 'Chó';
            document.getElementById('petBreed').value = breed === 'null' ? '' : (breed || '');
            document.getElementById('petGender').value = gender || 'Đực';
            document.getElementById('petBirthDate').value = birthDate === 'null' ? '' : (birthDate || '');
            document.getElementById('petWeight').value = weight || '';
            document.getElementById('petColor').value = color === 'null' ? '' : (color || '');
            document.getElementById('petNotes').value = notes === 'null' ? '' : (notes || '');
            
            var modal = new bootstrap.Modal(document.getElementById('petModal'));
            modal.show();
        }
        
        function confirmDelete(id, name) {
            document.getElementById('deletePetId').value = id;
            document.getElementById('deletePetName').textContent = name;
            var modal = new bootstrap.Modal(document.getElementById('deleteModal'));
            modal.show();
        }
    </script>
</body>
</html>
