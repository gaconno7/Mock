<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <link rel="stylesheet" href="<c:url value="/css/login.css"/> ">
</head>
<body>



<div class="main-content">
    <div class="image-section">
        <img src="https://res.cloudinary.com/dxsbwkbnb/image/upload/v1741534290/banner/vqk8hmr5masuya5jygac.jpg" alt="Shopping cart with smartphone and shopping bags">
    </div>
    <form class="form-section" action="<c:url value="/login"/> " method="post">
        <h1 class="form-title">Đăng nhập</h1>
     <c:if test="${param.error != null}">
        <div class="error-message">
            <c:out value="${sessionScope.errorMessage}" default="Đã xảy ra lỗi trong quá trình đăng nhập" />
        </div>
    </c:if>

        <div class="form-control">
            <input name="username" type="email" placeholder="Email">
        </div>

        <div class="form-control">
            <input type="password" name="password" placeholder="Mật khẩu">
        </div>

        <button class="btn-primary" type="submit">Đăng nhập</button>

        <button class="btn-google">
            <img src="https://th.bing.com/th/id/OIP.8QehHn1i3PEPr3ivNJP2fAHaHa?rs=1&pid=ImgDetMain" alt="Google logo" style="width: 20px; height: 20px;">
            Đăng nhập với Google
        </button>
        <div class="d-flex justify-content-between">
            <a href="<c:url value="/register"/> " class="forgot-password">Đăng ký</a>
            <a href="#" class="forgot-password">Quên mật khẩu?</a>
        </div>
    </form>
</div>

</body>
</html>