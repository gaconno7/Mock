<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Store Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .store-banner {
            background: url('your-background-image.jpg') no-repeat center;
            background-size: cover;
            padding: 30px;
            border-radius: 10px;
            position: relative;
        }
        .store-info {
            background: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
        }
        .product-card {
            border-radius: 10px;
            transition: transform 0.3s;
        }
        .product-card:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <!-- Store Banner -->
        <div class="store-banner p-4 text-white">
            <div class="d-flex align-items-center">
                <img src="${store.image}" class="rounded-circle" width="80" height="80" alt="Store Logo">
                <h2 class="ms-3">AHC Vietnam Official Store</h2>
            </div>
            <div class="mt-3">
                <button class="btn btn-dark">Follow</button>
                <button class="btn btn-dark">Chat</button>
            </div>
            <div class="store-info mt-3">
                <p>🛍️ Product: 19 | 👥 Follow: 19 | ⭐ Rate: 4.6</p>
            </div>
        </div>

        <!-- Best Selling Products -->
        <div class="mt-5">
            <h5 class="text-danger">This Month</h5>
            <h2>Best Selling Products</h2>
            <div class="d-flex justify-content-between align-items-center">
                <button class="btn btn-danger">View All</button>
            </div>
            <div class="row mt-3">
                <c:forEach var="product" items="${bestSellingProducts}">
                    <div class="col-md-3">
                        <div class="card product-card p-3">
                            <img src="${product.image}" class="card-img-top" alt="${product.name}">
                            <div class="card-body text-center">
                                <h5>${product.name}</h5>
                                <p class="text-danger">$${product.price} <del class="text-muted">$${product.oldPrice}</del></p>
                                <p>⭐ ${product.rating} (${product.reviews})</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</body>
</html>
