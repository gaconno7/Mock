<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        .form-check-input {
            margin-right: 10px;
        }
        .payment-icons img {
            width: 40px;
            margin-left: 5px;
        }
        .btn-danger {
            background-color: #d9534f;
            border: none;
            padding: 10px;
            width: 100%;
            font-size: 18px;
        }
        .apply-coupon {
            display: flex;
            gap: 10px;
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
                        <label class="form-label">Tỉnh/Thành phố<span class="text-danger">*</span></label>
                        <select id="province" class="form-select">
                            <option value="">Chọn tỉnh/thành phố</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">District</label>
                        <select id="district" class="form-select" disabled>
                            <option value="">Chọn quận/huyện</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ward</label>
                        <select id="ward" class="form-select" disabled>
                            <option value="">Chọn phường/xã</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Street Address<span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="address">
                    </div>
                </form>
            </div>
    
            <!-- Order Summary -->
            <div class="col-12 col-md-6">
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
                        <c:forEach var="item" items="${orderItems}">
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
                                <td>${item.product.price} VNĐ</td>
                                <td>${item.quantity}</td>
                                <td>${item.product.price * item.quantity} VNĐ</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="order-summary mt-4">
                    <h5>Order Summary</h5>
                    <p>Shipping: <strong>Free</strong></p>
                    <p id="couponMessage" class="text-danger"></p>
                    <p class="total-price">Total: ${totalPrice} VNĐ</p>
                </div>

                <div class="form-check mt-3">
                    <input class="form-check-input" type="radio" name="paymentMethod" value="bank">
                    <label class="form-check-label">Bank</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="paymentMethod" value="cod" checked>
                    <label class="form-check-label">Cash on delivery</label>
                </div>
                <div class="apply-coupon mt-3">
                    <input type="text" id="couponCode" class="form-control" placeholder="Coupon Code">
                    <button type="button" id="applyCouponBtn" class="btn btn-danger">Apply Coupon</button>
                </div>
                <!-- <form action="/order/confirm" method="post">
                    <input type="hidden" name="totalPrice" value="${totalPrice}">
                    <button type="submit" class="btn btn-danger mt-3">Confirm Order</button>
                </form> -->
                <button id="confirmOrderBtn" class="btn btn-danger mt-3">Confirm Order</button>
            </div>
        </div>
    </div>

<script>
    $(document).ready(function () {
        var provinceSelect = $("#province");
        var districtSelect = $("#district");
        var wardSelect = $("#ward");
    
        // Gọi API lấy danh sách tỉnh/thành phố
        $.ajax({
            url: "https://vn-public-apis.fpo.vn/provinces/getAll?limit=-1",
            method: "GET",
            dataType: "json",
            success: function (response) {
                if (response && response.data && response.data.data && Array.isArray(response.data.data)) {
                    var provinces = response.data.data;
                    provinceSelect.empty().append('<option value="">Chọn tỉnh/thành phố</option>');
    
                    provinces.forEach(function (province) {
                        provinceSelect.append('<option value="' + province.code + '">' + province.name_with_type + '</option>');
                    });
    
                    console.log("Danh sách tỉnh/thành phố đã tải:", provinces);
                } else {
                    console.error("Lỗi: Dữ liệu trả về không đúng định dạng");
                }
            },
            error: function (xhr, status, error) {
                console.error("Lỗi khi gọi API:", status, error);
            }
        });
    
        // Hàm reset dropdown
        function resetDropdown(selectElement, placeholder) {
            selectElement.empty().append('<option value="">' + placeholder + '</option>').prop("disabled", true);
        }
    
        // Khi chọn tỉnh -> Lấy danh sách quận/huyện
        provinceSelect.change(function () {
            var provinceId = $(this).val();
            resetDropdown(districtSelect, "Chọn quận/huyện");
            resetDropdown(wardSelect, "Chọn phường/xã");
    
            if (provinceId) {
                $.ajax({
                    url: "https://vn-public-apis.fpo.vn/districts/getByProvince?provinceCode=" + provinceId + "&limit=-1",
                    method: "GET",
                    dataType: "json",
                    success: function (response) {
                        if (response && response.data && response.data.data) {
                            var districts = response.data.data;
                            districtSelect.prop("disabled", false);
    
                            districts.forEach(function (district) {
                                districtSelect.append('<option value="' + district.code + '">' + district.name_with_type + '</option>');
                            });
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Lỗi khi lấy danh sách quận/huyện:", status, error);
                    }
                });
            }
        });
    
        // Khi chọn quận/huyện -> Lấy danh sách phường/xã
        districtSelect.change(function () {
            var districtId = $(this).val();
            resetDropdown(wardSelect, "Chọn phường/xã");
    
            if (districtId) {
                $.ajax({
                    url: "https://vn-public-apis.fpo.vn/wards/getByDistrict?districtCode=" + districtId + "&limit=-1",
                    method: "GET",
                    dataType: "json",
                    success: function (response) {
                        if (response && response.data && response.data.data) {
                            var wards = response.data.data;
                            wardSelect.prop("disabled", false);
    
                            wards.forEach(function (ward) {
                                wardSelect.append('<option value="' + ward.code + '">' + ward.name_with_type + '</option>');
                            });
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Lỗi khi lấy danh sách phường/xã:", status, error);
                    }
                });
            }
        });

        $("#confirmOrderBtn").click(function() {
            // Get address components
            var street = $("#address").val();
            var provinceText = $("#province option:selected").text();
            var districtText = $("#district option:selected").text();
            var wardText = $("#ward option:selected").text();
            var totalPrice = parseFloat($(".total-price").text().replace("Total: ", "").replace(" VNĐ", "").replace(/,/g, ""));

            var fullAddress = street;
            // Combine address components into a single string
            fullAddress += ", " + wardText + ", " + districtText + ", " + provinceText;
            
            // Get payment method
            // var paymentMethod = $("input[name='paymentMethod']:checked").val();
            
            // Prepare data to send
            var orderData = {
                address: fullAddress,
                totalPrice: totalPrice
                // We don't need to send orderItems because they are already in the session/controller
            };
            
            // Send AJAX request
            $.ajax({
                url: "/order/confirm",
                method: "POST",
                contentType: "application/json",
                data: JSON.stringify(orderData),
                success: function(response) {
                    // Successful response handling
                    if (response.success) {
                        // Redirect to order confirmation page
                        window.location.href = response.redirectUrl || "/order/success";
                    } else {
                        // Show error message
                        alert(response.message || "An error occurred processing your order. Please try again.");
                    }
                },
                error: function(xhr, status, error) {
                    // Error handling
                    console.error("Error submitting order:", error);
                    alert("An error occurred while processing your order. Please try again.");
                }
            });
        });

        $(document).ready(function () {
            $("#applyCouponBtn").click(function () {
                var couponCode = $("#couponCode").val();
                var totalPrice = parseFloat($(".total-price").text().replace(/[^0-9.]/g, "")); // Lấy số từ HTML
        
                $.ajax({
                    url: "/order/apply-coupon",
                    method: "POST",
                    data: { 
                        couponCode: couponCode, 
                        totalPrice: totalPrice 
                    },
                    success: function (response) {
                        if (response.success) {
                            $(".total-price").text("Total: " + response.newTotalPrice.toLocaleString() + " VNĐ"); // Cập nhật giá mới
                            $("#couponMessage").text(response.message).removeClass("text-danger").addClass("text-success"); // Hiển thị thông báo
                        }
                    },
                    error: function (xhr) {
                        $("#couponMessage").text(xhr.responseJSON.message || "Lỗi khi áp dụng mã giảm giá!")
                            .removeClass("text-success").addClass("text-danger"); // Hiển thị lỗi
                    }
                });
            });
        });
        
    });
</script>
</body>
</html>