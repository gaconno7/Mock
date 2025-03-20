<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hoá đơn</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/client/css/order-history.css" />">

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
                <a href="<c:url value="/user/profile"/> " class="sidebar-link">Cập nhật thông tin</a>
            </div>
            <div class="sidebar-title mt-3">Đơn hàng của tôi</div>
            <div class="sidebar-links">
                <a href="<c:url value="/user/order/history"/> " class="sidebar-link">Tất cả</a>
                <a href="<c:url value="/user/order/history/cho-xu-ly"/>" class="sidebar-link">Chờ xử lý</a>
                <a href="<c:url value="/user/order/history/van-chuyen"/> " class="sidebar-link">Vận chuyển</a>
                <a href="<c:url value="/user/order/history/cho-giao-hang"/> " class="sidebar-link">Chờ giao hàng</a>
                <a href="<c:url value="/user/order/history/hoan-thanh"/> " class="sidebar-link">Hoàn thành</a>
                <a href="<c:url value="/user/order/history/da-huy"/> " class="sidebar-link">Đã huỷ</a>
                <a href="<c:url value="/user/order/history/tra-hang"/> " class="sidebar-link">Trả hàng/ hoàn tiền</a>
            </div>
        </div>

    </div>

    <!-- Returns content -->
    <div class="returns-content">
        <h2 class="content-title">Đơn hàng của tôi</h2>

        <table class="returns-table">
            <thead>
            <tr>
                <th>Mã đơn hàng</th>
                <th>Ngày đặt</th>
                <th>Trạng thái</th>
                <th>&nbsp;</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${orders}">
                <tr>
                    <td class="return-id">${item.id}</td>
                    <td>${item.orderDate.toString().substring(0,19)}</td>
                    <td><span class="return-status status-approved">${item.status}</span></td>
                    <td><a href="<c:url value="/user/order/${item.id}"/> " class="action-btn">Xem chi tiết</a></td>
                </tr>
            </c:forEach>

            </tbody>
        </table>

    </div>
</div>


<!-- Footer -->
<%@ include file="footer/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
