<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<jsp:include page="../layout/head.jsp">
    <jsp:param name="pageTitle" value="Thống kê" />
</jsp:include>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

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
                    <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
                    <!-- <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-success shadow-sm"><i
                            class="fas fa-download fa-sm text-white-50"></i> Xuất file excel</a> -->
                </div>

                <!-- Content Row -->
                <div class="row">

                    <div class="col-xl-3 col-md-6 mb-4 manageItem" onclick="location.href='/admin/user';"
                         style="cursor: pointer;">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="font-weight-bold text-primary text-uppercase mb-1">
                                            Số lượng tài khoản</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalUsers}
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32"
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

                    <div class="col-xl-3 col-md-6 mb-4 manageItem" onclick="location.href='/admin/product';"
                         style="cursor: pointer;">
                        <div class="card border-left-success shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="font-weight-bold text-success text-uppercase mb-1">
                                            Số lượng sản phẩm</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalProducts}
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32"
                                             viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                             stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                             class="lucide lucide-package-open">
                                            <path d="M12 22v-9" />
                                            <path
                                                    d="M15.17 2.21a1.67 1.67 0 0 1 1.63 0L21 4.57a1.93 1.93 0 0 1 0 3.36L8.82 14.79a1.655 1.655 0 0 1-1.64 0L3 12.43a1.93 1.93 0 0 1 0-3.36z" />
                                            <path
                                                    d="M20 13v3.87a2.06 2.06 0 0 1-1.11 1.83l-6 3.08a1.93 1.93 0 0 1-1.78 0l-6-3.08A2.06 2.06 0 0 1 4 16.87V13" />
                                            <path
                                                    d="M21 12.43a1.93 1.93 0 0 0 0-3.36L8.83 2.2a1.64 1.64 0 0 0-1.63 0L3 4.57a1.93 1.93 0 0 0 0 3.36l12.18 6.86a1.636 1.636 0 0 0 1.63 0z" />
                                        </svg>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4 manageItem" onclick="location.href='/admin/order';"
                         style="cursor: pointer;">
                        <div class="card border-left-info shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="font-weight-bold text-info text-uppercase mb-1">
                                            Số lượng đơn hàng
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalOders}
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32"
                                             viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                             stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                             class="lucide lucide-receipt-text">
                                            <path
                                                    d="M4 2v20l2-1 2 1 2-1 2 1 2-1 2 1 2-1 2 1V2l-2 1-2-1-2 1-2-1-2 1-2-1-2 1Z" />
                                            <path d="M14 8H8" />
                                            <path d="M16 12H8" />
                                            <path d="M13 16H8" />
                                        </svg>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 mb-4 manageItem" onclick="location.href='/admin/order';"
                         style="cursor: pointer;">
                        <div class="card border-left-info shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="font-weight-bold text-info text-uppercase mb-1">
                                            Tổng doanh thu
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><fmt:formatNumber type="number" value="${totalRevenue}" /> đ
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32"
                                             viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                             stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                             class="lucide lucide-receipt-text">
                                            <path
                                                    d="M4 2v20l2-1 2 1 2-1 2 1 2-1 2 1 2-1 2 1V2l-2 1-2-1-2 1-2-1-2 1-2-1-2 1Z" />
                                            <path d="M14 8H8" />
                                            <path d="M16 12H8" />
                                            <path d="M13 16H8" />
                                        </svg>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>



                </div>

                <div class="row">
                    <!-- Pie Chart -->
                    <div class="col-xl-6 col-lg-5">
                        <div class="card shadow mb-4" style="height:95%">
                            <canvas id="myChart"
                                    style="width:100%;max-width:600px;margin-top: 5%;margin-bottom: 5%;"></canvas>
                        </div>
                    </div>
                    <div class="col-xl-6 col-lg-5">
                        <div class="card shadow mb-4" style="height:95%">

                            <canvas id="myChart2"
                                    style="width:100%;max-width:570px;margin-top: 5%;margin-bottom: 5%;margin-left: 2%;"></canvas>
                            <form action="${pageContext.request.contextPath}/admin" method="get">

                                <select name="year" id="year" class="form-select form-select-lg mb-3" style="padding: 4px; border-radius: 6px; margin-left:30px; margin-right: 10px">
                                    <option value="2023" ${activeYear == 2023 ? 'selected="selected"' : ''}>2023</option>
                                    <option value="2024" ${activeYear == 2024 ? 'selected="selected"' : ''}>2024</option>
                                    <option value="2025" ${activeYear == 2025 ? 'selected="selected"' : ''}>2025</option>
                                </select>
                                <button type="submit" class="btn btn-primary" style="padding: 4px; width: 70px">Lọc</button>
                            </form>
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
<script>
    const xValues = ["Admin", "User", "Supplier"];
    const yValues = [
        ${ countListAdmins },
        ${ countListUsers },
        ${ countListSuppliers }
    ];
    const barColors = [
        "#0073e6",
        "#1cc88a",
        "#36b9cc",
    ];

    new Chart("myChart", {
        type: "doughnut",
        data: {
            labels: xValues,
            datasets: [{
                backgroundColor: barColors,
                data: yValues
            }]
        },
        options: {
            title: {
                display: true,
                text: "Biểu đồ thống kê số lượng tài khoản"
            }
        }
    });
</script>

<script>
    const xValuess = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    const yValuess = ${totalRevenueByMonth};

    new Chart("myChart2", {
        type: "line",
        data: {
            labels: xValuess,
            datasets: [{
                fill: false,
                lineTension: 0,
                backgroundColor: "#0073e6",
                borderColor: "#1cc88a",
                data: yValuess
            }]
        },
        options: {
            legend: { display: false },
            scales: {
                yAxes: [{
                    ticks: {
                        min: 100000, // Giá trị tối thiểu
                        max: 1000000000, // Giá trị tối đa
                        callback: function(value, index, values) {
                            return value.toLocaleString('vi-VN') + " đ";
                        }
                    }
                }]
            },
            tooltips: {
                callbacks: {
                    label: function(tooltipItem, data) {
                        let value = tooltipItem.yLabel;
                        return value.toLocaleString('vi-VN') + " đ";
                    }
                }
            }
        }
    });
</script>


</html>