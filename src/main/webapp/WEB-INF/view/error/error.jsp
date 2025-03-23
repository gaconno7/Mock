<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/api/products" var="APIProduct"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa hàng</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/client/css/product-item.css"/> ">
    <link rel="stylesheet" href="<c:url value="/client/css/view-more.css"/> ">
    <style>
        .page-title {
            font-weight: bolder;
            font-size: 23vh;
            text-align: center !important;
        }
        .page-content {
            text-align: center;
            font-size: 5vh;
        }
    </style>
</head>
<body>

<!-- Header/Navigation -->
<%@ include file="header/header.jsp" %>

    <!-- Products Section -->
    <div class="page-title">
         404
    </div>
    <p class="page-content">Lỗi không tìm thấy trang!</p>
<%@ include file="footer/footer.jsp" %>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>