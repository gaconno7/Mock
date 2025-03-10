<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/api/wishlists" var="APIWishlist"/>
<c:set var="userId" value="${sessionScope.user.id}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exclusive - My Account</title><script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/css/profile.css" />">
</head>
<body>

<!-- Header -->
<header>
    <div class="logo">Taka</div>
    <div class="nav-links">
        <a href="<c:url value="/home"/> ">Trang chủ</a>
        <a href="<c:url value="/product/all"/> ">Của hàng</a>
        <a href="#">Thông tin</a>
    </div>
    <div class="icons">
        <span><a class="btn btn-outline-info" href="<c:url value="/wishlist"/> "><i class="bi bi-bag-heart"></i></a></span>
        <span><a class="btn btn-outline-info" href="<c:url value="/cart"/> "><i class="bi bi-cart"></i></a></span>
        <div class="dropdown">
            <div class="btn btn-outline-info dropdown-toggle" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-person-circle"></i>
            </div>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                <c:if test="${not empty sessionScope.user}" >
                    <li><a class="dropdown-item" href="#">Hồ sơ</a></li>
                    <li><a class="dropdown-item" href="<c:url value="/logout"/>">Đăng xuất</a></li>
                </c:if>
                <c:if test="${empty sessionScope.user}" >
                    <li><a class="dropdown-item" href="<c:url value="/login"/> ">Đăng nhập</a></li>
                    <li><a class="dropdown-item" href="<c:url value="/register"/> ">Đăng ký</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</header>

<!-- Breadcrumbs -->
<div class="breadcrumbs">
    <a href="#">Home</a> / My Account
</div>

<!-- Account management -->
<div class="account-container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-section">
            <div class="sidebar-title">Manage My Account</div>
            <div class="sidebar-links">
                <a href="#" class="sidebar-link">My Profile</a>
                <a href="#" class="sidebar-link">Address Book</a>
                <a href="#" class="sidebar-link">My Payment Options</a>
            </div>
        </div>

        <div class="sidebar-section">
            <div class="sidebar-title">My Orders</div>
            <div class="sidebar-links">
                <a href="#" class="sidebar-link">My Returns</a>
                <a href="#" class="sidebar-link">My Cancellations</a>
            </div>
        </div>

        <div class="sidebar-section">
            <div class="sidebar-title">My Wishlist</div>
        </div>
    </div>

    <!-- Profile form -->
    <div class="profile-form">
        <h2 class="form-title">Tài khoản</h2>

        <div class="form-section">
            <form action="">
                <div class="form-row">
                    <div class="form-group" style="text-align: center;">
                        <img class=" image-rounded" src="https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA1L3Vwd2s2MTcyNzgwOS13aWtpbWVkaWEtaW1hZ2Uta293YmVxYTQuanBn.jpg"
                             width="200vh" height="200vh" alt="" srcset="">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="fullname">Họ và tên</label>
                        <input type="text" id="fullname" class="form-input" name="fullname" value="${sessionScope.user.fullname}">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="phone">Số điện thoại</label>
                        <input type="text" id="phone" class="form-input" name="phone" value="${sessionScope.user.phone}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="email">Email</label>
                        <input type="email" id="email" class="form-input" value="${sessionScope.user.email}" disabled>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="avatar">Hình ảnh</label>
                        <input type="file" id="avatar" name="file">
                    </div>
                </div>
                <div class="btn-container">
                    <button class="btn btn-cancel">Cancel</button>
                    <button class="btn btn-save">Lưu thay đổi</button>
                </div>
            </form>
        </div>

        <div class="form-section">
            <h3 class="form-label">Đổi mật khẩu</h3>
            <div class="form-group" style="margin-bottom: 15px;">
                <label class="form-label" for="old-password">Mật khẩu hiện tại</label>
                <input type="password" id="old-password" class="form-input">
            </div>
            <div class="form-group" style="margin-bottom: 15px;">
                <label class="form-label" for="new-password">Mật khẩu mới</label>
                <input type="password" id="new-password" class="form-input" placeholder="Mật khẩu mới">
            </div>
            <div class="form-group">
                <label class="form-label" for="re-new-password">Nhập lại mật khẩu mới</label>
                <input type="password" id="re-new-password" class="form-input" placeholder="Mật khẩu cũ">
            </div>
        </div>

        <div class="btn-container">
            <button class="btn btn-cancel">Huỷ</button>
            <button class="btn btn-save">Lưu thay đổi</button>
        </div>
    </div>
</div>

<!-- Footer -->
<footer>
    <div class="footer-container">
        <div class="footer-column">
            <div class="footer-title">Exclusive</div>
            <div class="footer-text">Subscribe</div>
            <div class="footer-text">Get 10% off your first order</div>
            <div class="footer-form">
                <input type="email" class="footer-input" placeholder="Enter your email">
                <button class="footer-button">➤</button>
            </div>
        </div>

        <div class="footer-column">
            <div class="footer-title">Support</div>
            <div class="footer-text">
                111 Bijoy sarani, Dhaka,<br>
                DH 1515, Bangladesh.
            </div>
            <div class="footer-text">exclusive@gmail.com</div>
            <div class="footer-text">+88015-88888-9999</div>
        </div>

        <div class="footer-column">
            <div class="footer-title">Account</div>
            <div class="footer-links">
                <a href="#" class="footer-link">My Account</a>
                <a href="#" class="footer-link">Login / Register</a>
                <a href="#" class="footer-link">Cart</a>
                <a href="#" class="footer-link">Wishlist</a>
                <a href="#" class="footer-link">Shop</a>
            </div>
        </div>

        <div class="footer-column">
            <div class="footer-title">Quick Link</div>
            <div class="footer-links">
                <a href="#" class="footer-link">Privacy Policy</a>
                <a href="#" class="footer-link">Terms Of Use</a>
                <a href="#" class="footer-link">FAQ</a>
                <a href="#" class="footer-link">Contact</a>
            </div>
        </div>

        <div class="footer-column">
            <div class="footer-title">Download App</div>
            <div class="footer-text">Save $3 with App New User Only</div>
            <div class="app-download">
                <div class="qr-code">QR Code</div>
                <div class="app-buttons">
                    <div class="app-button">Google Play</div>
                    <div class="app-button">App Store</div>
                </div>
            </div>
            <div class="social-icons">
                <div class="social-icon">f</div>
                <div class="social-icon">t</div>
                <div class="social-icon">i</div>
                <div class="social-icon">in</div>
            </div>
        </div>
    </div>

    <div class="copyright">
        © Copyright Rimel 2022. All right reserved
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
