<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm - Phân trang AJAX</title>
    <!-- Thêm jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        /* Định dạng cho khối sản phẩm */
        .product {
            border: 1px solid #ccc;
            padding: 10px;
            margin: 10px 0;
        }
        .product img {
            max-width: 150px;
            display: block;
            margin-bottom: 5px;
        }
        /* Định dạng cho phân trang */
        .pagination {
            margin: 20px 0;
        }
        .pagination a {
            display: inline-block;
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid #ccc;
            color: #333;
            text-decoration: none;
            cursor: pointer;
        }
        .pagination a.active {
            background-color: #333;
            color: #fff;
            font-weight: bold;
        }
    </style>
</head>
<body>
<h1>Danh sách sản phẩm</h1>
<!-- Container chứa danh sách sản phẩm -->
<div id="productContainer"></div>
<!-- Container chứa phân trang -->
<div id="pagination" class="pagination"></div>

<script>
    /**
     * Hàm loadProducts: gọi API theo trang và cập nhật giao diện
     * @param {Number} page - số trang (0-indexed) cần tải
     */
    function loadProducts(page) {
        $.ajax({
            url: '/api/wishlists',  // Thay đổi URL endpoint phù hợp
            type: 'GET',
            data: { page: page },
            dataType: 'json',
            success: function(data) {
                // Làm rỗng container trước khi hiển thị dữ liệu mới
                var container = $('#productContainer');
                container.empty();

                // Kiểm tra mảng content có dữ liệu không
                if(data.content && data.content.length > 0) {
                    $.each(data.content, function(index, item) {
                        // Xây dựng HTML hiển thị thông tin sản phẩm
                        var productHtml =
                        '<div class="product-card">'
                        +'<div class="product-image">'
                        +'<img src= ' + item.product.image + ' alt="Gucci">'
                        +'<button onclick="removeWishlistItem(` '+item.id+'`)" class="remove-btn quick-view"><i class="bi bi-trash3"></i></button>'
                        +'</div>'
                        +' <div class="product-info">'
                        +'  <h3 class="product-title">'+ item.product.name +'</h3>'
                        +' <div class="product-price">'
                        +'    <span class="current-price"> ' + item.product.price +'</span>'
                        +' <span class="original-price"> ' + item.product.discountPrice + '</span>'
                        +' </div>'

                        +'  <div class="rating">★<span>(  lượt đánh giá)</span></div>'
                        +'  <button class="add-to-cart-btn">'
                        +'   Thêm vào giỏ hàng   <i class="bi bi-cart"></i>'
                        +' </button>'
                        +'  </div>     </div>';


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

    /**
     * Hàm tạo phân trang dựa trên dữ liệu JSON từ API
     * Sử dụng các trường: totalPages, number (trang hiện tại, 0-indexed)
     */
    function createPagination(data) {
        var paginationDiv = $('#pagination');
        paginationDiv.empty();

        var totalPages = data.totalPages;
        var currentPage = data.number; // đang dùng số trang (0-indexed) như trong JSON

        // Nút "Trước"
        if (currentPage > 0) {
            paginationDiv.append(
                '<a href="#" data-page="' + (currentPage - 1) + '">&laquo; Trước</a>'
            );
        }

        // Hiển thị các trang phân trang
        for (var i = 0; i < totalPages; i++) {
            var activeClass = (i === currentPage) ? 'active' : '';
            paginationDiv.append(
                '<a href="#" class="' + activeClass + '" data-page="' + i + '">' + (i + 1) + '</a>'
            );
        }

        // Nút "Tiếp theo"
        if (currentPage < totalPages - 1) {
            paginationDiv.append(
                '<a href="#" data-page="' + (currentPage + 1) + '">Tiếp theo &raquo;</a>'
            );
        }
    }

    // Lắng nghe sự kiện click trên các liên kết phân trang
    $(document).on('click', '#pagination a', function(e) {
        e.preventDefault();
        var page = $(this).data('page');
        loadProducts(page);
    });

    // Khi trang JSP được tải, gọi loadProducts để tải trang đầu tiên (có thể là page 0)
    $(document).ready(function() {
        loadProducts(0);
    });
</script>
</body>
</html>
