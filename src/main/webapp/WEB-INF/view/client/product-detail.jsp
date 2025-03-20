<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="urlEvaluation" value="/api/evaluations"/>
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
    <link rel="stylesheet" href="<c:url value="/client/css/product-detail.css"/> ">
</head>

<body>

<!-- Header -->
<%@ include file="header/header.jsp" %>

<div class="breadcrumb">
    <a href="<c:url value="/home"/>">Trang chủ</a> <span>/</span> <a href="<c:url value="/product/all"/> ">Sản phẩm</a> <span>/</span>
    <a href="<c:url value="/product/all?category-id=${product.category.id}"/>">${product.category.name}</a>
</div>

<!-- Product Section -->
<div class="product-container">
    <div class="product-images">
        <div class="thumbnails">
            <c:forEach var="image" items="${product.productImages}" >
            <div class="thumbnail"><img src="${image.url}" class="object-fit" onclick="changeImage(`${image.url}`)" width="70vh" height="70vh" alt="Image"></div>
            </c:forEach>
        </div>
        <div class="main-image">
            <img id="main-product-image" class="object-fit" width="550vh" height="550vh" src="${product.productImages[0].url}" alt="Havic HV G-92 Gamepad">
        </div>
    </div>
    <div class="product-details">
        <h1 class="product-title">${product.name}</h1>
        <div class="original-price">${product.price} đ</div>
        <div class="price">${product.price - (product.price * product.discountPrice)/100} đ</div>
        <div class="size-options">
            <c:set var="totalRate" value="0" />
            <c:forEach var="evaluation" items="${product.evaluations}">
                <c:set var="totalRate" value="${totalRate + evaluation.rate}" />
            </c:forEach>
            <div class="rating">
                <c:forEach var="i" begin="1" end="${product.evaluations.size() > 0 ? totalRate / product.evaluations.size() : 0}" step="1">
                    ★
                </c:forEach>
                <span>(${product.evaluations.size()} lượt đánh giá)</span>
            </div>
        </div>
        <div class="options-label">Đặc điểm:</div>
        <div class="size-options">
            <c:forEach var="variant" items="${product.productVariants}">
                <div class="size-option" data-variant-id="${variant.productVariantId}">
                        ${variant.attribute} - ${variant.value}
                </div>
            </c:forEach>
        </div>
        <div class="quantity">
            <div class="quantity">
                <div class="quantity-input">
                    <button onclick="changeQuantity(-1)">-</button>
                    <input type="text" id="quantity" value="1">
                    <button onclick="changeQuantity(1)">+</button>
                </div>
            </div>

            <!-- Nút thêm vào giỏ hàng -->
            <button class="buy-now" onclick="addToCart('${product.id}')">Mua ngay</button>
            <button class="wishlist" onclick="addItemToWishlist(`${sessionScope.user.id}`, `${product.id}`)"><i class="bi bi-heart"></i></button>
        </div>
    </div>
</div>
<div class="reviews-section">
    <div class="section-heading">
        <h2>Mô tả</h2>
    </div>

    <div class="review-summary">
        <div class="description">
            <c:out value="${product.description}" escapeXml="false" />
        </div>
    </div>


