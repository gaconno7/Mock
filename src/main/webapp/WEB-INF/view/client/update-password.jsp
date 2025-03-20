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
    <link rel="stylesheet" href="<c:url value="/client/css/profile.css" />">
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
        <h3 class="form-label">Đổi mật khẩu</h3>
        <p id="error-message-inf" style="color: red; margin: 10px 0; text-align: center"></p>
        <p id="success-message-inf" style="color: green; margin: 10px 0; text-align: center"></p>

        <div class="form-section">
            <p id="error-message-pass" style="color: red; margin: 10px 0; text-align: center"></p>
            <p id="success-message-pass" style="color: green; margin: 10px 0; text-align: center"></p>
            <form id="update-password-form">
                <div class="form-group" style="margin-bottom: 15px;">
                    <label class="form-label" for="current-password">Mật khẩu hiện tại</label>
                    <input type="password" id="current-password" class="form-input" name="currentPassword" placeholder="..." autocomplete="current-password">
                </div>
                <div class="form-group" style="margin-bottom: 15px;">
                    <label class="form-label" for="new-password">Mật khẩu mới</label>
                    <input type="password" id="new-password" class="form-input" name="newPassword" placeholder="..." autocomplete="new-password">
                </div>
                <div class="form-group">
                    <label class="form-label" for="re-new-password">Nhập lại mật khẩu mới</label>
                    <input type="password" id="re-new-password" class="form-input" name="reNewPassword" placeholder="..." autocomplete="re-new-password">
                </div>
                <div class="btn-container">
                    <button type="button" id="btn-submit-password-form" class="btn btn-save">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Footer -->
<%@ include file="footer/footer.jsp" %>

<script>
    $(document).ready(function () {
        $("#btn-submit-password-form").click(function (e) {
            e.preventDefault();
            var formData = {
                currentPassword: $("#current-password").val(),
                newPassword: $("#new-password").val(),
                reNewPassword: $("#re-new-password").val()
            };
            console.log(JSON.stringify(formData))
            $.ajax({
                url: `${APIUser}/password/${userId}`,
                type: 'PUT',
                data: JSON.stringify(formData),
                contentType: 'application/json',
                success: function (response) {
                    if(response.includes("thành công")){
                        $("#success-message-pass").text(response);
                    } else {
                        $("#error-message-pass").text(response)
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            })

        });
    });

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
