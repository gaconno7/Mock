<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <jsp:include page="../layout/head.jsp">
                <jsp:param name="pageTitle" value="Cập nhật người dùng" />
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
                                    <h1 class="h3 mb-0 text-gray-800">Cập nhật thông tin người dùng</h1>
                                </div>

                                <!-- Message Content -->
                                <jsp:include page="../layout/message.jsp" />
                                <!-- End of Message Content -->

                                <!-- DataTales Example -->
                                <div class="card shadow mb-4">
                                    <div
                                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Cập nhật thông tin tài khoản
                                            <span class="text-danger">${currentUser.fullname}</span>
                                        </h6>
                                        <a href="/admin/user" class="btn btn-primary">Trở về</a>
                                    </div>
                                    <div class="card-body">
                                        <form:form method="post" action="/admin/user/update"
                                            modelAttribute="currentUser">


                                            <c:set var="errorEmail">
                                                <form:errors path="email" cssClass="invalid-feedback" />
                                            </c:set>
                                            <c:set var="errorFullName">
                                                <form:errors path="fullname" cssClass="invalid-feedback" />
                                            </c:set>
                                            <c:set var="errorPhone">
                                                <form:errors path="phone" cssClass="invalid-feedback" />
                                            </c:set>


                                            <div class="form-group row justify-content-md-center d-none">
                                                <label for="id" class="col-md-1 col-form-label">ID:</label>
                                                <div class="col-md-3">
                                                    <form:input type="text" id="id" class="form-control-plaintext"
                                                        path="id" />
                                                </div>
                                            </div>
                                            <div class="form-group row justify-content-md-center">
                                                <label for="email" class="col-md-1 col-form-label">Email:</label>
                                                <div class="col-md-3">
                                                    <form:input type="text" id="email"
                                                        class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                        path="email" />
                                                    ${errorEmail}
                                                </div>
                                            </div>

                                            <div class="form-group row justify-content-md-center">
                                                <label for="fullName" class="col-md-1 col-form-label">Họ
                                                    và tên:</label>
                                                <div class="col-md-3">
                                                    <form:input type="text" id="fullname"
                                                        class="form-control ${not empty errorFullName ? 'is-invalid' : ''}"
                                                        path="fullname" />
                                                    ${errorFullName}
                                                </div>
                                            </div>
                                            <div class="form-group row justify-content-md-center">
                                                <label for="phone" class="col-md-1 col-form-label">Điện
                                                    thoại:</label>
                                                <div class="col-md-3">
                                                    <form:input type="text" id="phone"
                                                        class="form-control ${not empty errorPhone ? 'is-invalid' : ''}"
                                                        path="phone" />
                                                    ${errorPhone}
                                                </div>
                                            </div>
                                            <div class="form-group row justify-content-md-center">
                                                <label for="address" class="col-md-1 col-form-label">Địa chỉ:</label>
                                                <div class="col-md-3">
                                                    <form:input type="text" id="address" class="form-control"
                                                        path="address" />
                                                </div>
                                            </div>
                                            <div class="form-group row justify-content-md-center">
                                                <label for="role" class="col-md-1 col-form-label">Vai trò:</label>
                                                <div class="col-md-3">
                                                    <form:select id="role" class="form-control" path="role.name">
                                                        <form:option value="ROLE_ADMIN">ADMIN</form:option>
                                                        <form:option value="ROLE_SUPPLIER">SUPPLIER</form:option>
                                                        <form:option value="ROLE_USER">USER</form:option>
                                                    </form:select>
                                                </div>
                                            </div>


                                            <div class="form-group row justify-content-md-center">
                                                <div class="col-md-3">
                                                    <form:input type="password" id="password" class="form-control"
                                                        path="password" style="display: none" />
                                                </div>
                                            </div>
                                            <div class="form-group row justify-content-md-center">
                                                <button class="btn btn-warning btn-icon-split mt-3" type="submit">
                                                    <span class="icon text-white-50">
                                                        <i class="fas fa-pencil-alt"></i>
                                                    </span>
                                                    <span class="text">Cập nhật</span>
                                                </button>
                                            </div>
                                        </form:form>
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