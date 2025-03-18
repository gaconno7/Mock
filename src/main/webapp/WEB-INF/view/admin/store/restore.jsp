<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <jsp:include page="../layout/head.jsp">
                    <jsp:param name="pageTitle" value="Khôi phục cửa hàng" />
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
                                                            <h3>Khôi phục cửa hàng <strong>${restoreStore.name}</strong>
                                                            </h3>
                                                        </div>

                                                        <hr>

                                                        <div class="alert alert-warning">
                                                            <p>Bạn có muốn khôi phục cửa hàng này?</p>
                                                            <ul>
                                                                <li><strong>Tên cửa hàng:</strong> ${restoreStore.name}
                                                                </li>
                                                                <li><strong>Mô tả:</strong> ${restoreStore.description}
                                                                </li>
                                                                <c:if test="${not empty restoreStore.user}">
                                                                    <li><strong>Chủ cửa hàng:</strong>
                                                                        ${restoreStore.user.fullname}</li>
                                                                </c:if>
                                                            </ul>
                                                            <p><strong>Thời gian xóa:</strong>
                                                                <fmt:formatDate value="${restoreStore.deletedDate}"
                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                            </p>
                                                        </div>

                                                        <form:form method="post" action="/admin/store/restore"
                                                            modelAttribute="restoreStore">
                                                            <div class="mb-3" style="display: none;">
                                                                <label class="form-label">ID:</label>
                                                                <form:input type="text" class="form-control"
                                                                    path="id" />
                                                            </div>
                                                            <div class="d-flex gap-2">
                                                                <button type="submit" class="btn btn-success">Xác nhận
                                                                    khôi
                                                                    phục</button>
                                                                <a href="/admin/store" class="btn btn-secondary">Hủy
                                                                    bỏ</a>
                                                            </div>
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
                    <!-- End of Page Wrapper -->

                    <jsp:include page="../layout/foot.jsp" />

                </body>

                </html>