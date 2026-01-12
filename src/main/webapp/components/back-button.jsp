<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
    BACK BUTTON COMPONENT
    Nút quay lại trang trước
    Include: <jsp:include page="/components/back-button.jsp" />
--%>

<style>
    .btn-back {
        position: fixed;
        bottom: 30px;
        left: 30px;
        width: 50px;
        height: 50px;
        background: linear-gradient(135deg, #0b1a33 0%, #1a3a5c 100%);
        color: white;
        border: none;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.4rem;
        cursor: pointer;
        box-shadow: 0 4px 15px rgba(11, 26, 51, 0.3);
        transition: all 0.3s ease;
        z-index: 9999;
        text-decoration: none;
    }
    .btn-back:hover {
        transform: translateY(-3px) scale(1.05);
        box-shadow: 0 8px 25px rgba(11, 26, 51, 0.4);
        color: white;
    }
    .btn-back:active {
        transform: translateY(0) scale(0.98);
    }
    .btn-back i {
        transition: transform 0.2s;
    }
    .btn-back:hover i {
        transform: translateX(-3px);
    }
    
    /* Tooltip */
    .btn-back::before {
        content: 'Quay lại';
        position: absolute;
        left: 60px;
        background: #333;
        color: white;
        padding: 6px 12px;
        border-radius: 6px;
        font-size: 0.8rem;
        white-space: nowrap;
        opacity: 0;
        visibility: hidden;
        transition: all 0.2s;
    }
    .btn-back:hover::before {
        opacity: 1;
        visibility: visible;
    }
    
    @media (max-width: 768px) {
        .btn-back {
            bottom: 20px;
            left: 20px;
            width: 45px;
            height: 45px;
            font-size: 1.2rem;
        }
    }
</style>

<a href="javascript:history.back()" class="btn-back" title="Quay lại">
    <i class='bx bx-arrow-back'></i>
</a>
