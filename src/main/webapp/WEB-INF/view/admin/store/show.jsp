<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <jsp:include page="../layout/head.jsp">
                    <jsp:param name="pageTitle" value="Quản lí cửa hàng" />
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
                                        <h1 class="h3 mb-0 text-gray-800">Quản lí cửa hàng</h1>
                                        <a href="/admin/store/create"
                                            class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                                                class="fas fa-plus-circle fa-sm text-white-50"></i> Thêm cửa hàng</a>

                                    </div>

                                    <!-- Message Content -->
                                    <jsp:include page="../layout/message.jsp" />
                                    <!-- End of Message Content -->

                                    <!-- DataTales Example -->
                                    <div class="card shadow mb-4">
                                        <div class="card-header py-3">
                                            <h6 class="m-0 font-weight-bold text-primary">Danh sách cửa hàng</h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="table-responsive">
                                                <table class="table table-bordered" id="dataTable" width="100%"
                                                    cellspacing="0">
                                                    <thead>
                                                        <tr>
                                                            <th>STT</th>
                                                            <th>Tên</th>
                                                            <th>Mô tả</th>
                                                            <th>Hành động</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="store" items="${store}" varStatus="status">
                                                            <tr>
                                                                <th>${status.index + 1}</th>
                                                                <td>${store.name}</td>
                                                                <td>${store.description}</td>
                                                                <td>
                                                                    <a class="btn btn-success"
                                                                        href="/admin/store/${store.id}/products">Xem
                                                                        thêm</a>
                                                                    <a class="btn btn-warning"
                                                                        href="/admin/store/update/${store.id}">Cập
                                                                        nhật</a>
                                                                    <a class="btn btn-danger" href="#"
                                                                        data-toggle="modal" data-target="#deleteModal"
                                                                        data-entity-id="${store.id}"
                                                                        data-entity-name="${store.name}"> Xoá
                                                                    </a>
                                                                </td>

                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>

                                                <!-- Pagination -->

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
                        <jsp:param name="actionSubfolder" value="store" />
                        <jsp:param name="modalAttribute" value="deleteStore" />
                    </jsp:include>

                    <jsp:include page="../layout/foot.jsp" />

                </body>

                </html>