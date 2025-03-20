<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <link rel="stylesheet" href="<c:url value="/client/css/login.css"/> ">
</head>
<body>



<div class="main-content">
    <div class="image-section">
        <img src="https://res.cloudinary.com/dxsbwkbnb/image/upload/v1741534290/banner/vqk8hmr5masuya5jygac.jpg" alt="Shopping cart with smartphone and shopping bags">
    </div>
    <form class="form-section" action="<c:url value="/confirm-email"/> " method="post">
        <h1 class="form-title">Vui lòng nhập email đã đăng ký</h1>
        <c:if test="${not empty message}" >
                <p style="text-align: center; ${message.contains('không chính xác') || message.contains('hết hạn') ? 'color: red' : 'color: blue'} ">${message}</p>
        </c:if>

        <div class="form-control">
            <input name="email" type="email" placeholder="Email">
        </div>
        <button class="btn-primary" type="submit">OK</button>

    </form>
</div>

</body>
</html>