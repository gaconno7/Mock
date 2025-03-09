<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/api/wishlists" var="APIWishlist"/>
<c:set var="userId" value="${sessionScope.user.id}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wishlist | Exclusive</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/css/wishlist.css" />">

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
                </c:if>
                <c:if test="${empty sessionScope.user}" >
                    <li><a class="dropdown-item" href="<c:url value="/login"/> ">Đăng nhập</a></li>
                    <li><a class="dropdown-item" href="<c:url value="/register"/> ">Đăng ký</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</header>

<!-- Main Content -->
<div class="container">
    <!-- Just For You Section -->
    <div class="section-title">
        <div class="d-flex-title">
            <button id="scrollLeft" class="btn btn-dark">←</button>
            <h2>Dành cho bạn</h2>
            <button id="scrollRight" class="btn btn-dark">→</button>
        </div>
    </div>

    <div class="products-grid">
        <!-- Product 3 -->
        <c:forEach var="item" items="${newProducts}">
        <div class="product-card">
            <div class="product-image">
                <div class="new-badge">NEW</div>
                <img src="${item.image}" alt="${item.name}">
                <div class="quick-view"><a href="<c:url value="/product/${item.id}"/>"><i class="bi bi-eye"></i></a>️</div>
            </div>
            <div class="product-info">
                <h3 class="product-title">${item.name}</h3>
                <div class="product-price">
                    <span class="current-price">${item.price}</span>
                    <span class="original-price">${item.discountPrice}</span>
                </div>
                <c:set var="totalRate" value="0" />
                <c:forEach var="evaluation" items="${item.evaluations}">
                    <c:set var="totalRate" value="${totalRate + evaluation.rate}" />
                </c:forEach>
                <div class="rating">
                    <c:forEach var="i" begin="1" end="${item.evaluations.size() > 0 ? totalRate / item.evaluations.size() : 0}" step="1">
                        ★
                    </c:forEach>
                    <span>(${item.evaluations.size()} lượt đánh giá)</span>
                </div>
                <button class="add-to-cart-btn">
                    Thêm vào giỏ hàng   <i class="bi bi-cart"></i>
                </button>
            </div>
        </div>
        </c:forEach>

    </div>
    <a href="<c:url value="/product/all"/> " class="view-all-btn">Xem thêm</a>
    <!-- Wishlist Header -->
    <div class="wishlist-header">
        <h1 class="wishlist-title" id="wishlist-title">Danh sách yêu thích ()</h1>
    </div>

    <!-- Wishlist Products -->
    <div class="products-grid" id="productContainer">


    </div>

    <div id="pagination" class="pagination-page"></div>
</div>

<!-- Footer -->
<footer>
    <div class="footer-container">
        <!-- Column 1 -->
        <div class="footer-column">
            <h3>Exclusive</h3>
            <p>Subscribe</p>
            <p>Get 10% off your first order</p>
            <div class="subscribe-form">
                <input type="email" placeholder="Enter your email" class="subscribe-input">
                <button class="subscribe-btn">➔</button>
            </div>
        </div>

        <!-- Column 2 -->
        <div class="footer-column">
            <h3>Support</h3>
            <p>111 Bijoy sarani, Dhaka,<br>DH 1515, Bangladesh.</p>
            <p>exclusive@gmail.com</p>
            <p>+88015-88888-9999</p>
        </div>

        <!-- Column 3 -->
        <div class="footer-column">
            <h3>Account</h3>
            <ul class="footer-links">
                <li><a href="#">My Account</a></li>
                <li><a href="#">Login / Register</a></li>
                <li><a href="#">Cart</a></li>
                <li><a href="#">Wishlist</a></li>
                <li><a href="#">Shop</a></li>
            </ul>
        </div>

        <!-- Column 4 -->
        <div class="footer-column">
            <h3>Quick Link</h3>
            <ul class="footer-links">
                <li><a href="#">Privacy Policy</a></li>
                <li><a href="#">Terms Of Use</a></li>
                <li><a href="#">FAQ</a></li>
                <li><a href="#">Contact</a></li>
            </ul>
        </div>

        <!-- Column 5 -->
        <div class="footer-column">
            <h3>Download App</h3>
            <p>Save $3 with App New User Only</p>
            <div class="download-app">
                <div class="app-qr">
                    <!-- QR Code placeholder -->
                </div>
                <div class="app-stores">
                    <a href="#" class="app-store-btn">Google Play</a>
                    <a href="#" class="app-store-btn">App Store</a>
                </div>
            </div>
            <div class="social-icons">
                <a href="#" class="social-icon">f</a>
                <a href="#" class="social-icon">t</a>
                <a href="#" class="social-icon">in</a>
                <a href="#" class="social-icon">ig</a>
            </div>
        </div>
    </div>
    <div class="copyright">
        © Copyright Rimel 2022. All right reserved
    </div>
