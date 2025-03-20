<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/api/products" var="APIProduct"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa hàng</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/client/css/product-item.css"/> ">
    <link rel="stylesheet" href="<c:url value="/client/css/view-more.css"/> ">
</head>
<body>

<!-- Header/Navigation -->
<%@ include file="header/header.jsp" %>

<!-- Main Content -->
<div class="main-content">
    <!-- Sidebar -->
    <div class="sidebar">
        <h3>Danh mục</h3>
        <div class="list-container">
            <ul class="expandable-list">
                <li><a href="#" onclick="getAll()">Tất cả</a></li>
                <c:forEach var="item" items="${categories}">
                    <li><a href="#" onclick="setCategory(`${item.id}`)" class="category" id="category-id-${item.id}">${item.name} (${item.products.size()}+)</a></li>
                </c:forEach>
            </ul>
            <p class="toggle-btn">Xem thêm</p>
        </div>
        <h3>Giá</h3>
        <div class="price-range">
            <input type="number" placeholder="Từ" id="min-price-value" min="0" max="1000000" >
            <div class="range-separator">-</div>
            <input type="number" placeholder="Đến" id="max-price-value" min="1000001" maxlength="100000000">
            <div class="filter-btns">
                <button onclick="setPrice()">Áp dụng</button>
                <button onclick="removeAllValue()">Loại bỏ</button>
            </div>
        </div>
    </div>

    <!-- Products Section -->
    <div class="products-section">
        <div class="products-header">
            <div class="category-title">Tất cả sản phẩm</div>
            <div class="search-container">
                <input type="text" id="search-value" class="search-input" placeholder="Tìm kiếm ...">
                <button class="search-btn" onclick="setSearchValue()"><i class="bi bi-search"></i></button>
            </div>
            <div class="sort-section">
                <span>Sắp xếp theo:</span>
                <select onchange="setSortBy(this.value)">
                    <option value="latest">Mới nhất</option>
                    <option value="cheapest">Rẻ nhất</option>
                    <option value="best-rating">Đánh giá</option>
                </select>
            </div>
        </div>

        <!-- Products Grid -->
        <div class="products-grid" id="productContainer">

        </div>

        <!-- Pagination -->
        <div id="pagination" class="pagination-page">

        </div>
    </div>
</div>

<%@ include file="footer/footer.jsp" %>
<script>
    let categoryId = null, sortBy = null, minPrice = null, maxPrice = null, searchValue = null;


    function setCategory(value) {
        categoryId = value;
        $(".category").removeClass("active-element-a")
        $("#category-id-" + categoryId).removeClass("active-element-a").addClass("active-element-a");
        loadProducts(0);
    }

    function setSortBy(value) {
        sortBy = value;
        loadProducts(0);
    }

    function setPrice() {
        minPrice = $("#min-price-value").val();
        maxPrice = $("#max-price-value").val();
        loadProducts(0);
    }

    function setSearchValue() {
        searchValue = $("#search-value").val();
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

        let ratingHtml = '<div class="rating">';
        for (let i = 1; i <= averageRate; i++) {
            ratingHtml += '★';
        }
        ratingHtml += '<span> (' + evaluations.length + ' lượt đánh giá)</span></div>';

        return ratingHtml;
    }

    function loadProducts(page) {
        let data = { page: page };

        if (categoryId !== null) {
            data.categoryId = categoryId;
        }

        if (sortBy !== null) {
            data.sortBy = sortBy;
        }

        data.minPrice = minPrice !== null ? minPrice : 0;

        if(maxPrice !== null) {
            data.maxPrice = maxPrice;
        }

        if(searchValue !== null) {
            data.searchValue = searchValue;
        }

        console.log(data)
        $.ajax({
            url: '/api/products',
            type: 'GET',
            data: data,
            dataType: 'json',
            success: function(data) {
                let container = $('#productContainer');
                container.empty();
                if(data.content && data.content.length > 0) {
                    $("#wishlist-title").text('Danh sách yêu thích (' + data.content.length + ')');
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
<script>
    document.addEventListener("DOMContentLoaded", function () {
        categoryId = localStorage.getItem('categoryId');

        if (categoryId !== null) {
            setCategory(categoryId);
            localStorage.removeItem('categoryId');
        }

        const toggleBtn = document.querySelector(".toggle-btn");
        const listContainer = document.querySelector(".list-container");

        toggleBtn.addEventListener("click", function () {
            listContainer.classList.toggle("expanded");

            if (listContainer.classList.contains("expanded")) {
                toggleBtn.textContent = "Thu gọn";
            } else {
                toggleBtn.textContent = "Xem thêm";
            }
        });
    });
</script>

<script src="<c:url value="/client/js/addWishlist.js"/> " type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>