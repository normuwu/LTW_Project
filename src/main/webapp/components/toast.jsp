<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty sessionScope.toastMessage}">
    
    <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 105000">
        <div id="liveToast" class="toast align-items-center text-white bg-${sessionScope.toastType == 'error' ? 'danger' : 'success'} border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body d-flex align-items-center gap-2">
                    <c:choose>
                        <c:when test="${sessionScope.toastType == 'error'}">
                            <i class='bx bxs-error-circle fs-4'></i>
                        </c:when>
                        <c:otherwise>
                            <i class='bx bxs-check-circle fs-4'></i>
                        </c:otherwise>
                    </c:choose>
                    
                    <span class="fw-medium">${sessionScope.toastMessage}</span>
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

    <script>
        window.addEventListener('DOMContentLoaded', () => {
            const toastLiveExample = document.getElementById('liveToast')
            const toast = new bootstrap.Toast(toastLiveExample)
            toast.show()
        })
    </script>

    <% 

        session.removeAttribute("toastMessage");
        session.removeAttribute("toastType");
    %>
</c:if>