<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">
            <script>
                $(document).ready(() => {
                    const imageFile = $("#imageFile");
                    imageFile.change(function (e) {
                        const imgURL = URL.createObjectURL(e.target.files[0]);
                        $("#avatarPreview").attr("src", imgURL);
                        $("#avatarPreview").css({ "display": "block" });
                    });
                }); 
            </script>

            <jsp:include page="../layout/head.jsp">
                <jsp:param name="pageTitle" value="Thêm sản phẩm" />
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
                                </div>

                                <!-- Message Content -->
                                <jsp:include page="../layout/message.jsp" />
                                <!-- End of Message Content -->

                                <!-- DataTales Example -->
                                <form:form method="post" action="/admin/product/create" modelAttribute="newProduct"
                                    enctype="multipart/form-data">
                                    <div class="card shadow mb-4">
                                        <div
                                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                            <h6 class="m-0 font-weight-bold text-primary">
                                                Thêm sản phẩm
                                            </h6>
                                            <a href="/admin/product" class="btn btn-primary">Trở về</a>
                                        </div>
                                        <div class="card-body">
                                            <c:set var="errorName">
                                                <form:errors path="name" cssClass="invalid-feedback" />
                                            </c:set>
                                            <c:set var="errorPrice">
                                                <form:errors path="price" cssClass="invalid-feedback" />
                                            </c:set>
                                            <c:set var="errorDetailDesc">
                                                <form:errors path="description" cssClass="invalid-feedback" />
                                            </c:set>

                                            <c:set var="errorQuantity">
                                                <form:errors path="quantity" cssClass="invalid-feedback" />
                                            </c:set>
                                            <c:set var="errorStore">
                                                <form:errors path="store" cssClass="invalid-feedback" />
                                            </c:set>

                                            <div class="form-group row">
                                                <div class="col-md-6">
                                                    <div class="form-group row justify-content-md-center d-none">
                                                        <label for="id" class="col-md-4 col-form-label">ID:</label>
                                                        <div class="col-md-8">
                                                            <form:input type="text" id="id"
                                                                class="form-control-plaintext" path="id" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group row justify-content-md-center">
                                                        <label for="name" class="col-md-4 col-form-label">Tên sản
                                                            phẩm:</label>
                                                        <div class="col-md-8">
                                                            <form:input type="text" id="name"
                                                                class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                                                path="name" />
                                                            ${errorName}
                                                        </div>
                                                    </div>

                                                    <div class="form-group row justify-content-md-center">
                                                        <label for="price" class="col-md-4 col-form-label">Giá:</label>
                                                        <div class="col-md-8">
                                                            <form:input type="number" id="price"
                                                                class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                                                                path="price" />
                                                            ${errorPrice}
                                                        </div>
                                                    </div>

                                                    <div class="form-group row justify-content-md-center">
                                                        <label for="quantity" class="col-md-4 col-form-label">Số
                                                            lượng:</label>
                                                        <div class="col-md-8">
                                                            <form:input type="number" id="quantity"
                                                                class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}"
                                                                path="quantity" />
                                                            ${errorQuantity}
                                                        </div>
                                                    </div>
                                                    <div class="form-group row justify-content-md-center">
                                                        <label for="storeId"
                                                            class="col-md-4 col-form-label">Store:</label>
                                                        <div class="col-md-8">
                                                            <select name="storeId" id="storeId"
                                                                class="form-control ${not empty errorStore ? 'is-invalid' : ''}">
                                                                <option value="">Select Store</option>
                                                                <c:forEach items="${stores}" var="store">
                                                                    <option value="${store.id}" ${newProduct.store
                                                                        !=null && newProduct.store.id==store.id
                                                                        ? 'selected' : '' }>
                                                                        ${store.name}
                                                                    </option>
                                                                </c:forEach>
                                                            </select>
                                                            ${errorStore}
                                                        </div>
                                                    </div>



                                                    <div class="form-group row justify-content-md-center">
                                                        <label for="detailDesc" class="col-md-4 col-form-label">Mô tả
                                                            chi tiết:</label>
                                                        <div class="col-md-8">
                                                            <form:textarea rows="10" type="text" id="detailDesc"
                                                                class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}"
                                                                path="description" />
                                                            ${errorDetailDesc}
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group row justify-content-md-center">
                                                        <label for="avatarFile" class="col-md-4 col-form-label">Hình
                                                            ảnh:</label>
                                                        <div class="col-md-8">
                                                            <input class="form-control" type="file" id="avatarFile"
                                                                accept=".png, .jpg, .jpeg" name="hoidanitFile" />
                                                            <img style="max-height: 250px; display: none; margin-top: 10px;"
                                                                alt="New Image Preview" id="avatarPreview" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group row justify-content-md-end">
                                                        <div class="col-md-8 d-flex justify-content-center">
                                                            <img style="max-height: 250px; display: none;" alt=""
                                                                id="avatarPreview">
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="form-group row justify-content-md-center">
                                                <button class="btn btn-success btn-icon-split mt-3" type="submit">
                                                    <span class="icon text-white-50">
                                                        <i class="fas fa-plus"></i>
                                                    </span>
                                                    <span class="text">Thêm sản phẩm</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
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
                    <jsp:param name="entity" value="sản phẩm" />
                    <jsp:param name="actionSubfolder" value="user" />
                    <jsp:param name="modalAttribute" value="deleteUser" />
                </jsp:include>

                <!-- End of Page Wrapper -->

                <jsp:include page="../layout/foot.jsp" />

            </body>

            </html>