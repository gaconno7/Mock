<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <jsp:include page="../layout/head.jsp">
                <jsp:param name="pageTitle" value="Quản lí người dùng" />
            </jsp:include>

            <body id="page-top">

                <!-- Page Wrapper -->
                <div id="wrapper">

                    <!-- Sidebar -->
                    <jsp:include page="../layout/sidebar.jsp" />
                    <!-- End of Sidebar -->

                    <!-- Content Wrapper -->
                    <div id="content-wrapper" class="d-flex flex-column">

                        <!-- Main Content -->
                        <div id="content">

                            <!-- Topbar -->
                            <jsp:include page="../layout/topbar.jsp" />
                            <!-- End of Topbar -->

                            <!-- Begin Page Content -->
                            <div class="container-fluid">

                                <!-- Page Heading -->
                                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                                    <h1 class="h3 mb-0 text-gray-800">Quản lý tài khoản</h1>
                                    <div class="d-flex">
                                        <a href="/admin/user" class="btn btn-sm btn-primary shadow-sm mx-2">
                                            <i class="fas fa-arrow-left fa-sm text-white-50"></i> Trở về
                                        </a>
                                        <a href="/admin/user/create/${users[0].role.name}"
                                            class="btn btn-sm btn-primary shadow-sm mx-2">
                                            <i class="fas fa-plus-circle fa-sm text-white-50"></i> Thêm tài khoản
                                        </a>
                                    </div>
                                </div>





                                <!-- Message Content -->
                                <jsp:include page="../layout/message.jsp" />
                                <!-- End of Message Content -->

                                <!-- DataTales Example -->
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Danh sách tài khoản</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="dataTable" width="100%"
                                                cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>STT</th>
                                                        <th>Họ và tên</th>
                                                        <th>Email</th>
                                                        <th>Vai trò</th>
                                                        <th>ID</th>
                                                        <th>Hành động</th>
                                                        <!-- <th>Loại</th> -->

                                                    </tr>
                                                </thead>
                                                <tbody id="productTableBody">
                                                    <c:forEach var="user" items="${users}" varStatus="status">
                                                        <tr class="product-item">
                                                            <td>${status.index + 1}</td>
                                                            <td>${user.fullname}</td>
                                                            <td>${user.email}</td>
                                                            <td><strong>${user.role.name}</strong></td>
                                                            <td>${user.id}</td>
                                                            <td>
                                                                <a class="btn btn-success"
                                                                    href="/admin/user/${user.id}">Chi tiết</a>
                                                                <a class="btn btn-warning"
                                                                    href="/admin/user/update/${user.id}">Cập nhật</a>

                                                                <c:if
                                                                    test="${not empty user.store && user.store.deleted == false}">
                                                                    <a class="btn btn-success"
                                                                        href="/admin/store/${user.store.id}/products">Cửa
                                                                        hàng</a>
                                                                </c:if>
                                                                <c:if test="${empty user.store}">
                                                                    <a class="btn btn-success"
                                                                        href="/admin/user/${user.id}/store/create">Thêm
                                                                        Cửa hàng</a>
                                                                </c:if>
                                                                <c:if test="${user.store.deleted == true}">
                                                                    <a class="btn btn-success"
                                                                        href="/admin/store/restore/${user.store.id}">Khôi
                                                                        phục
                                                                        Cửa hàng</a>
                                                                </c:if>


                                                                <c:if test="${sessionScope.user.id != user.id}">
                                                                    <a class="btn btn-danger" href="#"
                                                                        data-toggle="modal" data-target="#deleteModal"
                                                                        data-entity-id="${user.id}"
                                                                        data-entity-name="${user.fullname}">
                                                                        Khoá tài khoản
                                                                    </a>
                                                                </c:if>
                                                            </td>


                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>

                                            <!-- Pagination -->

                                        </div>
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

                <!-- Modal Content -->
                <jsp:include page="../layout/deleteModal.jsp">
                    <jsp:param name="entity" value="người dùng" />
                    <jsp:param name="actionSubfolder" value="user" />
                    <jsp:param name="modalAttribute" value="deleteUser" />
                </jsp:include>

                <!-- End of Page Wrapper -->

                <jsp:include page="../layout/foot.jsp" />

            </body>

            </html>