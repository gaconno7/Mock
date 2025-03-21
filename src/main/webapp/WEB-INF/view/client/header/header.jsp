<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
    <div class="logo"><a href="<c:url value="/"/> ">Taka</a> </div>
    <div class="nav-links">
        <a href="<c:url value='/home'/>" class="home">Trang chủ</a>
        <a href="<c:url value='/product/all'/>" class="product-list">Danh sách sản phẩm</a>
    </div>
    <div class="icons">
        <span><a class="btn btn-outline-info" href="<c:url value="/user/wishlist"/> "><i class="bi bi-bag-heart"></i></a></span>
        <span><a class="btn btn-outline-info" href="<c:url value="/user/cart"/> "><i class="bi bi-cart"></i></a></span>
        <div class="dropdown">
            <div class="btn btn-outline-info dropdown-toggle" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-person-circle"></i>
            </div>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                <c:if test="${not empty sessionScope.user}" >
                    <li><a class="dropdown-item" href="<c:url value="/user/profile"/>">Hồ sơ</a></li>
                    <c:if test="${empty sessionScope.user.store}">
                        <li><a class="dropdown-item" href="<c:url value="/store/create"/>">Đăng ký cửa hàng</a></li>
                    </c:if>
                    <c:if test="${not empty sessionScope.user.store}">
                        <li><a class="dropdown-item" href="<c:url value="/store/product"/>">Quản lý sản phẩm</a></li>
                    </c:if>
                    <li><a class="dropdown-item" href="<c:url value="/logout"/>">Đăng xuất</a></li>
                </c:if>
                <c:if test="${empty sessionScope.user}" >
                    <li><a class="dropdown-item" href="<c:url value="/login"/> ">Đăng nhập</a></li>
                    <li><a class="dropdown-item" href="<c:url value="/register"/> ">Đăng ký</a></li>
                </c:if>
            </ul>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            let url = window.location.href;

            $(".home, .product-list, .about").removeClass("active");

            if (url.includes('product')) {
                $(".product-list").addClass("active");
            } else if (url.includes('about')) {
                $(".about").addClass("active");
            } else {
                $(".home").addClass("active");
            }

        });

    </script>

</header>