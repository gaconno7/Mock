<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/api/users" var="APIUser"/>
<c:set var="userId" value="${sessionScope.user.id}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/client/css/update-address.css" />">
</head>
<body>

<!-- Header -->
<%@ include file="header/header.jsp" %>

<!-- Account management -->
<div class="account-container pt-5">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-section">
            <div class="sidebar-title">Quản lý tài khoản</div>
            <div class="sidebar-links">
                <a href="<c:url value="/user/update-address"/>" class="sidebar-link">Cập nhật địa chỉ</a>
                <a href="<c:url value="/user/update-password"/>" class="sidebar-link">Cập nhật mật khẩu</a>
                <a href="<c:url value="/user/profile"/> " class="sidebar-link">Cập nhật thông tin</a>
            </div>
            <div class="sidebar-title mt-3">Đơn hàng của tôi</div>
            <div class="sidebar-links">
                <a href="<c:url value="/user/order/history"/> " class="sidebar-link">Tất cả</a>
                <a href="<c:url value="/user/order/history/cho-xu-ly"/>" class="sidebar-link">Chờ xử lý</a>
                <a href="<c:url value="/user/order/history/van-chuyen"/> " class="sidebar-link">Vận chuyển</a>
                <a href="<c:url value="/user/order/history/cho-giao-hang"/> " class="sidebar-link">Chờ giao hàng</a>
                <a href="<c:url value="/user/order/history/hoan-thanh"/> " class="sidebar-link">Hoàn thành</a>
                <a href="<c:url value="/user/order/history/chua-thanh-toan"/> " class="sidebar-link">Chưa thanh toán</a>
                <a href="<c:url value="/user/order/history/da-thanh-toan"/> " class="sidebar-link">Đã thanh toán</a>
                <a href="<c:url value="/user/order/history/da-huy"/> " class="sidebar-link">Đã huỷ</a>
                <a href="<c:url value="/user/order/history/tra-hang"/> " class="sidebar-link">Trả hàng/ hoàn tiền</a>
            </div>
        </div>

    </div>

    <!-- Profile form -->
    <div class="profile-form">
        <h3 class="form-label">Cập nhật đi chỉ</h3>
        <p id="error-message-inf" style="color: red; margin: 10px 0; text-align: center">${messageError}</p>
        <p id="success-message-inf" style="color: green; margin: 10px 0; text-align: center">${messageSuccess}</p>

        <div class="form-section">
            <form id="update-information-form" method="post" action="<c:url value="/user/update-address"/> " >
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="province-select">Tỉnh/thành phố</label>
                        <select id="province-select" onchange="loadDistricts()">
                            <option value="">Chọn tỉnh/thành phố</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="district-select">Quận/ huyện</label>
                        <select id="district-select" onchange="loadWards()" disabled>
                            <option value="">Chọn quận/huyện</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="ward-select">Phường xã</label>
                        <select id="ward-select" disabled>
                            <option value="">Chọn phường/xã</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="street">Số nhà - đường/ Thôn - xóm</label>
                        <input type="text" id="street" name="street" class="form-input" >
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="old-address"> Địa chỉ hiện tại</label>
                        <input type="text" id="old-address"  class="form-input" value="${sessionScope.user.address}" disabled >
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <input type="hidden" id="province" name="province" class="form-input" >
                        <input type="hidden" id="district" name="district" class="form-input" >
                        <input type="hidden" id="ward" name="ward" class="form-input" >
                    </div>
                </div>

                <div class="btn-container">
                    <button type="submit" id="btn-submit-information-form" class="btn btn-save">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Footer -->
<%@ include file="footer/footer.jsp" %>

<script>
    $(document).ready(function () {
        loadProvinces();
        $("#province-select").change(loadDistricts);
        $("#district-select").change(loadWards);
    });

    function loadProvinces() {
        $.getJSON("https://vn-public-apis.fpo.vn/provinces/getAll?limit=-1", function (data) {
            let provinces = data.data.data;
            let $provinceSelect = $("#province-select");

            $.each(provinces, function (index, province) {
                $provinceSelect.append('<option value="' + province.code + '">' + province.name + '</option>');
            });
        });
    }

    function loadDistricts() {
        let provinceCode = $("#province-select").val();
        let provinceName = $("#province-select option:selected").text(); // Lấy tên tỉnh

        let $districtSelect = $("#district-select");
        let $wardSelect = $("#ward-select");

        $districtSelect.html('<option value="">Chọn quận/huyện</option>').prop("disabled", true);
        $wardSelect.html('<option value="">Chọn phường/xã</option>').prop("disabled", true);

        $("#province").val(provinceName); // Cập nhật input ẩn

        if (!provinceCode) return;

        $.getJSON('https://vn-public-apis.fpo.vn/districts/getByProvince?provinceCode=' + provinceCode + '&limit=-1', function (data) {
            let districts = data.data.data;
            $.each(districts, function (index, district) {
                $districtSelect.append('<option value="' + district.code + '">' + district.name + '</option>');
            });

            $districtSelect.prop("disabled", false);
        });
    }

    function loadWards() {
        let districtCode = $("#district-select").val();
        let districtName = $("#district-select option:selected").text();

        let $wardSelect = $("#ward-select");

        $wardSelect.html('<option value="">Chọn phường/xã</option>').prop("disabled", true);

        $("#district").val(districtName); // Cập nhật input ẩn

        if (!districtCode) return;

        $.getJSON('https://vn-public-apis.fpo.vn/wards/getByDistrict?districtCode=' + districtCode + '&limit=-1', function (data) {
            let wards = data.data.data;
            $.each(wards, function (index, ward) {
                $wardSelect.append('<option value="' + ward.code + '">' + ward.name + '</option>');
            });

            $wardSelect.prop("disabled", false);
        });
    }

    $("#ward-select").change(function () {
        let wardName = $("#ward-select option:selected").text();
        $("#ward").val(wardName);
    });

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
