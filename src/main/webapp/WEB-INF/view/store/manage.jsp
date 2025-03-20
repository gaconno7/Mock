<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Product Management - AHC Vietnam Official Store</title>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link rel="stylesheet" href="/store/css/styles.css">
                    <script src="/store/js/script"></script>
                </head>

                <body>
                    <!-- Top Banner -->
                    <div class="top-banner">
                        Summer Sale For All Swim Suits And Free Express Delivery - Off 50%! <span>ShopNow</span>
                        <div class="language-selector">
                            English <i class="fas fa-chevron-down"></i>
                        </div>
                    </div>

                    <!-- Header -->
                    <header>
                        <div class="logo">Exclusive</div>
                        <nav class="nav-menu">
                            <a href="index.html">Store Front</a>
                            <a href="product-management.html" class="active">Products</a>
                            <a href="#">Orders</a>
                            <a href="#">Customers</a>
                        </nav>
                        <div class="header-icons">
                            <i class="fas fa-bell"></i>
                            <i class="fas fa-cog"></i>
                            <i class="fas fa-user-circle"></i>
                        </div>
                    </header>

                    <!-- Main Content -->
                    <div class="main-content">
                        <div class="page-title">
                            <h1>Product Management</h1>
                            <a href="/store/create" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                                    class="fas fa-plus-circle fa-sm text-white-50"></i>Them</a>
                        </div>

                        <!-- Dashboard Cards -->
                        <div class="dashboard-cards">
                            <div class="dashboard-card">
                                <i class="fas fa-box"></i>
                                <h3>Total Products</h3>
                                <p>19 products</p>
                            </div>
                            <div class="dashboard-card">
                                <i class="fas fa-check-circle"></i>
                                <h3>Active Products</h3>
                                <p>15 products</p>
                            </div>
                            <div class="dashboard-card">
                                <i class="fas fa-exclamation-circle"></i>
                                <h3>Out of Stock</h3>
                                <p>2 products</p>
                            </div>
                            <div class="dashboard-card">
                                <i class="fas fa-edit"></i>
                                <h3>Draft Products</h3>
                                <p>2 products</p>
                            </div>
                        </div>





                        <c:forEach var="product" items="${products}" varStatus="status">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0"
                                    style="margin-left: 10%;">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Tên</th>
                                            <th>Giá</th>
                                            <th>Loại sản phẩm</th>
                                            <th>Hành động</th>

                                        </tr>
                                    </thead>
                                    <tbody>


                                        <tr>
                                            <th>${status.index + 1}</th>
                                            <td class="product-name">${product.name}</td>
                                            <td>
                                                <fmt:formatNumber type="number" value="${product.price}" />
                                                đ
                                            </td>
                                            <td>${product.category.name}</td>
                                            <td>
                                                <a class="btn btn-danger" href="/admin/product/${product.id}">Xem
                                                    thêm</a>
                                                <a class="btn btn-danger" href="/admin/product/update/${product.id}">Cập
                                                    nhật</a>
                                                <a class="btn btn-danger" href="#" data-toggle="modal"
                                                    data-target="#deleteModal" data-entity-id="${product.id}"
                                                    data-entity-name="${product.name}"> Xoá
                                                </a>
                                            </td>

                                        </tr>

                        </c:forEach>
                        </tbody>

                        </table>


                    </div>


                    </div>



                    <!-- Footer -->
                    <footer>
                        <div class="footer-content">
                            <div class="footer-column">
                                <h3>Exclusive</h3>
                                <ul>
                                    <li>Admin Dashboard</li>
                                    <li>Product Management</li>
                                    <li>Order Management</li>
                                    <li>Customer Management</li>
                                </ul>
                            </div>
                            <div class="footer-column">
                                <h3>Support</h3>
                                <ul>
                                    <li>111 Bijoy sarani, Dhaka,</li>
                                    <li>DH 1515, Bangladesh.</li>
                                    <li>exclusive@gmail.com</li>
                                    <li>+88015-88888-9999</li>
                                </ul>
                            </div>
                            <div class="footer-column">
                                <h3>Account</h3>
                                <ul>
                                    <li>Admin Profile</li>
                                    <li>Settings</li>
                                    <li>Notifications</li>
                                    <li>Logout</li>
                                </ul>
                            </div>
                            <div class="footer-column">
                                <h3>Quick Link</h3>
                                <ul>
                                    <li>Privacy Policy</li>
                                    <li>Terms Of Use</li>
                                    <li>FAQ</li>
                                    <li>Contact</li>
                                </ul>
                            </div>
                        </div>
                        <div class="copyright">
                            <p>© Copyright Rimel 2022. All right reserved</p>
                        </div>
                    </footer>


                </body>

                </html>