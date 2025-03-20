<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<footer>
    <div class="footer-container">
        <div class="footer-column">
            <div class="footer-title">Độc quyền</div>
            <div class="footer-text">Đăng ký ngay để nhận ưu đãi</div>
            <div class="footer-form">
                <input type="email" class="footer-input" placeholder="Email">
                <button class="footer-button"><i class="bi bi-send"></i></button>
            </div>
        </div>

        <div class="footer-column">
        </div>

        <div class="footer-column">
            <div class="footer-title">Thông tin</div>
            <div class="footer-links">
                <a href="<c:url value="/user/profile"/>" class="footer-link">Hồ sơ</a>
                <c:if test="${empty sessionScope.user}">
                    <a href="<c:url value="/login"/>" class="footer-link">Đăng nhập / Đăng ký</a>
                </c:if>
                <a href="<c:url value="/user/cart"/>" class="footer-link">Giỏ hàng</a>
                <a href="<c:url value="/user/wishlist"/>" class="footer-link">Danh sách yêu thích</a>
                <a href="<c:url value="/product/all"/>" class="footer-link">Cửa hàng</a>
            </div>
        </div>

        <div class="footer-column">
            <div class="footer-title">Liên hệ</div>
            <div class="social-icons">
                <a href="#" class="social-icon"><i class="bi bi-facebook"></i></a>
                <a href="#" class="social-icon"><i class="bi bi-twitter-x"></i></a>
                <a href="#" class="social-icon"><i class="bi bi-youtube"></i></a>
                <a href="#" class="social-icon"><i class="bi bi-instagram"></i></a>
            </div>
        </div>
    </div>

    <div class="copyright">
        © Bản quyền thuộc về
    </div>


</footer>