<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">
            <script>
                $(document).ready(() => {
                    const avatarFile = $("#avatarFile");
                    avatarFile.change(function (e) {
                        const imgURL = URL.createObjectURL(e.target.files[0]);
                        $("#avatarPreview").attr("src", imgURL);
                        $("#avatarPreview").css({ "display": "block" });
                    });
                });
            </script>

            <jsp:include page="../layout/head.jsp">
                <jsp:param name="pageTitle" value="Cập nhật sản phẩm" />
            </jsp:include>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
                  integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
            <link rel="stylesheet" href="<c:url value="/store/css/base-layout.css"/>">
            <body id="page-top">

            <%@ include file="../header/header.jsp" %>
                <!-- Page Wrapper -->
                <div id="wrapper">


                    <!-- Content Wrapper -->
                    <div id="content-wrapper" class="d-flex flex-column">

                        <!-- Main Content -->
                        <div id="content">

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
                                <form:form method="post" action="/store/product/update" modelAttribute="newProduct"
                                    enctype="multipart/form-data">
                                    <div class="card shadow mb-4">
                                        <div
                                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                            <h6 class="m-0 font-weight-bold text-primary">Cập nhật thông tin tài khoản
                                                <span class="text-danger">${newProduct.name}</span>
                                            </h6>
                                            <a href="/store/product" class="btn btn-primary">Trở về</a>
                                        </div>
                                        <div class="card-body">
                                            <c:set var="errorName">
                                                <form:errors path="name" cssClass="invalid-feedback" />
                                            </c:set>
                                            <c:set var="errorPrice">
                                                <form:errors path="price" cssClass="invalid-feedback" />
                                            </c:set>
                                            <c:set var="errorDescriptionc">
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
                                                        <label for="categoryId" class="col-md-4 col-form-label">Loại sản
                                                            phẩm:</label>
                                                        <div class="col-md-8">
                                                            <select name="categoryId" id="categoryId"
                                                                class="form-control ${not empty errorCategory ? 'is-invalid' : ''}">
                                                                <option value="">Chọn loại sản phẩm</option>
                                                                <c:forEach items="${category}" var="category">
                                                                    <option value="${category.id}" ${newProduct.category
                                                                        !=null && newProduct.category.id==category.id
                                                                        ? 'selected' : '' }>
                                                                        ${category.name}
                                                                    </option>
                                                                </c:forEach>
                                                            </select>
                                                            ${errorCategory}
                                                        </div>
                                                    </div>


                                                    <div class="form-group row justify-content-md-center">
                                                        <label for="detailDesc" class="col-md-4 col-form-label">Mô tả
                                                            chi tiết:</label>
                                                        <div class="col-md-8">
                                                            <form:textarea rows="10" type="text" id="description"
                                                                class="form-control ${not empty errorDescription ? 'is-invalid' : ''}"
                                                                path="description" />
                                                            ${errorDescription}
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-12">
                                                            <h4>Hình ảnh hiện tại</h4>
                                                            <div class="row">
                                                                <c:forEach items="${productImages}" var="image">
                                                                    <div class="col-md-3 mb-3">
                                                                        <div class="card">
                                                                            <img src="${image.url}" class="card-img-top"
                                                                                alt="Hình ảnh sản phẩm">
                                                                            <div class="card-body">
                                                                                <form
                                                                                    action="${pageContext.request.contextPath}/store/product/delete-image/${image.imageId}"
                                                                                    method="post">
                                                                                    <input type="hidden"
                                                                                        name="productId"
                                                                                        value="${newProduct.id}">
                                                                                    <button type="submit"
                                                                                        class="btn btn-sm btn-danger">Xóa</button>
                                                                                </form>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="imageFile">Tải lên thêm hình ảnh</label>
                                                        <input type="file" class="form-control-file" id="imageFile"
                                                            name="imageFile" multiple>
                                                    </div>
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

                                        </div>
                                    </div>

                            </div>
                            </form:form>
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
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                    crossorigin="anonymous"></script>
            </body>

            </html>