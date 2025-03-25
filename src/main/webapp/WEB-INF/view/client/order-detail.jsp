<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:url value="/api/orders" var="APIOrder"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết hoá đơn</title>
    <link rel="stylesheet" href="<c:url value="/client/css/order-detail.css" />">
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
        <div class="return-status status-pending">
            ${order.status == 'cho-giao-hang' ? 'Chờ giao hàng' :
                order.status == 'cho-xu-ly' ? 'Chờ xử lý'
                    : order.status == 'da-huy' ? 'Đã huỷ'
                    : order.status == 'tra-hang' ? 'Trả hàng'
                    : order.status == 'hoan-thanh' ? 'Hoàn thành'
                    : order.status == 'van-chuyen' ? 'Vận chuyển'
                    : order.status == 'da-thanh-toan' ? 'Đã thanh toán'
                    : order.status == 'chua-thanh-toan' ? 'Chưa thanhh toán' : '' }</div>
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
            <div class="product-list">
                <h3>Thông tin sản phẩm (${order.orderDetails.size()})</h3>
                <c:forEach var="item" items="${order.orderDetails}">
                    <div class="product-item">
                        <img src="${item.product.productImages[0].url}" alt="placeholder" class="product-image">
                        <div class="product-details">
                            <div class="product-name">${item.product.name}</div>
                            <div class="product-price">${item.amount} x <fmt:formatNumber type="number" value="${(item.product.price - (item.product.price * item.product.discountPrice)/100)}"/> đ</div>
                        </div>
                    </div>
                </c:forEach>

            </div>
            <c:set var="totalPrice" value="0"/>
            <c:forEach var="item" items="${order.orderDetails}">
                <c:set var="itemPrice" value="${(item.product.price - (item.product.price * item.product.discountPrice) / 100)}"/>
                <c:set var="totalPrice" value="${totalPrice + itemPrice}"/>
            </c:forEach>
            <div class="return-summary">
                <h3>Tổng kết hoàn tiền</h3>
                <div class="summary-row">
                    <span>Giá trị sản phẩm</span>
                    <span><fmt:formatNumber type="number" value="${totalPrice}"/> đ</span>
                </div>
            </div>


            <c:if test="${order.status == 'cho-xu-ly'}">
                <div class="action-buttons">
                    <button class="btn btn-outline" onclick="cancelOrder()">Hủy yêu cầu</button>
                </div>
            </c:if>
        </div>
    </div>

    <c:if test="${not empty returnOrder}">
        <div class="return-section">
            <h2 class="section-title">Thông tin hoàn trả hàng</h2>

            <div class="return-form">
                <div class="form-group">
                    <h4>Tiêu đề: ${returnOrder.title}</h4>
                </div>

                <div class="form-group">
                    <p>Nội dung: ${returnOrder.content}</p>
                </div>

                <c:if test="${not empty returnOrder.firstImage}">
                    <div class="form-group">
                        <label class="form-label">Hình ảnh đính kèm:</label>
                        <div class="image-upload">
                            <c:if test="">
                                <img src="${not empty returnOrder.firstImage}" alt="Hình ảnh" class="upload-icon">
                            </c:if>
                            <c:if test="">
                                <img src="${not empty returnOrder.secondImage}" alt="Hình ảnh" class="upload-icon">
                            </c:if>
                            <c:if test="${not empty returnOrder.threeImage}">
                                <img src="${returnOrder.threeImage}" alt="Tải lên hình ảnh" class="upload-icon">
                            </c:if>
                        </div>
                    </div>
                </c:if>


            </div>
        </div>
    </c:if>
</div>
<script>
    function returnBack() {
        window.history.back();
    }

    function cancelOrder() {
        const choice = confirm("Bạn có muốn huỷ?");
        if(choice) {
            $.ajax({
                url: '${APIOrder}' + '/cancel/' + '${order.id}',
                type: 'PUT',
                success: function (response) {
                    alert(response.message);
                    window.location.href = '/user/order/history';
                },
                error: function (xhr) {
                    alert("Lỗi cập nhật: " + xhr.responseText);
                }
            })
        }
    }
</script>
</body>
</html>
