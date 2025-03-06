<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <jsp:include page="../layout/head.jsp">
            <jsp:param name="pageTitle" value="Thống kê" />
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
                                <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
                                <!-- <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-success shadow-sm"><i
                                        class="fas fa-download fa-sm text-white-50"></i> Xuất file excel</a> -->
                            </div>

                            <!-- Content Row -->
                            <div class="row">

                                <div class="col-xl-3 col-md-6 mb-4" onclick="location.href='/admin/user';"
                                    style="cursor: pointer;">
                                    <div class="card border-left-primary shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="font-weight-bold text-primary text-uppercase mb-1">
                                                        Số lượng tài khoản</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">1
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-user fa-2x text-gray-300"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-md-6 mb-4" onclick="location.href='/admin/product';"
                                    style="cursor: pointer;">
                                    <div class="card border-left-success shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="font-weight-bold text-success text-uppercase mb-1">
                                                        Số lượng sản phẩm</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">1
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-laptop fa-2x text-gray-300"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-md-6 mb-4" onclick="location.href='/admin/order';"
                                    style="cursor: pointer;">
                                    <div class="card border-left-info shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="font-weight-bold text-info text-uppercase mb-1">
                                                        Số lượng đơn hàng
                                                    </div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">1
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <i class="fas fa-archive fa-2x text-gray-300"></i>
                                                </div>
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