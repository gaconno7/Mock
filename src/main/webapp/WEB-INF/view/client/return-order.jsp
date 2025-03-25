<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/api/orders" var="APIOrder"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết hoá đơn</title>
    <link rel="stylesheet" href="<c:url value="/client/css/return-order.css" />">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>
<body>
<div class="container">
    <header>
        <a href="#" class="back-button">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M19 12H5M12 19l-7-7 7-7"/>
            </svg>
            <span onclick="returnBack()">Quay lại</span>
        </a>
        <div class="return-status status-pending">${order.status == 'cho-giao-hang' ? 'Chờ giao hàng' :
                order.status == 'cho-xu-ly' ? 'Chờ xử lý' :
                        order.status == 'da-huy' ? 'Đã huỷ' :
                                order.status == 'tra-hang' ? 'Trả hàng' :
                                        order.status == 'hoan-thanh' ? 'Hoàn thành' :
                                                order.status == 'van-chuyen' ? 'Vận chuyển' :
                                                        order.status == 'da-thanh-toan' ? 'Đã thanh toán' :
                                                                order.status == 'chua-thanh-toan' ? 'Chưa thanh toán' : ''}</div>
    </header>

    <div class="return-card">
        <div class="return-header">
            <div class="return-title">
                <h2>Thông tin đơn hàng: ${order.id}</h2>
            </div>

            <div class="return-info">
                <div class="info-item">
                    <div class="info-label">Ngày đặt hàng</div>
                    <div class="info-value">${order.orderDate.toString().substring(0,19)}</div>
                </div>

                <div class="info-item">
                    <div class="info-label">Địa chỉ nhận hàng</div>
                    <div class="info-value">${order.address}</div>
                </div>
            </div>
        </div>

        <div class="return-body">
                <h3 class="review-form-title">Nội dung huỷ</h3>
                <form id="return-order-form" enctype="multipart/form-data">
                    <div class="form-group">
                        <input type="hidden" name="order" class="form-control" value="${order.id}">
                    </div>

                    <div class="form-group">
                        <label for="title">Tiêu đề</label>
                        <input type="text" id="title" name="title" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="content">Nội dung</label>
                        <textarea id="content" name="content" class="form-control" required></textarea>
                    </div>
                        <div class="file-upload">
                            <div class="custom-file-upload">
                                <label for="file" class="custom-upload-button">Ảnh minh hoạ (nếu có)</label>
                                <input type="file" id="file" name="files" accept=".png, .jpg, .jpeg" multiple>
                                <span id="file-name">Chưa có tệp nào được chọn</span>
                            </div>
                            <div id="preview-images" class="image-preview"></div>
                        </div>
                    <div class="action-buttons">
                        <button type="button" class="btn btn-outline" id="btn-submit-return-order">Hủy yêu cầu</button>
                    </div>
                </form>
        </div>
    </div>
</div>
<script>

    function returnBack() {
        window.history.back();
    }
    $(document).ready(function() {
        $("#btn-submit-return-order").click(function(event) {
            event.preventDefault();
            cancelOrder();
        });
        $("#file").on("change", function (event) {
            previewImages(event.target);
        });
    });

    function cancelOrder() {
        if (!confirm("Bạn có muốn huỷ?")) return;

        var form = $("#return-order-form")[0];
        if (!form) {
            alert("Không tìm thấy form!");
            return;
        }

        var formData = new FormData(form);

        var files = $("#file")[0].files;
        if (files.length > 0) {
            formData.append('files', files[0]);
        }

        console.log("FormData:", Array.from(formData.entries()));

        $.ajax({
            url: '${APIOrder}' +'/return-order/' + '${order.id}',
            type: 'PUT',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                alert(response.message);
                window.location.href = '/user/order/history';
            },
            error: function(xhr) {
                alert("Lỗi cập nhật: " + xhr.responseText);
            }
        });
    }
    function previewImages(input) {
        var previewContainer = $("#preview-images");
        previewContainer.empty(); // Xóa ảnh cũ trước khi thêm mới

        var files = input.files;
        if (files.length > 3) {
            alert("Chỉ được chọn tối đa 3 ảnh!");
            return;
        }

        for (let i = 0; i < Math.min(files.length, 3); i++) {
            let file = files[i];
            if (file.type.startsWith("image/")) { // Kiểm tra xem có phải ảnh không
                let reader = new FileReader();

                reader.onload = function (e) {
                    let img = $("<img>").attr("src", e.target.result).addClass("preview-image");
                    previewContainer.append(img);
                };

                reader.readAsDataURL(file);
            }
        }
    }

</script>
</body>
</html>
