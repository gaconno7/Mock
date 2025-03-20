<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<c:url value="/css/style.css" />">
    <style>
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            border-bottom: 1px solid #eee;
          }
      
          .logo {
            font-weight: bold;
            font-size: 24px;
          }
      
          .nav-links {
            display: flex;
            gap: 30px;
          }
      
          .nav-links a {
            text-decoration: none;
            color: #333;
          }
      
          .icons {
            display: flex;
            gap: 15px;
            align-items: center;
          }
      
          .ellipsis {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            width: 19vh !important;
          }
        body { background-color: #f8f9fa; }
        .cart-container { max-width: 900px; margin: auto; padding: 20px; }
        .cart-table img { width: 50px; margin-right: 10px; }
        .cart-total { border: 1px solid #ddd; padding: 20px; border-radius: 10px; }
        .btn-remove { color: red; font-size: 20px; text-decoration: none; cursor: pointer; }
        .btn-remove:hover { color: darkred; }
        .quantity-control { display: flex; align-items: center; }
        .quantity-control button { width: 30px; height: 30px; border: none; background-color: #ddd; cursor: pointer; }
        .quantity-control input { width: 40px; text-align: center; border: none; margin: 0 5px; }
    </style>
</head>
<body>
<%@ include file="header/header.jsp" %>

<div class="cart-container">
        <h2 class="mb-4">Giỏ hàng</h2>

        <!-- Bảng sản phẩm -->
        <table class="table cart-table">
            <thead class="table-light">
                <tr>
                    <th>Chọn</th>
                    <th>Sản phẩm</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th>Số tiền</th>
                    <th>Xóa</th>
                </tr>
            </thead>
            

            <tbody>
                <c:choose>
                    <c:when test="${not empty cartItems}">
                        <c:forEach var="item" items="${cartItems}">
                            <tr id="cart-item-${item.id}">
                                <td>
                                    <input type="checkbox" class="cart-checkbox" name="cartItemCheckbox" value="${item.id}" onchange="updateTotalCart()">
                                </td>

                                <td>
                                    <img src="${item.product.image}" alt="Ảnh sản phẩm">
                                    <div>
                                        <span>${item.product.name}</span>
                                        <c:if test="${not empty item.productVariant}">
                                            <br>
                                            <small class="text-muted">
                                                ${item.productVariant.attribute}: ${item.productVariant.value}
                                            </small>
                                        </c:if>
                                    </div>
                                </td>

                                <td><span id="price-${item.id}" class="price"><fmt:formatNumber type="number" value="${item.product.price}"/> VNĐ</span></td>
                                
                                <td>
                                    <div class="quantity-control">
                                        <button onclick="updateCart('${item.id}', -1)">-</button>
                                        <input type="text" id="quantity-${item.id}" value="${item.quantity}" readonly> 
                                        <button onclick="updateCart('${item.id}', 1)">+</button>
                                    </div>
                                </td>
                                <td><span class="subtotal" id="subtotal-${item.id}"><fmt:formatNumber type="number" value="${item.product.price * item.quantity}"/></span><span> VNĐ</span></td>
                                <td><span class="btn-remove" onclick="removeFromCart('${item.id}')">&times;</span></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" class="text-center">Giỏ hàng trống!</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>        
        </table>

        <!-- Tổng tiền -->
        <div class="cart-total mt-4">
            <h5>Hóa đơn</h5>
            <!-- <p>Subtotal: <strong><span id="subtotal-price">${totalCartPrice}</span> VNĐ</strong></p> -->
            <p>Phí giao hàng: <strong>Miễn phí</strong></p>
            <p>Tổng tiền: <strong><span id="selectedTotalPrice">0</span> VNĐ</strong></p>
            <button type="button" class="btn btn-danger w-100" onclick="proceedToCheckout();">
                Đặt hàng
            </button>
        </div>
    </div>

<script>
    function updateTotalCart() {
        let selectedItems = [];
    
        $("input[name='cartItemCheckbox']:checked").each(function () {
            selectedItems.push($(this).val()); 
        });
    
        console.log("Selected Items:", selectedItems); // Debug kiểm tra danh sách gửi đi
    
        $.ajax({
            url: "/user/cart/updateTotal",
            type: "POST",
            data: { selectedItems: selectedItems.join(",") }, // Gửi như form data
            success: function (response) {
                console.log("Response từ server:", response);
                //$("#selectedTotalPrice").text(response.totalSelectedCartPrice + " VNĐ");
                $("#selectedTotalPrice").text(parseFloat(response.totalSelectedCartPrice).toLocaleString("en-US"));
            },
            error: function (xhr) {
                console.error("Lỗi khi cập nhật tổng tiền:", xhr.status, xhr.responseText);
            }
        });
    }

    function updateCart(cartItemId, change) {
        let quantityInput = $('#quantity-' + cartItemId);

        let newQuantity = parseInt(quantityInput.val().trim()) + change;

        if (newQuantity < 1) return;

        // 🔍 Kiểm tra ID của phần tử giá
        let priceElement = $('#price-' + cartItemId);
    
        // 🛠️ Lấy giá sản phẩm
        let priceText = priceElement.text().trim();
    
        let price = parseFloat(priceText.replace(/[^\d.]/g, "")); // Loại bỏ ký tự không phải số
    
        let subtotal = price * newQuantity;
    
        $.ajax({
            url: "/user/cart/update",
            type: "POST",
            data: {
                cartItemId: cartItemId,
                quantity: newQuantity
            },
            success: function (response) {
                quantityInput.val(newQuantity);
                //$('#subtotal-' + cartItemId).text(subtotal);
                //$("#totalCartPrice").text(response.totalCartPrice);
                $('#subtotal-' + cartItemId).text(parseFloat(subtotal).toLocaleString("en-US"));
                //$("#selectedTotalPrice").text(parseFloat(response.totalCartPrice).toLocaleString("en-US"));

                updateTotalCart();
            },
            error: function () {
                alert("Lỗi khi cập nhật giỏ hàng!");
            }
        });
    }
    
    function removeFromCart(cartItemId) {
        $.ajax({
            url: "/user/cart/remove",
            type: "POST",
            data: { cartItemId: cartItemId },
            success: function () {
                $("#cart-item-" + cartItemId).remove();
                updateTotalCart()
            },
            error: function () {
                alert("Lỗi khi xóa sản phẩm khỏi giỏ hàng!");
            }
        });
    }
    
    function proceedToCheckout() {
        let selectedItems = [];
        
        $("input[name='cartItemCheckbox']:checked").each(function () {
            selectedItems.push($(this).val());
        });
    
        if (selectedItems.length === 0) {
            alert("Vui lòng chọn ít nhất một sản phẩm để thanh toán.");
            return;
        }
    
        $.ajax({
            type: "POST",
            url: "/user/cart/proceedToCheckout",
            contentType: "application/json",
            data: JSON.stringify({ selectedItems: selectedItems }),
            success: function () {
                window.location.href = "/user/order/process?selectedItems=" + selectedItems.join(",");
            },
            error: function () {
                alert("Đã xảy ra lỗi, vui lòng thử lại!");
            }
        });
    }
</script>
</body>
</html>
