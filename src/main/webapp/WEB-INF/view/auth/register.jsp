<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <link rel="stylesheet" href="<c:url value="/css/register.css"/> ">
</head>
<body>

<div class="main-content">
    <div class="image-section">
        <img src="/api/placeholder/300/300" alt="Shopping cart with smartphone and shopping bags">
    </div>
    <form class="form-section" method="post" action="<c:url value="/register"/> ">
        <h1 class="form-title">Đăng ký</h1>
        <p class="form-subtitle">Enter your details below</p>

        <div class="form-control">
            <input type="text" placeholder="Họ và tên" name="full-name" required>
        </div>

        <div class="form-control">
            <input type="email" placeholder="Email" name="email" required>
        </div>

        <div class="form-control">
            <input type="password" placeholder="Mật khẩu" name="password" required>
        </div>

        <div class="form-control">
            <input type="password" placeholder="Nhập lại mật khẩu" name="re-password" required>
        </div>

        <button class="btn-primary" type="submit">OK</button>

        <div class="login-link">
            Bạn đã có tài khoản? <a href="<c:url value="/login"/> ">Đăng nhập</a>
        </div>
    </form>
</div>

</body>
</html>