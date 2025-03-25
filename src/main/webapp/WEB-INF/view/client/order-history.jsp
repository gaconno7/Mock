<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hoá đơn</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
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
        <div class="sidebar-section"><div class="sidebar-title">Quản lý tài khoản</div>
            <div class="sidebar-links">
                <a href="<c:url value="/user/update-address"/>" class="sidebar-link">Cập nhật địa chỉ</a>
                <a href="<c:url value="/user/update-password"/>" class="sidebar-link">Cập nhật mật khẩu</a>
                <a href="<c:url value="/user/profile"/> " class="sidebar-link">Cập nhật thông tin</a>
            </div>
            <div class="sidebar-title mt-3">Quản lý đơn hàng</div>
            <div class="sidebar-links">
                <a onclick="clearAll() "  class="sidebar-link pointer-action tat-ca">Tất cả</a>
                <a onclick="setStatus('cho-xu-ly')" class="sidebar-link pointer-action cho-xu-ly">Chờ xử lý</a>
                <a onclick="setStatus('van-chuyen')" class="sidebar-link pointer-action van-chuyen">Vận chuyển</a>
                <a onclick="setStatus('cho-giao-hang')" class="sidebar-link pointer-action cho-giao-hang">Chờ giao hàng</a>
                <a onclick="setStatus('hoan-thanh')"  class="sidebar-link pointer-action hoan-thanh">Hoàn thành</a>
                <a onclick="setStatus('da-thanh-toan')"  class="sidebar-link pointer-action da-thanh-toan">Đã thanh toán</a>
                <a onclick="setStatus('da-huy')" class="sidebar-link pointer-action da-huy">Đã huỷ</a>
                <a onclick="setStatus('tra-hang')" class="sidebar-link pointer-action tra-hang">Trả hàng/ hoàn tiền</a>
            </div>
        </div>

    </div>

    <!-- Returns content -->
    <div class="returns-content">
        <div class="order-header">
            <h2 class="content-title">Danh sách đơn hàng</h2>
            <form class="order-search-form mb-2">
                <input id="search-value" type="text" name="search" placeholder="Nhập từ khóa tìm kiếm...">

                <select onchange="setSearchType(this.value)" id="select-filter">
                    <option value="">Lọc</option>
                    <option value="address">Địa chỉ</option>
                    <option value="fullname">Tên khách hàng</option>
                    <option value="id">Mã hoá đơn</option>
                </select>

                <input id="search-date" type="date" name="orderDate">
                <button type="button" onclick="setSearchValue()">Tìm kiếm</button>
                <button type="button" onclick="clearAll()">Làm sạch</button>
            </form>
        </div>


        <table class="returns-table">
            <thead>
            <tr>
                <th>Mã đơn hàng</th>
                <th>Ngày đặt</th>
                <th>Trạng thái</th>
                <th>&nbsp;</th>
            </tr>
            </thead>
            <tbody id="order-list">

            </tbody>
        </table>

        <div id="pagination" class="pagination-page">
        </div>
    </div>
