<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:url value="/api/wishlists" var="APIWishlist"/>
<c:set var="userId" value="${sessionScope.user.id}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm yêu thích</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/client/css/wishlist.css" />">
    <script src="<c:url value="/client/js/addWishlist.js"/> " type="text/javascript"></script>

</head>
<body>
<!-- Header -->
<%@ include file="header/header.jsp" %>


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

    <div class="products-grid" id="product-for-you">
        <c:forEach var="item" items="${newProducts}">
        <div class="product-card">
            <div class="product-image">
                <img src="${item.productImages[0].url}" alt="${item.name}">
                <div class="quick-view"><a href="<c:url value="/product/${item.id}"/>"><i class="bi bi-eye"></i></a>️</div>
                <div class="quick-view mt-5">
                    <c:if test="${not empty sessionScope.user}">
                        <a class="action-button" onclick="handleClick(`${sessionScope.user.id}`,`${item.id}`)">
                            <i class="bi bi-heart"></i>
                       </a>
                    </c:if>
                </div>
            </div>
            <div class="product-info">
                <h3 class="product-title ellipsis">${item.name}</h3>
                <div class="product-price">
                    <span class="current-price"><fmt:formatNumber type="number" value="${item.price}"/> đ</span>
                    <span class="original-price"><fmt:formatNumber type="number" value="${item.price - (item.price * item.discountPrice)/100}"/> đ</span>
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
                <button class="add-to-cart-btn" onclick="addToCart('${item.id}', '${item.productVariants[0].id}')">
                    Thêm vào giỏ hàng   <i class="bi bi-cart"></i>
                </button>
                <div class="mt-3"><a href="<c:url value="/over-view-store/${item.store.id}"/> " class="card-title"><i class="bi bi-shop"></i> ${item.store.name} </a></div>

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
    <div class="products-grid-api" id="productContainer">


    </div>

    <div id="pagination" class="pagination-page"></div>
</div>

<!-- Footer -->
<%@ include file="footer/footer.jsp" %>

<script>
    let userId = ${userId};
    async function handleClick(userId, itemId) {
        await addItemToWishlist(userId, itemId); // Đợi hoàn tất trước
        loadProducts(0); // Sau đó mới gọi
    }

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
            url: '/api/wishlists',
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
                                    +'<img src= '+ item.product.productImages[0].url + ' alt="Gucci">'
                                    +'<button onclick="removeWishlistItem(`' + item.id + '`)" class="remove-btn quick-view"><i class="bi bi-trash3"></i></button>'
                                +'</div>'
                            +'<div class="product-info">'
                                +'  <h3 class="product-title ellipsis">'+ item.product.name +'</h3>'
                            +'<div class="product-price">'
                            +'    <span class="current-price"> ' + Math.round((item.product.price - (item.product.price * item.product.discountPrice) /100)).toLocaleString('vi-VN') +' đ</span>'
                                +' <span class="original-price"> ' + Math.round(item.product.price).toLocaleString('vi-VN') + ' đ</span>'
                            +'</div>'
                            + renderRating(item.product.evaluations)
                                +'<button class="add-to-cart-btn" onclick="addToCart(\'' + item.product.id.toString() + '\', \'' + item.product.productVariants[0].id.toString() + '\')">Thêm vào giỏ hàng <i class="bi bi-cart"></i></button>'
                            + '<div class="pb-3"><a href="/over-view-store/' + item.product.store.id + '" class="card-title"><i class="bi bi-shop"></i> ' +  item.product.store.name + '</a></div>'
                            +'</div>'
                            +    '</div>';

                        container.append(productHtml);
                    });
                } else {
                    container.html('<p>Không có sản phẩm nào.</p>');
                }

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
        const productsGrid = $('#product-for-you').get(0);
        const scrollLeftBtn = $('#scrollLeft').get(0);
        const scrollRightBtn = $('#scrollRight').get(0);

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

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>