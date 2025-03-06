<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <jsp:include page="../layout/head.jsp">
                <jsp:param name="pageTitle" value="Thông tin người dùng" />
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
                                    <h1 class="h3 mb-0 text-gray-800">Thông tin người dùng</h1>
                                    <a href="/admin/user/update/${detailUser.id}"
                                        class="d-none d-sm-inline-block btn btn-sm btn-warning shadow-sm"><i
                                            class="fas fa-pencil-alt fa-sm text-white-50"></i> Cập nhật thông
                                        tin</a>
                                </div>

                                <!-- Message Content -->
                                <jsp:include page="../layout/message.jsp" />
                                <!-- End of Message Content -->

                                <!-- DataTales Example -->
                                <div class="card shadow mb-4">
                                    <div
                                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Thông tin tài khoản
                                            <span class="text-danger">${detailUser.fullname}</span>
                                        </h6>
                                        <a href="/admin/user" class="btn btn-primary">Trở về</a>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="dataTable" width="100%"
                                                cellspacing="0">
                                                <tbody>
                                                    <tr>
                                                        <th>ID</th>
                                                        <td>${detailUser.id}</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Email</th>
                                                        <td>${detailUser.email}</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Số điện thoại</th>
                                                        <td>
                                                            <c:if test="${empty detailUser.phone}">
                                                                <span class="text-muted">(Chưa có)</span>
                                                            </c:if>
                                                            ${detailUser.phone}
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Họ và tên</th>
                                                        <td>${detailUser.fullname}</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Địa chỉ</th>
                                                        <td>
                                                            <c:if test="${empty detailUser.address}">
                                                                <span class="text-muted">(Chưa có)</span>
                                                            </c:if>
                                                            ${detailUser.address}
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Vai trò</th>
                                                        <td>${detailUser.role.name}</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Ảnh đại diện</th>
                                                        <td>
                                                            <c:if test="${empty detailUser.avatar}">
                                                                <span class="text-muted">(Chưa có)</span>
                                                            </c:if>
                                                            <c:if test="${not empty detailUser.avatar}">
                                                                <img style="max-height: 250px; display: block;"
                                                                    src="/admin/images/avatar/${detailUser.avatar}">
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