</footer>

<script>
    let userId = ${userId};
    function renderRating(evaluations) {
        let totalRate = 0;

        evaluations.forEach(evaluation => {
            totalRate += evaluation.rate;
        });

        let averageRate = evaluations.length > 0 ? Math.round(totalRate / evaluations.length) : 0;

        let ratingHtml = '<div class="rating">';
        for (let i = 1; i <= averageRate; i++) {
            ratingHtml += '★';
        }
        ratingHtml += '<span> (' + evaluations.length + ' lượt đánh giá)</span></div>';

        return ratingHtml;
    }

    function loadProducts(page) {
        $.ajax({
            url: '/api/wishlists',  // Thay đổi URL endpoint phù hợp
            type: 'GET',
            data: { page: page, userId: userId},
            dataType: 'json',
            success: function(data) {
                let container = $('#productContainer');
                container.empty();
                if(data.content && data.content.length > 0) {
                    $("#wishlist-title").text('Danh sách yêu thích (' + data.content.length + ')');
                    $.each(data.content, function(index, item) {
                        let productHtml =
                            '<div class="product-card">'
                                +'<div class="product-image">'
                                    +'<img src= '+item.product.image + ' alt="Gucci">'
                                    +'<button onclick="removeWishlistItem(`' + item.id + '`)" class="remove-btn quick-view"><i class="bi bi-trash3"></i></button>'
                                +'</div>'
                            +'<div class="product-info">'
                                +'  <h3 class="product-title">'+ item.product.name +'</h3>'
                            +'<div class="product-price">'
                            +'    <span class="current-price"> ' + item.product.price +'</span>'
                                +' <span class="original-price"> ' + item.product.discountPrice + '</span>'
                            +'</div>'
                            + renderRating(item.product.evaluations)
                                +'<button class="add-to-cart-btn">Thêm vào giỏ hàng <i class="bi bi-cart"></i></button>'
                            +'</div></div>';

                        container.append(productHtml);
                    });
                } else {
                    container.html('<p>Không có sản phẩm nào.</p>');
                }

                // Gọi hàm xử lý phân trang dựa vào dữ liệu trả về
                createPagination(data);
            },
            error: function(xhr, status, error) {
                console.error("Có lỗi khi tải sản phẩm: " + error);
            }
        });
    }

    function createPagination(data) {
        let paginationDiv = $('#pagination');
        paginationDiv.empty();

        let totalPages = data.totalPages;
        let currentPage = data.number; // đang dùng số trang (0-indexed) như trong JSON

        // Nút "Trước"
        if (currentPage > 0) {
            paginationDiv.append(
                '<a href="#" data-page="' + (currentPage - 1) + '">&laquo;</a>'
            );
        }

        // Hiển thị các trang phân trang
        for (let i = 0; i < totalPages; i++) {
            let activeClass = (i === currentPage) ? 'active' : '';
            paginationDiv.append(
                '<a href="#" class="' + activeClass + '" data-page="' + i + '">' + (i + 1) + '</a>'
            );
        }

        // Nút "Tiếp theo"
        if (currentPage < totalPages - 1) {
            paginationDiv.append(
                '<a href="#" data-page="' + (currentPage + 1) + '">&raquo;</a>'
            );
        }
    }

    $(document).on('click', '#pagination a', function(e) {
        e.preventDefault();
        let page = $(this).data('page');
        loadProducts(page);
    });

    $(document).ready(function() {
        loadProducts(0);
    });

    document.addEventListener('DOMContentLoaded', function() {
        const productsGrid = document.querySelector('.products-grid');
        const scrollLeftBtn = document.getElementById('scrollLeft');
        const scrollRightBtn = document.getElementById('scrollRight');

        const scrollAmount = 300;

        scrollLeftBtn.addEventListener('click', function() {
            productsGrid.scrollBy({
                left: -scrollAmount,
                behavior: 'smooth'
            });
        });

        scrollRightBtn.addEventListener('click', function() {
            productsGrid.scrollBy({
                left: scrollAmount,
                behavior: 'smooth'
            });
        });

    });


    function removeWishlistItem(id) {
        if (confirm('Bạn có muốn xoá không?')) {
            $.ajax({
                url: `${APIWishlist}/` + id,
                type: 'DELETE',
                success: function(response) {
                    loadProducts(0);
                },
                error: function(xhr, status, error) {
                    console.error(error);
                }
            });

        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</body>
</html>