</div>
<!-- Customer Reviews Section -->
<div class="reviews-section">
    <div class="section-heading">
        <h2>Đánh giá của khách hàng</h2>
    </div>

    <div class="review-summary">
        <div class="average-rating">
            <div class="big-rating">${averageRate.toString().substring(0,3)} ★</div>
            <div>${countEvaluation} lượt đánh giá</div>
        </div>

        <div class="star-breakdown">
            <div class="star-row">
                <div class="star-label">5 ★</div>
                <div class="star-bar-container">
                    <div class="star-bar" style="width: ${countRate5/evaluations.size()}%"></div>
                </div>
                <div class="star-count">${countRate5}</div>
            </div>
            <div class="star-row">
                <div class="star-label">4 ★</div>
                <div class="star-bar-container">
                    <div class="star-bar" style="width: ${countRate4/evaluations.size()}%"></div>
                </div>
                <div class="star-count">${countRate4}</div>
            </div>
            <div class="star-row">
                <div class="star-label">3 ★</div>
                <div class="star-bar-container">
                    <div class="star-bar" style="width: ${countRate3/evaluations.size()}%"></div>
                </div>
                <div class="star-count">${countRate3}</div>
            </div>
            <div class="star-row">
                <div class="star-label">2 ★</div>
                <div class="star-bar-container">
                    <div class="star-bar" style="width: ${countRate2/evaluations.size()}%"></div>
                </div>
                <div class="star-count">${countRate2}</div>
            </div>
            <div class="star-row">
                <div class="star-label">1 ★</div>
                <div class="star-bar-container">
                    <div class="star-bar" style="width: ${countRate1/evaluations.size()}%"></div>
                </div>
                <div class="star-count">${countRate1}</div>
            </div>
        </div>
    </div>

    <c:if test="${isOrder}">
        <div class="review-form-container">
            <h3 class="review-form-title">Đánh giá</h3>
            <form id="evaluation-form" enctype="multipart/form-data" >
                <div class="form-group">
                    <label>Bình chọn</label>
                    <div class="star-rating-input">
                        <input type="hidden" name="rating" id="rating-value" value="4">
                        <label class="active" data-value="1">★</label>
                        <label class="active" data-value="2">★</label>
                        <label class="active" data-value="3">★</label>
                        <label class="active" data-value="4">★</label>
                        <label data-value="5">★</label>
                    </div>
                </div>

                <div class="form-group">
                    <input type="hidden" name="product-id" class="form-control" value="${product.id}">
                </div>

                <div class="form-group">
                    <label for="review-title">Tiêu đề</label>
                    <input type="text" id="review-title" name="review-title" class="form-control">
                </div>

                <div class="form-group">
                    <label for="review-content">Nội dung</label>
                    <textarea id="review-content" name="review-content" class="form-control"></textarea>
                </div>

                <div class="form-group">
                    <label>Ảnh minh hoạ (nếu có)</label>
                    <div class="file-upload">
                        <input type="file" id="file" name="files">
                    </div>
                </div>

                <button type="button" id="btn-submit" class="form-submit-btn">Lưu</button>
            </form>

        </div>
    </c:if>

    <div class="review-filters">
        <div class="review-filter filter-0 active" onclick="setRate('0')">All</div>
        <div class="review-filter filter-5" onclick="setRate('5')">5 ★</div>
        <div class="review-filter filter-4" onclick="setRate('4')">4 ★</div>
        <div class="review-filter filter-3" onclick="setRate('3')">3 ★</div>
        <div class="review-filter filter-2" onclick="setRate('2')">2 ★</div>
        <div class="review-filter filter-1" onclick="setRate('1')">1 ★</div>
    </div>

    <div class="review-list mb-5" id="review-list-item">

    </div>
    <div id="pagination" class="pagination-page">

    </div>

    <c:if test="${not empty relatedProducts}">
    <div class="related-products" style="border-top: 1px solid #eee;">
        <div class="related-title">
            <h3>Sản phẩm tương tự</h3>
        </div>
        <div class="products-grid">
            <c:forEach items="${relatedProducts}" var="item">
                    <div class="product-card">
                        <div class="card-actions">
                            <button class="card-action-btn"><i class="bi bi-heart"></i></button>
                            <button class="card-action-btn"><a href="<c:url value="/product/${item.id}"/> "><i class="bi bi-eye"></i></a>
                            </button>
                        </div>
                        <c:if test="${not empty item.productImages}">
                            <img src="${item.productImages[0].url}" alt="${item.name}">
                        </c:if>
                        <h4 class="product-card-title">${item.name}</h4>
                        <div class="product-card-price">
                            <span class="current-price">${item.discountPrice}</span>
                            <span class="original-price">${item.price}</span>
                        </div>
                        <c:set var="totalRate" value="0" />
                        <c:forEach var="evaluation" items="${item.evaluations}">
                            <c:set var="totalRate" value="${totalRate + evaluation.rate}" />
                        </c:forEach>
                        <div class="product-card-rating">
                            <c:forEach var="i" begin="1" end="${item.evaluations.size() > 0 ? totalRate / item.evaluations.size() : 0}" step="1">
                                ★
                            </c:forEach>
                            <span>(${item.evaluations.size()} lượt đánh giá)</span>
                        </div>
                        <div class="product-card-rating">
                            <button class="buy-now" onclick="setVariant(`${item.productVariants[0].id}`);addToCart('${item.id}')">Mua ngay</button>
                        </div>
                    </div>
                </c:forEach>
        </div>
    </div>
    </c:if>
    <script>
        let rate;
        let selectedVariantId = null;

        function setRate(value) {
            rate = value;
            $('.filter-0').removeClass('active');
            $('.filter-1').removeClass('active');
            $('.filter-2').removeClass('active');
            $('.filter-3').removeClass('active');
            $('.filter-4').removeClass('active');
            $('.filter-5').removeClass('active');
            $('.filter-' + value).removeClass('active').addClass('active');
            loadEvaluation(0);
        }
        function renderRating(rate) {
             let ratingHtml = '';
            for (let i = 1; i <= rate; i++) {
                ratingHtml += '<i class="bi bi-star-fill"></i>';
            }

            return ratingHtml;
        }

        function setVariant(value) {
            selectedVariantId = value;
        }

        $(document).ready(function() {

            $('.star-rating-input label').on('click', function() {
                var value = $(this).data('value');
                $('#rating-value').val(value);

                // Cập nhật giao diện
                $('.star-rating-input label').removeClass('active');
                $('.star-rating-input label').each(function() {
                    if ($(this).data('value') <= value) {
                        $(this).addClass('active');
                    }
                });
            });

            $("#btn-submit").click(function(event) {
                event.preventDefault();
                addEvaluation();
                loadEvaluation(0);
            });

            loadEvaluation(0);
        //



            // Chọn phiên bản sản phẩm
            $(".size-option").click(function () {
                $(".size-option").removeClass("selected");
                $(this).addClass("selected");
                selectedVariantId = $(this).data("variant-id");
            });

            // Thay đổi ảnh chính khi chọn ảnh nhỏ
            function changeImage(imageUrl) {
                $("#main-product-image").attr("src", imageUrl);
            }

            // Thay đổi số lượng
            function changeQuantity(change) {
                let quantityInput = $("#quantity");
                let currentQuantity = parseInt(quantityInput.val());

                if (!isNaN(currentQuantity) && currentQuantity + change > 0) {
                    quantityInput.val(currentQuantity + change);
                }
            }

            // Thêm vào giỏ hàng AJAX
            function addToCart(productId) {
                let quantity = $("#quantity").val();
                if(quantity === null) quantity = 1
                if (!selectedVariantId) {
                    alert("Vui lòng chọn phiên bản sản phẩm!");
                    return;
                }

                $.ajax({
                    url: "/user/cart/add",
                    type: "POST",
                    data: {
                        productId: productId,
                        productVariantId: selectedVariantId,
                        quantity: quantity
                    },
                    success: function (response) {
                        alert(response.message);
                        $("#totalCartPrice").text(response.totalCartPrice);
                    },
                    error: function () {
                        alert("Lỗi khi thêm vào giỏ hàng!");
                    }
                });
            }

            window.changeImage = changeImage;
            window.changeQuantity = changeQuantity;
            window.addToCart = addToCart;

        });

        function loadEvaluation(page) {
            let data = { page: page };
            data.productId = '${product.id}';
            if(rate !== null) {
                data.rate = rate;
            }

            $.ajax({
                url : '${urlEvaluation}',
                type: 'GET',
                data: data,
                success: function success (response) {
                    let container = $('#review-list-item');
                    container.empty();
                    console.log(response)
                    if(response.content && response.content.length > 0) {
                        $.each(response.content, function(index, item) {
                            console.log(item)
                            let productHtml =
                                '<div class="review-item">'
                                +'<div class="review-header">'
                                +'<div class="reviewer-info">'
                                +'<img src="'+item.user.avatar +'" class="reviewer-avatar" />'
                                +'<div>'
                                +'<div class="reviewer-name">' + item.user.fullname + ' </div>'
                                +'<div class="rating">'
                                + renderRating(item.rate)
                                +' </div>'
                                +'</div>'
                                +'  </div>'
                                +' <div class="review-date">'+(new Date(item.createdDate)).toLocaleString()+'</div>'

                                +' </div>'
                                +' <div class="review-content">'
                                +'     <strong>' + item.title+'</strong>'
                                +'     <p>'+item.review+'</p>'
                                +'  </div>'
                                + showImageEvaluation(item.image)
                                +'    </div>';
                            container.append(productHtml);
                        });
                    }
                    createPagination(response);
                },
                error: function(xhr, status, error) {
                    console.error('Lỗi khi upload:', error);
                }
            })
        }

        function showImageEvaluation(url) {
            if(url === '') return '';
            return '<div class="review-images">'
                +'   <img class="review-image" src="' + url + '"/>'
                +'</div>';
        }

        function getStarRating() {
            return $('.star-rating-input label.active').length;
        }

        function addEvaluation() {

            var formData = new FormData($("#evaluation-form")[0]);

            var files = $('#file')[0].files;

            if (files.length > 0) {
                formData.append('files', files[0]);
            }
            formData.append("rate", getStarRating());
            $.ajax({
                url: `${urlEvaluation}`,
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    loadEvaluation(0);
                },
                error: function(xhr, status, error) {
                    console.error('Lỗi khi upload:', error);
                }
            });
        }

        function changeImage(url) {
            $("#main-product-image").attr("src", url);
        }


        function createPagination(data) {
            let paginationDiv = $('#pagination');
            paginationDiv.empty();

            let totalPages = data.totalPages;
            let currentPage = data.number;

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
            loadEvaluation(page);
        });

    </script>
    <script>
        $(document).ready(function () {

        });





    </script>
    <script src="<c:url value="/client/js/addWishlist.js"/> " type="text/javascript"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

    <%@ include file="footer/footer.jsp" %>

</div>
</body>

</html>