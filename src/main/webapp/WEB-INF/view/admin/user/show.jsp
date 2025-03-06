<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <jsp:include page="../layout/head.jsp">
            <jsp:param name="pageTitle" value="Thống kê" />
        </jsp:include>

        <body id="page-top">
            <style>
                .manageItem {
                    transition: transform 0.3s ease, box-shadow 0.3s ease;
                }

                .manageItem:hover {
                    transform: scale(1.05);
                    color: cadetblue;
                }
            </style>

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
                                <h1 class="h3 mb-0 text-gray-800">Quản lý tài khoản</h1>
                                <a href="/admin/user/create"
                                    class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                                        class="fas fa-plus-circle fa-sm text-white-50"></i> Thêm tài khoản</a>
                            </div>

                            <!-- Content Row -->
                            <div class="row">

                                <div class="col-xl-4 col-md-6 mb-4 manageItem"
                                    onclick="location.href='/admin/user/list/${1}';" style="cursor: pointer;">
                                    <div class="card border-left-primary shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="font-weight-bold text-primary text-uppercase mb-1">
                                                        Admin</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">Số lượng:
                                                        ${countListAdmins}
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="36" height="36"
                                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                        class="lucide lucide-shield-user">
                                                        <path
                                                            d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z" />
                                                        <path d="M6.376 18.91a6 6 0 0 1 11.249.003" />
                                                        <circle cx="12" cy="11" r="4" />
                                                    </svg>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-4 col-md-6 mb-4 manageItem"
                                    onclick="location.href='/admin/user/list/${3}';" style="cursor: pointer;">
                                    <div class="card border-left-success shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="font-weight-bold text-success text-uppercase mb-1">
                                                        nhà cung cấp</div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">Số lượng:
                                                        ${countlistSuppliers}
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="36" height="36"
                                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                        class="lucide lucide-store">
                                                        <path
                                                            d="m2 7 4.41-4.41A2 2 0 0 1 7.83 2h8.34a2 2 0 0 1 1.42.59L22 7" />
                                                        <path d="M4 12v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8" />
                                                        <path d="M15 22v-4a2 2 0 0 0-2-2h-2a2 2 0 0 0-2 2v4" />
                                                        <path d="M2 7h20" />
                                                        <path
                                                            d="M22 7v3a2 2 0 0 1-2 2a2.7 2.7 0 0 1-1.59-.63.7.7 0 0 0-.82 0A2.7 2.7 0 0 1 16 12a2.7 2.7 0 0 1-1.59-.63.7.7 0 0 0-.82 0A2.7 2.7 0 0 1 12 12a2.7 2.7 0 0 1-1.59-.63.7.7 0 0 0-.82 0A2.7 2.7 0 0 1 8 12a2.7 2.7 0 0 1-1.59-.63.7.7 0 0 0-.82 0A2.7 2.7 0 0 1 4 12a2 2 0 0 1-2-2V7" />
                                                    </svg>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-4 col-md-6 mb-4 manageItem"
                                    onclick="location.href='/admin/user/list/${2}';" style="cursor: pointer;">
                                    <div class="card border-left-info shadow h-100 py-2">
                                        <div class="card-body">
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="font-weight-bold text-info text-uppercase mb-1">
                                                        người dùng
                                                    </div>
                                                    <div class="h5 mb-0 font-weight-bold text-gray-800">Số lượng:
                                                        ${countListUsers}
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="36" height="36"
                                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                        class="lucide lucide-user">
                                                        <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2" />
                                                        <circle cx="12" cy="7" r="4" />
                                                    </svg>
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