<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <link rel="stylesheet" href="<c:url value="/client/css/login.css"/> ">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style>
        .message-error {
            color: red;
            text-align: center;
        }
        .message-success {
            color: blue;
            text-align: center;
        }
    </style>
</head>
<body>



<div class="main-content">
    <div class="image-section">
        <img src="https://res.cloudinary.com/dxsbwkbnb/image/upload/v1741534290/banner/vqk8hmr5masuya5jygac.jpg" alt="Shopping cart with smartphone and shopping bags">
    </div>
    <form class="form-section" action="<c:url value="/reset-password"/>" method="post">
        <h1 class="form-title">Đổi mật khẩu</h1>
        <div class="${not empty message && message.contains('thành công') ? 'message-success' : 'message-error'}" id="message-alert">
            ${message}
        </div>

        <div class="form-control">
            <input type="hidden" id="otp" name="otp">
        </div>

        <div class="form-control">
            <input type="password" id="password" name="password" placeholder="Mật khẩu mới" required>
        </div>
        <div class="form-control">
            <input type="password" id="re-password" name="re-password" placeholder="Nhập lại mật khẩu" required>
        </div>

        <button class="btn-primary" id="btn-submit-password" type="submit">OK</button>

    </form>

</div>
<script>
    $(document).ready(function() {
        function checkPassword() {
            let password = $("#password").val();
            let rePassword = $("#re-password").val();
            if (rePassword !== null || password !== null) {
                if (rePassword.length < 6 || password.length < 6) {
                    $("#message-alert").removeClass('message-success').text("Mật khẩu và mật khẩu nhập lại phải có độ dài lớn hơn 6");
                    return false;
                } else if (password !== rePassword) {
                    $("#message-alert").removeClass('message-success').text("Mật khẩu và mật khẩu nhập lại không trùng khớp!");
                    return false;

                } else {
                    $(".message-alert").text("");
                    return true;
                }
            }
        }

        $("#btn-submit-password").click(function(event) {
            if (!checkPassword()) {
                event.preventDefault();
            }
        });
        const url = window.location.href;
        const start = url.lastIndexOf('/')+1;
        const end = url.length;
        $('#otp').val(url.substring(start,end));
    });

</script>
</body>
</html>