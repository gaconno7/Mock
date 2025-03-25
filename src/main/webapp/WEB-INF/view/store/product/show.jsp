<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
      integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="<c:url value="/store/css/base-layout.css"/>">
<jsp:include page="../layout/head.jsp">
    <jsp:param name="pageTitle" value="Quản lí sản phẩm" />
</jsp:include>


<body id="page-top">

<%@ include file="../header/header.jsp" %>
<!-- Page Wrapper -->
<div id="wrapper" class="mt-3">


    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">



            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800">Quản lý sản phẩm</h1>
                    <div class="d-flex">
                        <a href="/store/product/trash"
                           class="btn btn-sm btn-primary shadow-sm mx-2">
                            <i class="fas fa-trash fa-sm text-white-50"></i> Sản phẩm đã bị xoá
                        </a>
                        <a href="/store/product/create"
                           class="btn btn-sm btn-primary shadow-sm mx-2">
                            <i class="fas fa-plus-circle fa-sm text-white-50"></i> Thêm sản phẩm
                        </a>
                    </div>
                </div>

                <!-- Message Content -->
                <jsp:include page="../layout/message.jsp" />

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Danh sách sản phẩm</h6>
                    </div>
                    <div class="card-body">

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <c:choose>
                                    <c:when test="${not empty storeId}">

                                        <form action="/store/store/${storeId}/products" method="get"
                                              class="form-inline">
                                            <div class="form-group mr-2">
                                                <label for="categoryId" class="mr-2">Lọc theo danh
                                                    mục:</label>
                                                <select name="categoryId" id="categoryId"
                                                        class="form-control">
                                                    <option value="">-- Tất cả danh mục --</option>
                                                    <c:forEach var="cat" items="${categories}">
                                                        <option value="${cat.id}" ${cat.id eq
                                                                selectedCategoryId ? 'selected' : '' }>
                                                                ${cat.name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <button type="submit"
                                                    class="btn btn-primary">Lọc</button>
                                            <a href="/store/store/${storeId}/products"
                                               class="btn btn-secondary ml-2">Xóa bộ lọc</a>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="/store/product/filter" method="get"
                                              class="form-inline">
                                            <div class="form-group mr-2">
                                                <label for="categoryId" class="mr-2">Lọc theo danh
                                                    mục:</label>
                                                <select name="categoryId" id="categoryId"
                                                        class="form-control">
                                                    <option value="">-- Tất cả danh mục --</option>
                                                    <c:forEach var="cat" items="${categories}">
                                                        <option value="${cat.id}" ${cat.id eq
                                                                selectedCategoryId ? 'selected' : '' }>
                                                                ${cat.name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <button type="submit"
                                                    class="btn btn-primary">Lọc</button>
                                            <a href="/store/product"
                                               class="btn btn-secondary ml-2">Xóa bộ lọc</a>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                        </div>
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%"
                                   cellspacing="0">
                                <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Tên</th>
                                    <th>Giá</th>
                                    <th>Cửa hàng</th>
                                    <th>Loại sản phẩm</th>
                                    <th>Hành động</th>
                                </tr>
                                </thead>
                                <tbody id="productTableBody">
                                <c:forEach var="product" items="${products}" varStatus="status">
                                    <tr class="product-item">
                                        <th>${status.index + 1}</th>
                                        <td>${product.name}</td>
                                        <td>
                                            <fmt:formatNumber type="number"
                                                              value="${product.price}" />
                                            đ
                                        </td>
                                        <td>${product.store.name}</td>
                                        <td>${product.category.name}</td>
                                        <td>
                                            <a class="btn btn-success"
                                               href="/store/product/${product.id}">Xem thêm</a>
                                            <a class="btn btn-warning"
                                               href="/store/product/update/${product.id}">Cập
                                                nhật</a>
                                            <a class="btn btn-danger"
                                               onclick="deleteProduct(`${product.id}`)"
                                               data-entity-id="${product.id}"
                                               data-entity-name="${product.name}"> Xoá
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination Controls -->
                        <div class="row">
                            <div class="col-sm-12 col-md-5">
                                <div class="dataTables_info" id="paginationInfo" role="status"
                                     aria-live="polite">

                                </div>
                            </div>
                            <div class="col-sm-12 col-md-7">
                                <div class="dataTables_paginate paging_simple_numbers">
                                    <ul class="pagination" id="paginationContainer">
                                        <!-- Pagination buttons will be added here by JavaScript -->
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Page Size Selector -->
                        <div class="row">
                            <div class="col-sm-12 col-md-5">
                                <div class="dataTables_info" id="paginationInfo" role="status"
                                     aria-live="polite">

                                </div>
                            </div>
                            <div class="col-sm-12 col-md-7">
                                <div class="dataTables_paginate paging_simple_numbers">
                                    <ul class="pagination" id="paginationContainer">
                                        <!-- Pagination buttons will be added here by JavaScript -->
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <script>

                            function deleteProduct(id) {
                                let actionConfirm = confirm("Bạn có muốn xoá?")
                                if (actionConfirm) {
                                    window.location.href = '/store/product/delete/' + id;
                                }
                            }

                            document.addEventListener('DOMContentLoaded', function () {
                                // Pagination configuration
                                let currentPage = 0;
                                let pageSize = 10;
                                let productItems = document.querySelectorAll('.product-item');
                                let totalItems = productItems.length;

                                // Function to update the displayed items
                                function displayItems() {
                                    // Hide all items
                                    productItems.forEach(item => {
                                        item.style.display = 'none';
                                    });

                                    // Calculate start and end index
                                    let startIndex = currentPage * pageSize;
                                    let endIndex = Math.min(startIndex + pageSize, totalItems);

                                    // Show items for current page
                                    for (let i = startIndex; i < endIndex; i++) {
                                        if (productItems[i]) {
                                            productItems[i].style.display = '';

                                            // Update row numbers to be continuous across pages
                                            const rowNumberCell = productItems[i].querySelector('th');
                                            if (rowNumberCell) {
                                                rowNumberCell.textContent = i + 1;
                                            }
                                        }
                                    }

                                    // Update pagination info

                                    // Update pagination buttons
                                    updatePaginationButtons();
                                }

                                // Function to create pagination buttons
                                function updatePaginationButtons() {
                                    const paginationContainer = document.getElementById('paginationContainer');
                                    paginationContainer.innerHTML = '';

                                    const totalPages = Math.ceil(totalItems / pageSize);
                                    if (totalPages === 0) return;

                                    // First page button
                                    const firstBtn = createPaginationButton('Đầu', 0, currentPage === 0);
                                    paginationContainer.appendChild(firstBtn);

                                    // Previous button
                                    const prevBtn = createPaginationButton('Trước', currentPage - 1, currentPage === 0);
                                    paginationContainer.appendChild(prevBtn);

                                    // Page number buttons
                                    const startPage = Math.max(0, currentPage - 2);
                                    const endPage = Math.min(totalPages - 1, currentPage + 2);

                                    for (let i = startPage; i <= endPage; i++) {
                                        const pageBtn = createPaginationButton(i + 1, i, false, i === currentPage);
                                        paginationContainer.appendChild(pageBtn);
                                    }

                                    // Next button
                                    const nextBtn = createPaginationButton('Sau', currentPage + 1, currentPage === totalPages - 1);
                                    paginationContainer.appendChild(nextBtn);

                                    // Last page button
                                    const lastBtn = createPaginationButton('Cuối', totalPages - 1, currentPage === totalPages - 1);
                                    paginationContainer.appendChild(lastBtn);
                                }

                                // Helper function to create pagination buttons
                                function createPaginationButton(label, pageNum, isDisabled, isActive = false) {
                                    const li = document.createElement('li');
                                    li.className = `paginate_button page-item ${isDisabled ? 'disabled' : ''} ${isActive ? 'active' : ''}`;

                                    const a = document.createElement('a');
                                    a.href = 'javascript:void(0)';  // Prevent default behavior
                                    a.className = 'page-link';
                                    a.textContent = label;
                                    a.setAttribute('data-page', pageNum);

                                    if (!isDisabled) {
                                        a.onclick = function () {
                                            goToPage(pageNum);
                                        };
                                    }

                                    li.appendChild(a);
                                    return li;
                                }

                                // Function to navigate to a specific page
                                function goToPage(pageNum) {
                                    const totalPages = Math.ceil(totalItems / pageSize);
                                    if (pageNum >= 0 && pageNum < totalPages) {
                                        currentPage = pageNum;
                                        displayItems();
                                    }
                                }

                                // Add event listener for page size changes
                                const pageSizeSelector = document.getElementById('pageSizeSelector');
                                if (pageSizeSelector) {
                                    pageSizeSelector.addEventListener('change', function () {
                                        pageSize = parseInt(this.value);
                                        currentPage = 0; // Reset to first page
                                        displayItems();
                                    });
                                }

                                // Initialize pagination
                                displayItems();
                            });
                        </script>
                    </div>
                </div>

            </div>
            <!-- /.container-fluid -->


        </div>
        <!-- End of Main Content -->

        <!-- Footer -->
        <jsp:include page="../layout/footer.jsp" />
        <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Modal Content -->
<%--<!-- <jsp:include page="../layout/deleteModal.jsp">--%>
<%--                        <jsp:param name="entity" value="sản phẩm" />--%>
<%--                        <jsp:param name="actionSubfolder" value="product" />--%>
<%--                        <jsp:param name="modalAttribute" value="deleteProduct" />--%>
<%--                    </jsp:include> -->--%>

<jsp:include page="../layout/foot.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>

</html>