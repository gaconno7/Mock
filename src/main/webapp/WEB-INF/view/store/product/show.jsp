<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <jsp:include page="../layout/head.jsp">
                    <jsp:param name="pageTitle" value="Quản lí sản phẩm" />
                </jsp:include>

                <body id="page-top">

                    <!-- Page Wrapper -->
                    <div id="wrapper">

                        <!-- Sidebar -->

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
                                        <h1 class="h3 mb-0 text-gray-800">Quản lí sản phẩm</h1>
                                        <a href="/store/product/create"
                                            class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                                                class="fas fa-plus-circle fa-sm text-white-50"></i> Thêm sản phẩm</a>

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
                                                    <tbody>
                                                        <c:forEach var="product" items="${products}" varStatus="status">
                                                            <tr>
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
                                                                    <a class="btn btn-danger" href="#"
                                                                        data-toggle="modal" data-target="#deleteModal"
                                                                        data-entity-id="${product.id}"
                                                                        data-entity-name="${product.name}"> Xoá
                                                                    </a>
                                                                </td>

                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>


                                            </div>
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
                    <jsp:include page="../layout/deleteModal.jsp">
                        <jsp:param name="entity" value="sản phẩm" />
                        <jsp:param name="actionSubfolder" value="product" />
                        <jsp:param name="modalAttribute" value="deleteProduct" />
                    </jsp:include>

                    <jsp:include page="../layout/foot.jsp" />

                </body>

                </html>