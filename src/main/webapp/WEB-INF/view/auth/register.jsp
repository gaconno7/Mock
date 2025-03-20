<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <link rel="stylesheet" href="<c:url value="/client/css/register.css"/> ">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>

<div class="main-content">
    <div class="image-section">
        <img src="https://res.cloudinary.com/dxsbwkbnb/image/upload/v1741534290/banner/vqk8hmr5masuya5jygac.jpg" alt="Shopping cart with smartphone and shopping bags">
    </div>
    <form class="form-section" method="post" action="<c:url value="/register"/> ">
        <h1 class="form-title">Đăng ký</h1>
        <c:if test="${not empty errorMessage}">
            <p class="text-error">${errorMessage}</p>
        </c:if>
        <p class="text-error" id="text-error"></p>
        <div class="form-control">
            <input type="text" placeholder="Họ và tên" name="full-name" required>
        </div>

        <div class="form-control">
            <input type="email" placeholder="Email" name="email" required>
        </div>

        <div class="form-control">
            <input type="password" id="password" placeholder="Mật khẩu" name="password" required>
        </div>

        <div class="form-control">
            <input type="password" id="re-password" placeholder="Nhập lại mật khẩu" name="re-password" required>
        </div>

        <button class="btn-primary" id="btn-submit-password" type="submit">OK</button>

        <div class="login-link">
                    Bạn đã có tài khoản? <a href="<c:url value="/login"/> ">Đăng nhập</a> - <a href="<c:url value="/"/>" class="forgot-password">Trang chủ</a>
        </div>

    </form>

    <script>
        $(document).ready(function() {
            function checkPassword() {
                let password = $('#password').val();
                let rePassword = $('#re-password').val();

                if (password.length < 6) {
                    $('#text-error').text("Mật khẩu phải lớn hơn hoặc bằng 6 ký tự!");
                    return false;
                } else if (password !== rePassword) {
                    $('#text-error').text("Mật khẩu và mật khẩu nhập lại không trùng khớp!");
                    return false;
                } else {
                    $('#text-error').text(""); // Xóa thông báo lỗi nếu hợp lệ
                    return true;
                }
            }

            $(".form-section").submit(function(event) {
                if (!checkPassword()) {
                    event.preventDefault();
                }
            });

            $("#password, #re-password").on("input", function() {
                checkPassword();
            });
        });

    </script>
</div>

</body>
</html>