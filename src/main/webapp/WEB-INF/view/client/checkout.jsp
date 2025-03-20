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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        
        body {
            font-family: Arial, sans-serif;
            background-color: #ffffff;
        }
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
        .apply-voucher {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>
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
    <div class="container-fluid px-5">
        <div class="row">
            <!-- Billing Details -->
            <div class="col-12 col-lg-5">
                <h2 class="fw-bold">Chi tiết đơn hàng</h2>
                <form id="checkoutForm">
                    <div class="mb-3">
                        <label class="form-label">Họ và tên<span class="text-danger">*</span></label>
                        <input type="text" class="form-control" placeholder="" value="${name}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Căn hộ, tầng, v.v. (không bắt buộc)</label>
                        <input type="text" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Tỉnh/Thành phố<span class="text-danger">*</span></label>
                        <select id="province" class="form-select">
                            <option value="">Chọn tỉnh/thành phố</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Quận/Huyện</label>
                        <select id="district" class="form-select" disabled>
                            <option value="">Chọn quận/huyện</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phường/Xã</label>
                        <select id="ward" class="form-select" disabled>
                            <option value="">Chọn phường/xã</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Địa chỉ chi tiết<span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="address" value="${address}">
                    </div>
                </form>
            </div>
    
            <!-- Order Summary -->
            <div class="col-12 col-lg-7">
                <!-- Bảng danh sách sản phẩm -->
                <table class="table align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Sản phẩm</th>
                            <th class="text-end">Đơn giá</th>
                            <th class="text-center">Số lượng</th>
                            <th class="text-end">Số tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${orderItems}">
                            <tr>
                                <!-- Ảnh và tên sản phẩm trên cùng hàng -->
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="${item.product.image}" class="rounded me-2" width="50px" height="50px" alt="Ảnh sản phẩm">
                                        <div>
                                            <strong>${item.product.name}</strong><br>
                                            <c:if test="${not empty item.productVariant}">
                                                <small class="text-muted">${item.productVariant.attribute}: ${item.productVariant.value}</small>
                                            </c:if>
                                        </div>
                                    </div>
                                </td>
                                <!-- Giá sản phẩm -->
                                <td class="text-end">
                                    <fmt:formatNumber type="number" value="${item.product.price}" pattern="#,##0"/> VNĐ
                                </td>
                                <!-- Số lượng -->
                                <td class="text-center">${item.quantity}</td>
                                <!-- Thành tiền -->
                                <td class="text-end">
                                    <fmt:formatNumber type="number" value="${item.product.price * item.quantity}" pattern="#,##0"/> VNĐ
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                

                <div class="order-summary mt-4">
                    <h5>Đơn hàng</h5>
                    <p>Phí giao hàng: <strong>Miễn phí</strong></p>
                    <p id="voucherMessage" class="text-danger"></p>
                    <p class="total-price">Tổng tiền: <fmt:formatNumber type="number" value="${totalPrice}"/> VNĐ</p>
                    <p hidden class="total-price-value">Tổng tiền: <fmt:formatNumber type="number" value="${totalPrice}"/> VNĐ</p>
                </div>

                <div class="form-check mt-3">
                    <input class="form-check-input" type="radio" name="paymentMethod" value="bank">
                    <label class="form-check-label">Thanh toán online</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="paymentMethod" value="cod" checked>
                    <label class="form-check-label">Trả tiền trực tiếp</label>
                </div>
                <!-- <div class="apply-voucher mt-3">
                    <input type="text" id="voucherCode" class="form-control" placeholder="voucher Code">
                    <button type="button" id="applyvoucherBtn" class="btn btn-danger">Apply voucher</button>
                </div> -->
                <div class="apply-voucher mt-3">
                    <label for="voucherSelect" class="form-label">Chọn Voucher</label>
                    <div class="input-group">
                        <select id="voucherSelect" class="form-select">
                            <option value="">Chọn voucher...</option>
                            <c:forEach var="voucher" items="${vouchers}">
                                <option value="${voucher.id}">${voucher.name} - Giảm <fmt:formatNumber type="number" value="${voucher.discount}" pattern="#,##0"/> VNĐ</option>
                            </c:forEach>
                        </select>
                        <button type="button" id="applyvoucherBtn" class="btn btn-danger">Áp dụng</button>
                    </div>
                    <p id="voucherMessage" class="text-danger mt-2"></p>
                </div>
                <!-- <form action="/order/confirm" method="post">
                    <input type="hidden" name="totalPrice" value="${totalPrice}">
                    <button type="submit" class="btn btn-danger mt-3">Confirm Order</button>
                </form> -->
                <button id="confirmOrderBtn" class="btn btn-danger mt-3">Đặt hàng</button>
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

        $(document).ready(function () {
            $("#confirmOrderBtn").click(function () {
                // Lấy dữ liệu địa chỉ
                var street = $("#address").val().trim();
                var provinceText = $("#province option:selected").text().trim();
                var districtText = $("#district option:selected").text().trim();
                var wardText = $("#ward option:selected").text().trim();
                // var totalPriceText = $(".total-price").text().replace("Total: ", "").replace(" VNĐ", "").replace(/,/g, "").trim();
                var totalPriceText = $(".total-price-value").text().replace("Total: ", "").replace(" VNĐ", "").replace(/,/g, "").trim();
                var totalPrice = parseFloat(totalPriceText) || 0;

                // Kiểm tra dữ liệu hợp lệ
                if (!street || !provinceText || !districtText || !wardText || totalPrice <= 0) {
                    alert("Vui lòng nhập đầy đủ thông tin và kiểm tra tổng giá trị đơn hàng!");
                    return;
                }
        
                var fullAddress = street + ',' + wardText + ',' + districtText + ',' + provinceText;
        
                // Lấy phương thức thanh toán
                var paymentMethod = $("input[name='paymentMethod']:checked").val();
                console.log("Payment Method:", paymentMethod);
                if (!paymentMethod) {
                    alert("Vui lòng chọn phương thức thanh toán!");
                    return;
                }
        
                // Dữ liệu gửi đến server
                var orderData = {
                    address: fullAddress,
                    totalPrice: totalPrice,
                    paymentMethod: paymentMethod
                };
        
                // Gửi AJAX request
                $.ajax({
                    url: "/order/confirm",
                    method: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(orderData),
                    success: function (response) {
                        console.log("Response từ server:", response);  // Kiểm tra response
                    
                        if (response.success) {
                            if (paymentMethod === "bank") {
                                alert("Chuyển đến cổng thanh toán VNPAY...");
                                window.location.href = response.redirectUrl;
                            } else {
                                alert("Đơn hàng đã được xác nhận. Bạn sẽ thanh toán khi nhận hàng.");
                                window.location.href = "/order/success";
                            }
                        } else {
                            alert(response.message || "Đã xảy ra lỗi khi xử lý đơn hàng. Vui lòng thử lại.");
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Lỗi gửi đơn hàng:", error);
                        alert("Có lỗi xảy ra khi gửi đơn hàng. Vui lòng thử lại.");
                    }
                });
            });
        });
        

        $(document).ready(function () {
            $("#applyvoucherBtn").click(function () {
                let selectedVoucher = $("#voucherSelect").val(); // Lấy ID voucher
                let totalPriceText = $(".total-price-value").text().replace(/[^\d]/g, ""); 
                let totalPrice = parseFloat(totalPriceText);
        
                if (!selectedVoucher) {
                    $("#voucherMessage").text("Vui lòng chọn voucher!").removeClass("text-success").addClass("text-danger");
                    return;
                }
        
                $.ajax({
                    url: "/order/apply-voucher",
                    method: "POST",
                    //contentType: "application/json",
                    data: { 
                        voucherId: selectedVoucher,
                        totalPrice: totalPrice
                    },
                    success: function (response) {
                        if (response.success) {
                            $(".total-price").text("Total: " + response.newTotalPrice.toLocaleString("en-US") + " VNĐ");
                            $(".total-price-value").text("Total: " + response.newTotalPrice.toLocaleString("en-US") + " VNĐ");
                            $("#voucherMessage").text(response.message).removeClass("text-danger").addClass("text-success");
                            $("#applyvoucherBtn").prop("disabled", true);
                        } else {
                            $("#voucherMessage").text(response.message).removeClass("text-success").addClass("text-danger");
                        }
                    },
                    error: function (xhr) {
                        let errorMessage = xhr.responseJSON?.message || "Lỗi khi áp dụng voucher!";
                        $("#voucherMessage").text(errorMessage).removeClass("text-success").addClass("text-danger");
                    }
                });
            });
        });

    });
</script>
</body>
</html>