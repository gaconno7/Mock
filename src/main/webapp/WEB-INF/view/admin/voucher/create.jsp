<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">


            <jsp:include page="../layout/head.jsp">
                <jsp:param name="pageTitle" value="Thêm mã giảm giá" />
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
                                    <h1 class="h3 mb-0 text-gray-800">Quản lí mã giảm giá</h1>
                                </div>

                                <!-- Message Content -->
                                <jsp:include page="../layout/message.jsp" />
                                <!-- End of Message Content -->

                                <!-- DataTales Example -->
                                <form:form method="post" action="/admin/voucher/create" modelAttribute="newVoucher">
                                    <div class="form-group">
                                        <label for="name">Tên:</label>
                                        <form:input type="text" id="name" class="form-control" path="name" />
                                        <form:errors path="name" cssClass="text-danger" />
                                    </div>

                                    <div class="form-group">
                                        <label for="discount">Giá trị:</label>
                                        <form:input type="text" id="discount" class="form-control" path="discount" />
                                        <form:errors path="discount" cssClass="text-danger" />
                                    </div>

                                    <div class="form-group">
                                        <label for="expirationDate">Ngày hết hạn:</label>
                                        <form:input type="date" id="expirationDate" class="form-control" path="expirationDate" />
                                        <form:errors path="expirationDate" cssClass="text-danger" />
                                    </div>

                                    <div class="form-group">
                                        <label for="effectiveDate">Ngày hiệu lực:</label>
                                        <form:input type="date" id="effectiveDate" class="form-control" path="effectiveDate" />
                                        <form:errors path="effectiveDate" cssClass="text-danger" />
                                    </div>

                                    <div class="form-group">
                                        <label for="description">Mô tả:</label>
                                        <form:textarea id="description" class="form-control" path="description" />
                                        <form:errors path="description" cssClass="text-danger" />
                                    </div>
                                    <div class="form-group row justify-content-md-center">
                                        <label for="voucherTypeId" class="col-md-4 col-form-label">Loại:</label>
                                        <div class="col-md-8">
                                            <select name="voucherTypeId" id="voucherTypeId"
                                                    class="form-control ${not empty errorVoucherType ? 'is-invalid' : ''}">
                                                <option value="">Chọn loại sản phẩm</option>
                                                <c:forEach items="${voucherType}" var="item">
                                                    <option value="${item.id}"  >
                                                            ${item.name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                                ${errorCategory}
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-success">Thêm Voucher</button>
                                </form:form>


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
                    <jsp:param name="entity" value="voucher" />
                    <jsp:param name="actionSubfolder" value="voucher" />
                    <jsp:param name="modalAttribute" value="deleteVoucher" />
                </jsp:include>

                <!-- End of Page Wrapper -->

                <jsp:include page="../layout/foot.jsp" />

            </body>

            </html>