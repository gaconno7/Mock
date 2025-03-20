<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">


            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const imageInput = document.getElementById('imageFile');
                    const previewContainer = document.getElementById('imagePreviewContainer');

                    // Thêm sự kiện lắng nghe khi người dùng chọn file
                    imageInput.addEventListener('change', function () {
                        // Xóa các preview trước đó
                        previewContainer.innerHTML = '';

                        // Kiểm tra nếu có file được chọn
                        if (this.files && this.files.length > 0) {
                            for (let i = 0; i < this.files.length; i++) {
                                const file = this.files[i];

                                // Đảm bảo file là hình ảnh
                                if (!file.type.match('image.*')) {
                                    continue;
                                }

                                // Tạo container cho mỗi ảnh preview
                                const previewWrapper = document.createElement('div');
                                previewWrapper.className = 'preview-item me-2 mb-2 position-relative';
                                previewWrapper.style.width = '150px';

                                // Tạo phần tử hình ảnh
                                const img = document.createElement('img');
                                img.className = 'img-fluid rounded';
                                img.style.maxHeight = '150px';
                                img.style.objectFit = 'cover';

                                // Tạo nút xóa
                                const removeBtn = document.createElement('button');
                                removeBtn.className = 'btn btn-sm btn-danger position-absolute';
                                removeBtn.innerHTML = '&times;';
                                removeBtn.style.top = '5px';
                                removeBtn.style.right = '5px';
                                removeBtn.style.padding = '0 6px';

                                // Thêm chức năng xóa
                                removeBtn.addEventListener('click', function () {
                                    previewWrapper.remove();
                                    // Lưu ý: Điều này không xóa file khỏi input
                                    // Để làm điều đó, bạn cần một giải pháp phức tạp hơn
                                });

                                // Đọc file hình ảnh để tạo preview
                                const reader = new FileReader();
                                reader.onload = function (e) {
                                    img.src = e.target.result;
                                };
                                reader.readAsDataURL(file);

                                // Thêm các phần tử vào DOM
                                previewWrapper.appendChild(img);
                                previewWrapper.appendChild(removeBtn);
                                previewContainer.appendChild(previewWrapper);
                            }
                        }
                    });
                }); 
            </script>

            <script>
                function calculateDiscountedPrice() {
                    let price = parseFloat(document.getElementById("price").value) || 0;
                    let discountPercentage = parseFloat(document.getElementById("discountPercentage").value) || 0;

                    // Tính giá sau khi giảm
                    let discountedPrice = price - (price * discountPercentage / 100);

                    // Hiển thị kết quả
                    document.getElementById("discountPrice").value = discountedPrice.toFixed(2);
                }
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
                                                        <label for="discountPercentage"
                                                            class="col-md-4 col-form-label">Giảm giá (%):</label>
                                                        <div class="col-md-8">
                                                            <form:input min="0" max="100" type="number"
                                                                id="discountPercentage" class="form-control"
                                                                path="discountPrice"
                                                                oninput="calculateDiscountedPrice()" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group row justify-content-md-center">
                                                        <label for="price" class="col-md-4 col-form-label">Giảm
                                                            giá:</label>
                                                        <div class="col-md-8">
                                                            <input type="number" id="discountPrice"
                                                                class="form-control" />
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
                                                        <label for="storeId" class="col-md-4 col-form-label">Cửa
                                                            hàng:</label>
                                                        <div class="col-md-8">
                                                            <select name="storeId" id="storeId"
                                                                class="form-control ${not empty errorStore ? 'is-invalid' : ''}">
                                                                <option value="">Chọn cửa hàng</option>
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
                                                        <label for="content" class="col-md-4 col-form-label">Mô tả
                                                            chi tiết:</label>
                                                        <div class="col-md-8">
                                                            <form:textarea rows="10" type="text" id="description"
                                                                class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}"
                                                                path="description" />
                                                            ${errorDetailDesc}
                                                        </div>

                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group row justify-content-md-center">
                                                        <label for="imageFile" class="col-md-4 col-form-label">Hình
                                                            ảnh:</label>
                                                        <div class="col-md-8">
                                                            <input class="form-control" type="file" id="imageFile"
                                                                accept=".png, .jpg, .jpeg" name="imageFile" multiple />
                                                            <small class="form-text text-muted">Bạn có thể chọn
                                                                nhiều ảnh cùng lúc.</small>
                                                            <div id="imagePreviewContainer"
                                                                class="mt-3 d-flex flex-wrap"></div>
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
                    <jsp:param name="actionSubfolder" value="imageFile" />
                    <jsp:param name="modalAttribute" value="CreateimageFile" />
                </jsp:include>

                <!-- End of Page Wrapper -->

                <jsp:include page="../layout/foot.jsp" />

            </body>

            </html>