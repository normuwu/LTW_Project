<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/components/favicon.jsp" />
    <title>Thống kê & Báo cáo - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <jsp:include page="/components/admin-styles.jsp" />
    <style>
        * { font-family: 'Nunito', sans-serif; }
        
        .stats-overview {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }
        .stat-box {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .stat-box .icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        .stat-box .icon.blue { background: #dbeafe; color: #2563eb; }
        .stat-box .icon.green { background: #dcfce7; color: #16a34a; }
        .stat-box .icon.purple { background: #f3e8ff; color: #7c3aed; }
        .stat-box .icon.teal { background: #ccfbf1; color: #0d9488; }
        .stat-box h3 { margin: 0; font-size: 1.5rem; font-weight: 700; color: #1e293b; }
        .stat-box p { margin: 0; color: #64748b; font-size: 0.85rem; }
        
        .chart-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
            margin-bottom: 24px;
        }
        .chart-card {
            background: white;
            border-radius: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            overflow: hidden;
        }
        .chart-card.full-width {
            grid-column: span 2;
        }
        .chart-header {
            padding: 16px 20px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .chart-header h5 {
            margin: 0;
            font-weight: 700;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .chart-header h5 i { color: #64748b; }
        .chart-body {
            padding: 20px;
            position: relative;
            min-height: 300px;
        }
        .chart-body.pie-chart {
            min-height: 350px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .year-filter {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .year-filter select {
            padding: 6px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <jsp:include page="/components/admin-sidebar.jsp"><jsp:param name="currentPage" value="statistics"/></jsp:include>
    
    <main class="admin-main">
        <div class="page-header-admin">
            <div>
                <h1 class="page-title"><i class='bx bxs-bar-chart-alt-2'></i> Thống kê & Báo cáo</h1>
                <p class="page-subtitle">Phân tích dữ liệu hoạt động phòng khám</p>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="year-filter">
                    <label>Năm:</label>
                    <select onchange="window.location.href='?year='+this.value">
                        <c:forEach var="y" begin="${currentYear - 2}" end="${currentYear}">
                            <option value="${y}" ${y == selectedYear ? 'selected' : ''}>${y}</option>
                        </c:forEach>
                    </select>
                </div>
                <jsp:include page="/components/admin-header-dropdown.jsp" />
            </div>
        </div>

        <!-- Overview Stats -->
        <div class="stats-overview">
            <div class="stat-box">
                <div class="icon blue"><i class='bx bxs-user'></i></div>
                <div><h3>${overview.totalUsers}</h3><p>Người dùng</p></div>
            </div>
            <div class="stat-box">
                <div class="icon green"><i class='bx bxs-calendar-check'></i></div>
                <div><h3>${overview.totalAppointments}</h3><p>Lịch hẹn</p></div>
            </div>
            <div class="stat-box">
                <div class="icon purple"><i class='bx bxs-injection'></i></div>
                <div><h3>${overview.totalVaccinations}</h3><p>Mũi tiêm</p></div>
            </div>
            <div class="stat-box">
                <div class="icon teal"><i class='bx bxs-dog'></i></div>
                <div><h3>${overview.totalPets}</h3><p>Thú cưng</p></div>
            </div>
        </div>

        <!-- Charts Row 1 -->
        <div class="chart-grid">
            <!-- Biểu đồ cột: Tiêm chủng theo tháng -->
            <div class="chart-card">
                <div class="chart-header">
                    <h5><i class='bx bx-bar-chart-alt-2'></i> Tiêm chủng theo tháng</h5>
                </div>
                <div class="chart-body">
                    <canvas id="vaccinationChart"></canvas>
                </div>
            </div>

            <!-- Biểu đồ tròn: Tỷ lệ vaccine -->
            <div class="chart-card">
                <div class="chart-header">
                    <h5><i class='bx bx-pie-chart-alt-2'></i> Tỷ lệ sử dụng Vaccine</h5>
                </div>
                <div class="chart-body pie-chart">
                    <canvas id="vaccineChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Charts Row 2 -->
        <div class="chart-grid">
            <!-- Biểu đồ cột ngang: Dịch vụ phổ biến -->
            <div class="chart-card">
                <div class="chart-header">
                    <h5><i class='bx bx-bar-chart'></i> Dịch vụ phổ biến</h5>
                </div>
                <div class="chart-body">
                    <canvas id="serviceChart"></canvas>
                </div>
            </div>

            <!-- Biểu đồ đường: Lịch hẹn theo tháng -->
            <div class="chart-card">
                <div class="chart-header">
                    <h5><i class='bx bx-line-chart'></i> Lịch hẹn theo tháng</h5>
                </div>
                <div class="chart-body">
                    <canvas id="appointmentChart"></canvas>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Dữ liệu từ server
        var vaccinationData = ${vaccinationsByMonthJson};
        var vaccineData = ${popularVaccinesJson};
        var serviceData = ${serviceStatsJson};
        var appointmentData = ${appointmentsByMonthJson};
        
        var monthLabels = ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'];
        
        // Chuẩn bị dữ liệu tiêm chủng theo tháng
        var vaccinationCounts = new Array(12).fill(0);
        vaccinationData.forEach(function(item) {
            vaccinationCounts[item.month - 1] = item.count;
        });
        
        // 1. Biểu đồ cột: Tiêm chủng theo tháng
        new Chart(document.getElementById('vaccinationChart'), {
            type: 'bar',
            data: {
                labels: monthLabels,
                datasets: [{
                    label: 'Số mũi tiêm',
                    data: vaccinationCounts,
                    backgroundColor: 'rgba(13, 148, 136, 0.8)',
                    borderColor: 'rgba(13, 148, 136, 1)',
                    borderWidth: 1,
                    borderRadius: 6
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: { stepSize: 1 }
                    }
                }
            }
        });
        
        // 2. Biểu đồ tròn: Tỷ lệ vaccine
        var vaccineLabels = vaccineData.map(function(item) { return item.vaccine; });
        var vaccineCounts = vaccineData.map(function(item) { return item.count; });
        var vaccineColors = [
            '#0d9488', '#7c3aed', '#ea580c', '#2563eb', '#db2777',
            '#16a34a', '#d97706', '#4f46e5', '#dc2626', '#0891b2'
        ];
        
        new Chart(document.getElementById('vaccineChart'), {
            type: 'doughnut',
            data: {
                labels: vaccineLabels,
                datasets: [{
                    data: vaccineCounts,
                    backgroundColor: vaccineColors.slice(0, vaccineLabels.length),
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right',
                        labels: { 
                            boxWidth: 12,
                            padding: 15,
                            font: { size: 11 }
                        }
                    }
                }
            }
        });
        
        // 3. Biểu đồ cột ngang: Dịch vụ phổ biến
        var serviceLabels = serviceData.map(function(item) { return item.service; });
        var serviceCounts = serviceData.map(function(item) { return item.count; });
        
        new Chart(document.getElementById('serviceChart'), {
            type: 'bar',
            data: {
                labels: serviceLabels,
                datasets: [{
                    label: 'Số lượt đặt',
                    data: serviceCounts,
                    backgroundColor: [
                        'rgba(37, 99, 235, 0.8)',
                        'rgba(124, 58, 237, 0.8)',
                        'rgba(234, 88, 12, 0.8)',
                        'rgba(219, 39, 119, 0.8)',
                        'rgba(13, 148, 136, 0.8)'
                    ],
                    borderRadius: 6
                }]
            },
            options: {
                indexAxis: 'y',
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    x: {
                        beginAtZero: true,
                        ticks: { stepSize: 1 }
                    }
                }
            }
        });
        
        // 4. Biểu đồ đường: Lịch hẹn theo tháng với trạng thái
        var pendingData = new Array(12).fill(0);
        var confirmedData = new Array(12).fill(0);
        var completedData = new Array(12).fill(0);
        
        appointmentData.forEach(function(item) {
            pendingData[item.month - 1] = item.pending;
            confirmedData[item.month - 1] = item.confirmed;
            completedData[item.month - 1] = item.completed;
        });
        
        new Chart(document.getElementById('appointmentChart'), {
            type: 'line',
            data: {
                labels: monthLabels,
                datasets: [
                    {
                        label: 'Chờ duyệt',
                        data: pendingData,
                        borderColor: '#f59e0b',
                        backgroundColor: 'rgba(245, 158, 11, 0.1)',
                        tension: 0.3,
                        fill: true
                    },
                    {
                        label: 'Đã duyệt',
                        data: confirmedData,
                        borderColor: '#2563eb',
                        backgroundColor: 'rgba(37, 99, 235, 0.1)',
                        tension: 0.3,
                        fill: true
                    },
                    {
                        label: 'Hoàn thành',
                        data: completedData,
                        borderColor: '#16a34a',
                        backgroundColor: 'rgba(22, 163, 74, 0.1)',
                        tension: 0.3,
                        fill: true
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'top',
                        labels: { 
                            boxWidth: 12,
                            padding: 15
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: { stepSize: 1 }
                    }
                }
            }
        });
    </script>
</body>
</html>
