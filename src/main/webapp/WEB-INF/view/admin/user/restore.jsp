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







                                <!-- Message Content -->
                                <jsp:include page="../layout/message.jsp" />
                                <!-- End of Message Content -->

                                <!-- DataTales Example -->
                                <div class="card shadow mb-4">
                                    <div class="container-fluid px-4">

                                        <div class="container mt-5">
                                            <div class="row">
                                                <div class="col-12 mx-auto" style="margin-bottom: 400px;">
                                                    <div class="d-flex justify-content-between">
                                                        <h3>Khôi phục tài khoản <strong>${restoreUser.email}</strong>
                                                        </h3>

                                                    </div>

                                                    <hr>

                                                    <div class="alert alert-danger">
                                                        Bạn có muốn khôi phục tài khoản này?
                                                    </div>
                                                    <form:form method="post" action="/admin/user/restore"
                                                        modelAttribute="restoreUser">
                                                        <div class="mb-3" style="display: none;">
                                                            <label class="form-label">ID:</label>
                                                            <form:input value="${id}" type="text" class="form-control"
                                                                path="id" />
                                                        </div>
                                                        <a href="/admin/user/trash" class="btn btn-success">Trở về</a>
                                                        <button class="btn btn-danger">Xác nhận</button>
                                                    </form:form>
                                                </div>

                                            </div>

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