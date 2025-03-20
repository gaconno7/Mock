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
                                        <h1 class="h3 mb-0 text-gray-800">Quản lí đơn hàng</h1>

                                    </div>

                                    <!-- Message Content -->
                                    <jsp:include page="../layout/message.jsp" />

                                    <div class="card shadow mb-4">
                                        <div class="card-header py-3">
                                            <h6 class="m-0 font-weight-bold text-primary">Danh sách đơn hàng</h6>
                                        </div>
                                        <div class="card-body">

                                            <div class="row mb-4">
                                            </div>
                                            <div class="table-responsive">
                                                <table class="table table-bordered" id="dataTable" width="100%"
                                                    cellspacing="0">
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Người đặt hàng</th>
                                                            <th>Địa chỉ</th>
                                                            <th>Ngày đặt hàng</th>
                                                            <th>Giá</th>
                                                            <th>Trạng thái</th>
                                                            <th>Hành động</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="order" items="${order}" varStatus="status">
                                                            <tr>
                                                                <th>${status.index + 1}</th>
                                                                <td>${order.user.fullname}</td>
                                                                <td>${order.address}</td>
                                                                <td>${order.orderDate}</td>
                                                                <td>
                                                                    <fmt:formatNumber type="number"
                                                                        value="${order.totalPrice}" />
                                                                    đ
                                                                </td>
                                                                <td>${order.status}</td>
                                                                <td>
                                                                    <a class="btn btn-success"
                                                                        href="/admin/order/${order.id}">Xem thêm</a>
                                                                    <a class="btn btn-danger" href="#"
                                                                        data-toggle="modal" data-target="#deleteModal"
                                                                        data-entity-id="${order.id}"
                                                                        data-entity-name="${order.id}"> Xoá
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
                        <jsp:param name="entity" value="đơn hàng" />
                        <jsp:param name="actionSubfolder" value="order" />
                        <jsp:param name="modalAttribute" value="deleteOrder" />
                    </jsp:include>

                    <jsp:include page="../layout/foot.jsp" />

                </body>

                </html>