</div>
<script>
    let date = null, status = null,  searchValue = null,
        searchType = null, userId = '${sessionScope.user.id}';

    function setSearchType(value) {
        searchType = value;
    }


    function clearAll() {
        date = null;
        status = null;
        searchType = null;
        searchValue = null;
        $("#search-date").val('');
        $("#search-value").val(null);
        $("#select-filter").val('');
        $(".pointer-action").removeClass('active');
        $(".tat-ca").addClass(' active')
        loadOrders(0);
    }

    function setStatus(value) {
        status = value;
        $(".pointer-action").removeClass('active');
        $("." + (status === '' ? "tat-ca" : value)).addClass(' active')
        console.log(value === '')
        loadOrders(0);
    }

    function getAll() {
        removeAllValue();
        loadOrders(0);
    }

    function setSearchValue() {
        let searchValueForm = $('#search-value').val();
        searchValue = searchValueForm !== '' ? searchValueForm : null;
        let inputDate = $('#search-date').val();
        if(inputDate !== '') {
            let [year, month, day] = inputDate.split('-');
            let formattedDate = year + '-' + day + '-' + month;
            date = formattedDate !== '' ? formattedDate : null;
        }
        loadOrders(0);
    }

    function processOrder(id) {
        $.ajax({
            url: '/api/orders/process/' + id,
            type: 'PUT',
            dataType: 'json',
            success: function (response) {
                console.log(response);
                loadOrders(0);
            },
            error: function (error) {
                console.log(error)
            }
        })
    }

    function loadOrders(page) {
        let data = { page: page };
        if(searchType !== null) data.searchType = searchType;
        if(searchValue !== null) data.searchValue = searchValue;
        if(userId !== null) data.userId = userId;
        if(status !== null) data.status = status;
        if(date !== null) data.date = date;


        console.log(data)
        $.ajax({
            url: '/api/orders/all',
            type: 'GET',
            data: data,
            dataType: 'json',
            success: function(data) {
                let container = $('#order-list');
                container.empty();
                if(data.content && data.content.length > 0) {

                    $.each(data.content, function(index, item) {
                        let productHtml =
                            '<tr> '
                            + '<td class="return-id">' + item.id + '</td> '
                            + '<td> ' + (new Date(item.orderDate)).toLocaleString() + '</td> '
                            + '<td><span class="return-status status-approved">'
                            + (item.status === 'cho-giao-hang' ? 'Chờ giao hàng' :
                                item.status === 'cho-xu-ly' ? 'Chờ xử lý' :
                                    item.status === 'da-huy' ? 'Đã huỷ' :
                                        item.status === 'tra-hang' ? 'Trả hàng' :
                                            item.status === 'hoan-thanh' ? 'Hoàn thành' :
                                                item.status === 'van-chuyen' ? 'Vận chuyển' :
                                                    item.status === 'da-thanh-toan' ? 'Đã thanh toán' :
                                                        item.status === 'chua-thanh-toan' ? 'Chưa thanh toán' : '')
                            + '</span></td> '
                            + '<td><a href="/user/order/' + item.id + '" class="action-btn mr-3">Xem chi tiết</a> '
                            + (item.status === "hoan-thanh" ? '<a href="/user/order/return-order/' + item.id + '"  class="action-btn">Hoàn hàng</a>' : '')
                            + '</td> '
                            + '</tr>';

                        container.append(productHtml);
                    });
                } else {
                    container.html('<p  class="text-center"> Không có hoá đơn nào. </p>');
                }

                createPagination(data);
            },
            error: function(xhr, status, error) {
                console.error("Có lỗi khi tải: " + error);
            }
        });
    }


    function createPagination(data) {
        let paginationDiv = $('#pagination');
        paginationDiv.empty();

        let totalPages = data.totalPages;
        let currentPage = data.number;

        // Nút "Trước"
        if (currentPage > 0) {
            paginationDiv.append(
                '<a href="#" data-page="' + (currentPage - 1) + '">&laquo;</a>'
            );
        }

        // Hiển thị các trang phân trang
        for (let i = 0; i < totalPages; i++) {
            let activeClass = (i === currentPage) ? 'active' : '';
            paginationDiv.append(
                '<a href="#" class="' + activeClass + '" data-page="' + i + '">' + (i + 1) + '</a>'
            );
        }

        // Nút "Tiếp theo"
        if (currentPage < totalPages - 1) {
            paginationDiv.append(
                '<a href="#" data-page="' + (currentPage + 1) + '">&raquo;</a>'
            );
        }
    }

    $(document).on('click', '#pagination a', function(e) {
        e.preventDefault();
        let page = $(this).data('page');
        loadOrders(page);
    });
    $(document).ready(function() {

        loadOrders(0);
    });

</script>

<!-- Footer -->
<%@ include file="footer/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>

</body>
</html>
