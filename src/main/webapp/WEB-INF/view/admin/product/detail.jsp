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
                                        <h1 class="h3 mb-0 text-gray-800">Quản lí sản phẩm</h1>
                                        <a href="/admin/product/update/${product.id}"
                                            class="d-none d-sm-inline-block btn btn-sm btn-warning shadow-sm"><i
                                                class="fas fa-pencil-alt fa-sm text-white-50"></i> Cập nhật sản phẩm</a>
                                    </div>

                                    <!-- Message Content -->
                                    <jsp:include page="../layout/message.jsp" />
                                    <!-- End of Message Content -->

                                    <!-- DataTales Example -->
                                    <div class="card shadow mb-4">
                                        <div
                                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                            <h6 class="m-0 font-weight-bold text-primary">Thông tin sản phẩm
                                                <span class="text-danger">${product.name}</span>
                                            </h6>
                                            <a href="/admin/product" class="btn btn-primary">Trở về</a>
                                        </div>
                                        <div class="card-body">
                                            <div class="table-responsive">
                                                <table class="table table-bordered" id="dataTable" width="100%"
                                                    cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <th class="col-md-3">ID</th>
                                                            <td>${product.id}</td>
                                                        </tr>
                                                        <tr>
                                                            <th>Tên sản phẩm</th>
                                                            <td>${product.name}</td>
                                                        </tr>
                                                        <tr>
                                                            <th>Giá</th>
                                                            <td>
                                                                <fmt:formatNumber type="number"
                                                                    value="${product.price}" /> đ
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <th>Ảnh sản phẩm</th>
                                                            <td>
                                                                <c:if test="${empty product.image}">
                                                                    <span class="text-muted">(Chưa có)</span>
                                                                </c:if>
                                                                <c:if test="${not empty product.image}">
                                                                    <img style="max-height: 250px; display: block;"
                                                                        src="/images/product/${product.image}">
                                                                </c:if>
                                                            </td>
                                                        </tr>
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

                    <jsp:include page="../layout/foot.jsp" />

                </body>

                </html>