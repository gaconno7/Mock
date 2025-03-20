<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ</title>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/client/css/over-view-store.css"/>">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<header>
    <div class="logo"><a href="<c:url value="/"/> ">Taka</a> </div>
    <div class="nav-links">
        <a href="<c:url value='/home'/>" class="home">Trang chủ</a>
        <a href="<c:url value='/product/all'/>" class="product-list">Danh sách sản phẩm</a>
        <a href="#" class="about">Thông tin</a>
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

<div class="store-profile">
    <div class="store-info">
        <div class="store-avatar">
            <img src="${store.image}" alt="Store Avatar">
        </div>
        <div>
            <h2 class="store-name">${store.name}</h2>
<%--            <div class="store-actions"> --%>
<%--                <button class="btn btn-chat">Chat</button>--%>
<%--            </div>--%>
        </div>
    </div>
    <div class="store-stats">
        <div class="stat-item">
            <i class="fas fa-box"></i>
            <span>Số lượng sản phẩm: ${store.products.size()}</span>
        </div>
    </div>
</div>

<div class="section-header">
    <h2>Tất cả sản phẩm</h2>
    <div class="search-container">
        <input type="text" id="search-value" class="search-input" placeholder="Tìm kiếm ...">
    </div>
</div>
<div class="product-grid mb-5" id="productContainer">


</div>
<div id="pagination" class="pagination-page mb-5">

</div>
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
<script>
    let name = null;
    $("#search-value").keydown(function(event) {
        if (event.key === "Enter") {
            setName();
        }
    });

    function setName() {
        name = $("#search-value").val();
        loadProducts(0);
    }

    function removeAllValue() {
        categoryId = null;
        $(".category").removeClass("active-element-a")
        sortBy = null;
        minPrice = null;
        $("#min-price-value").val("");
        maxPrice = null;
        $("#max-price-value").val("");
        searchValue = null;
        $("#search-value").val("");
    }

    function getAll() {
        removeAllValue();
        loadProducts(0);
    }

    function renderRating(evaluations) {
        let totalRate = 0;

        evaluations.forEach(evaluation => {
            totalRate += evaluation.rate;
        });

        let averageRate = evaluations.length > 0 ? Math.round(totalRate / evaluations.length) : 0;

        let ratingHtml = '<div class="rating stars">';
        for (let i = 1; i <= averageRate; i++) {
            ratingHtml += '★';
        }
        ratingHtml += '<span> (' + evaluations.length + ' lượt đánh giá)</span></div>';

        return ratingHtml;
    }

    function loadProducts(page) {
        let data = { page: page };

        name !== null ? data.name = name : data.name = '';
        data.storeId = '${store.id}'
        console.log(data)
        $.ajax({
            url: '/api/products/store',
            type: 'GET',
            data: data,
            dataType: 'json',
            success: function(data) {
                let container = $('#productContainer');
                container.empty();
                if(data.content && data.content.length > 0) {
                    $.each(data.content, function(index, item) {
                        let productHtml =
                            '<div class="product-card">'
                            + ' <div class="product-image">'
                            + ' <img src="' + item.image + '" alt="HAVIT HV-G92 Gamepad">'
                            + ' <div class="quick-view mb-3">'
                            + '  <a href="/product/' + item.id + '">'
                            + '      <i class="bi bi-eye"></i>'
                            + '    </a>'
                            + '  </div>'
                            + '<c:if test="${not empty sessionScope.user}">'
                            + '<div class="quick-view mt-5">'
                            + '<button class="action-button" onclick="addItemToWishlist(\'' + ${sessionScope.user.id}+'\',\'' + item.id + '\')">'
                            + '<i class="bi bi-heart"></i>'
                            + ' </button>'
                            + '  </div>'
                            + '  </c:if>'
                            + '  </div>'
                            + '  <div class="product-info">'
                            + '     <h4 class="product-name ellipsis">' + item.name + '</h4>'
                            + '     <div class="product-price">'
                            + '           <span class="current-price">' + item.price + '</span>'
                            + '           <span class="original-price">' + item.discountPrice + '</span>'
                            + '     </div>'
                            + renderRating(item.evaluations)
                            + '     <button class="btn btn-primary" onclick="addToCart(\'' + item.id.toString() + '\', \'' + item.productVariants[0].id.toString() + '\')">'
                            + '         Thêm vào giỏ hàng   <i class="bi bi-cart"></i>'
                            + '     </button>'
                            + '   </div>'
                            + '</div> ';


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
    function addToCart(productId, selectedVariantId) {
        $.ajax({
            url: "/user/cart/add",
            type: "POST",
            data: {
                productId: productId,
                productVariantId: selectedVariantId,
                quantity: 1
            },
            success: function (response) {
                alert(response.message);
            },
            error: function () {
                alert("Lỗi khi thêm vào giỏ hàng!");
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

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>