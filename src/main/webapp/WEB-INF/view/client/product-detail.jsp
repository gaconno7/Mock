<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="urlEvaluation" value="/api/evaluations"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Havic HV G-92 Gamepad | Exclusive</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/css/product-detail.css"/> ">
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
        <span><a class="btn btn-outline-info" href="<c:url value="/user/wishlist"/> "><i class="bi bi-bag-heart"></i></a></span>
        <span><a class="btn btn-outline-info" href="<c:url value="/user/cart"/> "><i class="bi bi-cart"></i></a></span>
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

<!-- Breadcrumb -->
<div class="breadcrumb">
    <a href="<c:url value="/home"/>">Trang chủ</a> <span>/</span> <a href="<c:url value="/product/all"/> ">Sản phẩm</a> <span>/</span>
    <a href="<c:url value="/product/all?category-id=${product.category.id}"/>">${product.category.name}</a>
</div>

<!-- Product Section -->
<!-- <div class="product-container">
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
        <div class="price">${product.price}</div>
        <div class="description">
            ${product.description}
        </div>
        <div class="divider"></div>

        <div class="options-label">Đặc điểm:</div>
        <div class="size-options">
            <c:forEach var="item" items="${product.productVariants}">
                <div class="size-option selected">${item.attribute} - ${item.value}</div>
            </c:forEach>
        </div>
        <div class="quantity">
            <div class="quantity-input">
                <button>-</button>
                <input type="text" value="0">
                <button>+</button>
            </div>
            <button class="buy-now">Mua ngay</button>
            <button class="wishlist"><i class="bi bi-heart"></i></button>
        </div>

    </div>
</div> -->

<div class="product-container">
    <div class="product-images">
        <div class="thumbnails">
            <c:forEach var="image" items="${product.productImages}">
                <div class="thumbnail">
                    <img src="${image.url}" class="object-fit" onclick="changeImage('${image.url}')" width="70vh" height="70vh" alt="Image">
                </div>
            </c:forEach>
        </div>
        <div class="main-image">
            <img id="main-product-image" class="object-fit" width="550vh" height="550vh" 
                 src="${not empty product.productImages ? product.productImages[0].url : ''}" 
                 alt="${product.name}">
        </div>
    </div>
    
    <div class="product-details">
        <h1 class="product-title">${product.name}</h1>
        <div class="price"><span id="product-price">${product.price}</span> VNĐ</div>
        <div class="description">${product.description}</div>
        <div class="divider"></div>

        <!-- Chọn phiên bản sản phẩm -->
        <div class="options-label">Đặc điểm:</div>
        <div class="size-options">
            <c:forEach var="variant" items="${product.productVariants}">
                <div class="size-option" data-variant-id="${variant.productVariantId}">
                    ${variant.attribute} - ${variant.value}
                </div>
            </c:forEach>
        </div>

        <!-- Số lượng -->
        <div class="quantity">
            <div class="quantity-input">
                <button onclick="changeQuantity(-1)">-</button>
                <input type="text" id="quantity" value="1">
                <button onclick="changeQuantity(1)">+</button>
            </div>
        </div>

        <!-- Nút thêm vào giỏ hàng -->
        <button class="buy-now" onclick="addToCart('${product.id}')">Mua ngay</button>
        <button class="wishlist"><i class="bi bi-heart"></i></button>
    </div>
</div>




<!-- Customer Reviews Section -->
<div class="reviews-section">
    <div class="section-heading">
        <h2>Đánh giá của khách hàng</h2>
    </div>

    <div class="review-summary">
        <div class="average-rating">
            <div class="big-rating">${averageRate} ★</div>
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

    <!-- Write Review Form -->
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

    <div class="review-filters">
        <div class="review-filter active">All</div>
        <div class="review-filter">5 ★</div>
        <div class="review-filter">4 ★</div>
        <div class="review-filter">3 ★</div>
        <div class="review-filter">2 ★</div>
        <div class="review-filter">1 ★</div>
    </div>

    <div class="review-list">
        <c:forEach var="item" items="${evaluations}">
        <div class="review-item">
            <div class="review-header">
                <div class="reviewer-info">
                    <img src="${item.user.avatar}" class="reviewer-avatar" />
                    <div>
                        <div class="reviewer-name">${item.user.fullname}
                        </div>
                        <div class="rating">
                        <c:forEach var="i" begin="1" end="${item.rate}" step="1" >
                            ★
                        </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="review-date">${item.createdDate.toString().substring(0,10)}</div>
            </div>
            <div class="review-content">
                <strong>${item.title}</strong>
                <p>${item.review}</p>
            </div>
            <c:if test="${not empty item.image}">
                <div class="review-images">
                    <img class="review-image" src="${item.image}"/>
                </div>
            </c:if>
            <div class="review-feedback">
<%--                <div class="review-btn">🔄 Report</div>--%>
            </div>
        </div>
        </c:forEach>
    </div>
    <div class="related-products" style="border-top: 1px solid #eee;">
        <div class="related-title">
            <h3>Sản phẩm tương tự</h3>
        </div>
        <div class="products-grid">
            <c:if test="${not empty relatedProducts}">
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
                            <button type="button" class="btn-add-cart">Thêm giỏ hàng</button>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            let selectedVariantId = null;
        
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
            });
        });

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
                    console.log('Upload thành công:', response);
                    alert("Lưu đánh giá thành công!");
                },
                error: function(xhr, status, error) {
                    console.error('Lỗi khi upload:', error);
                    alert("Có lỗi xảy ra, vui lòng thử lại!");
                }
            });
        }

        function changeImage(url) {
            $("#main-product-image").attr("src", url);
        }



    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</body>
</div>
</body>

</html>