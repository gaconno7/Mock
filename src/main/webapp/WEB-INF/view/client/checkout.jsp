<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body { background-color: #f8f9fa; }
        .checkout-container { max-width: 900px; margin: auto; padding: 20px; }
        .order-summary { border: 1px solid #ddd; padding: 20px; border-radius: 10px; background: #fff; }
        .total-price { font-size: 1.2em; font-weight: bold; }
    </style>
</head>
<body>

<div class="checkout-container">
    <h2 class="mb-4">Checkout</h2>

    <!-- Bảng danh sách sản phẩm -->
    <table class="table">
        <thead class="table-light">
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${cartItems}">
                <tr>
                    <td>
                        <img src="${item.product.image}" width="50px" alt="Ảnh sản phẩm">
                        ${item.product.name}
                        <c:if test="${not empty item.productVariant}">
                            <br>
                            <small class="text-muted">
                                ${item.productVariant.attribute}: ${item.productVariant.value}
                            </small>
                        </c:if>
                    </td>
                    <td><fmt:formatNumber value="${item.product.price}" type="currency"/> VNĐ</td>
                    <td>${item.quantity}</td>
                    <td><fmt:formatNumber value="${item.product.price * item.quantity}" type="currency"/> VNĐ</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Tổng tiền -->
    <div class="order-summary mt-4">
        <h5>Order Summary</h5>
        <p>Shipping: <strong>Free</strong></p>
        <p class="total-price">Total: <fmt:formatNumber value="${totalPrice}" type="currency"/> VNĐ</p>

        <form action="/order/confirm" method="post">
            <input type="hidden" name="totalPrice" value="${totalPrice}">
            <button type="submit" class="btn btn-success w-100">Confirm Order</button>
        </form>
    </div>
</div>

</body>
</html>
