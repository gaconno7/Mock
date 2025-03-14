<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Billing Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffffff;
        }
        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
        }
        .form-control {
            background-color: #f8f9fa;
            border: 1px solid #e0e0e0;
        }
        .table img {
            width: 50px;
            margin-right: 10px;
        }
        .order-summary {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row">
            <!-- Billing Details -->
            <div class="col-12 col-md-6">
                <h2 class="fw-bold">Billing Details</h2>
                <form id="checkoutForm">
                    <div class="mb-3">
                        <label class="form-label">First Name<span class="text-danger">*</span></label>
                        <input type="text" class="form-control" placeholder="">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Apartment, floor, etc. (optional)</label>
                        <input type="text" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Street Address<span class="text-danger">*</span></label>
                        <input type="text" class="form-control">
                    </div>
                </form>
            </div>
            
            <!-- Order Summary -->
            <div class="col-12 col-md-6">
                <h4 class="mt-4 fw-bold">Order Summary</h4>
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
                                    <img src="${item.product.image}" alt="Ảnh sản phẩm">
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
        </div>
    </div>
</body>
</html>
