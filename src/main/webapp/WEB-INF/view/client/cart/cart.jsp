<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .cart-container { max-width: 1000px; margin: auto; padding: 40px 20px; }
        .cart-table th, .cart-table td { text-align: center; vertical-align: middle; padding: 15px; }
        .cart-table img { width: 50px; }
        .remove-btn { color: red; cursor: pointer; }
        .quantity-control button { border: none; background: #ddd; padding: 5px 10px; cursor: pointer; }
        .quantity-control input { width: 40px; text-align: center; border: none; }
    </style>
</head>
<body>
    <div class="cart-container">
        <h3>Shopping Cart</h3>
        
        <table class="table cart-table mt-3">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="cart-content">
                <c:forEach var="item" items="${cartItems}">
                    <tr>
                        <td><img src="${item.product.image}" alt=""> ${item.product.name}</td>
                        <td>$${item.product.price}</td>
                        <td>
                            <div class="quantity-control">
                                <button class="update-quantity" data-id="${item.id}" data-change="-1">-</button>
                                <input type="text" value="${item.quantity}" readonly>
                                <button class="update-quantity" data-id="${item.id}" data-change="1">+</button>
                            </div>
                        </td>
                        <!-- <td>$<span class="subtotal">${item.totalPrice}</span></td>
                        <td><span class="remove-btn" data-id="${item.id}">&times;</span></td> -->
                        <td>$<span class="subtotal" id="subtotal-${item.id}">${item.totalPriceFormat}</span></td>
                        <td><span class="remove-btn" data-id="${item.id}">&times;</span></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <h5>Total: $<span id="totalPrice">${totalCartPrice}</span></h5>
    </div>

    <script>
        $(document).ready(function () {
            attachCartEvents();
        });
        
        function attachCartEvents() {
            $(document).off("click", ".update-quantity").on("click", ".update-quantity", function () {
                let cartItemId = $(this).data("id");
                let delta = parseInt($(this).data("change"));
                let input = $(this).siblings("input");
                let currentQuantity = parseInt(input.val());
                let newQuantity = currentQuantity + delta;
        
                if (newQuantity < 1) {
                    return;
                }
        
                updateCart(cartItemId, newQuantity);
            });
        
            $(document).off("click", ".remove-btn").on("click", ".remove-btn", function () {
                let cartItemId = $(this).data("id");
                removeCartItem(cartItemId);
            });
        }
        
        $(document).ready(function () {
            $(".update-quantity").click(function () {
                let cartItemId = $(this).data("id");
                let delta = parseInt($(this).data("change"));
                let input = $(this).siblings("input");
                let currentQuantity = parseInt(input.val());
                let newQuantity = currentQuantity + delta;
        
                if (newQuantity < 1) {
                    return;
                }
        
                updateCart(cartItemId, newQuantity);
            });
        
            $(".remove-btn").click(function () {
                let cartItemId = $(this).data("id");
                removeCartItem(cartItemId);
            });
        });
        
        function updateCart(cartItemId, quantity) {
            $.ajax({
                url: "/cart/update",
                type: "POST",
                data: { cartItemId: cartItemId, quantity: quantity },
                success: function (response) {
                    $("#cart-content").html($(response).find("#cart-content").html());
                    $("#totalPrice").text($(response).find("#totalPrice").text());
                },
                error: function (xhr) {
                    alert("Cập nhật thất bại! " + xhr.responseText);
                }
            });
        }
        
        function removeCartItem(cartItemId) {
            $.ajax({
                url: "/cart/remove",
                type: "POST",
                data: { cartItemId: cartItemId },
                success: function (response) {
                    $("#cart-content").html($(response).find("#cart-content").html());
                    $("#totalPrice").text($(response).find("#totalPrice").text());
                },
                error: function (xhr) {
                    alert("Xóa sản phẩm thất bại! " + xhr.responseText);
                }
            });
        }
        
        
    </script>


    
</body>
</html>