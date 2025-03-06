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
                                    <h1 class="h3 mb-0 text-gray-800">Quản lí tài khoản</h1>
                                    <div class="d-flex">
                                        <a href="/admin/user" class="btn btn-sm btn-primary shadow-sm mx-2">
                                            <i class="fas fa-arrow-left fa-sm text-white-50"></i> Trở về
                                        </a>
                                        <a href="/admin/user/create" class="btn btn-sm btn-primary shadow-sm mx-2">
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
                                            <table class="table table-bordered" id="" width="100%" cellspacing="0">
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
                                                <tbody>
                                                    <c:forEach var="user" items="${users}" varStatus="status">
                                                        <tr>
                                                            <td>${status.index + 1}</td>
                                                            <td>${user.fullname}</td>
                                                            <td>${user.email}</td>
                                                            <td><strong>${user.role.name}</strong></td>
                                                            <td>${user.id}</td>
                                                            <td>
                                                                <a class="btn btn-success"
                                                                    href="/admin/user/${user.id}">Xem thêm</a>
                                                                <a class="btn btn-warning"
                                                                    href="/admin/user/update/${user.id}">Cập nhật</a>
                                                                <a class="btn btn-danger" href="#" data-toggle="modal"
                                                                    data-target="#deleteModal"
                                                                    data-entity-id="${user.id}"
                                                                    data-entity-name="${user.fullname}"> Xoá
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