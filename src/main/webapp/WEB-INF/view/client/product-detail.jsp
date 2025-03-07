<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Havic HV G-92 Gamepad | Exclusive</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            color: #333;
        }

        .announcement-bar {
            background-color: #000;
            color: white;
            text-align: center;
            padding: 10px;
        }

        .announcement-bar a {
            color: white;
            font-weight: bold;
            text-decoration: none;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            border-bottom: 1px solid #eee;
        }

        .logo {
            font-weight: bold;
            font-size: 24px;
        }

        .nav-links {
            display: flex;
            gap: 30px;
        }

        .nav-links a {
            text-decoration: none;
            color: #333;
        }

        .search-container {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 20px;
            padding: 5px 15px;
        }

        .search-container input {
            border: none;
            outline: none;
            padding: 5px;
            width: 200px;
        }

        .icons {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .breadcrumb {
            padding: 20px 5%;
            color: #777;
        }

        .breadcrumb a {
            color: #777;
            text-decoration: none;
        }

        .breadcrumb span {
            margin: 0 5px;
        }

        .product-container {
            display: flex;
            padding: 0 5% 50px;
            gap: 40px;
        }

        .product-images {
            flex: 1;
            display: flex;
            gap: 20px;
        }

        .thumbnails {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .thumbnail {
            width: 80px;
            height: 80px;
            border: 1px solid #ddd;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .thumbnail img {
            max-width: 90%;
            max-height: 90%;
        }

        .main-image {
            flex: 1;
            border: 1px solid #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .main-image img {
            max-width: 90%;
            max-height: 90%;
        }

        .product-details {
            flex: 1;
        }

        .product-title {
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .rating {
            color: #FFD700;
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .rating span {
            color: #777;
            margin-left: 10px;
        }

        .stock {
            color: #4CAF50;
            margin-left: 15px;
        }

        .price {
            font-size: 26px;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .description {
            margin-bottom: 20px;
            line-height: 1.6;
        }

        .divider {
            height: 1px;
            background-color: #eee;
            margin: 20px 0;
        }

        .options-label {
            font-weight: 500;
            margin-bottom: 10px;
        }

        .color-options {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .color-option {
            width: 25px;
            height: 25px;
            border-radius: 50%;
            cursor: pointer;
            border: 2px solid transparent;
        }

        .color-option.selected {
            border-color: #777;
        }

        .white {
            background-color: white;
            border: 1px solid #ddd;
        }

        .pink {
            background-color: #FF6B6B;
        }

        .size-options {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .size-option {
            padding: 5px 15px;
            border: 1px solid #ddd;
            cursor: pointer;
        }

        .size-option.selected {
            background-color: #e74c3c;
            color: white;
            border-color: #e74c3c;
        }

        .quantity {
            display: flex;
            margin-bottom: 20px;
            gap: 10px;
            align-items: center;
        }

        .quantity-input {
            display: flex;
            align-items: center;
        }

        .quantity-input button {
            width: 30px;
            height: 30px;
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            font-size: 16px;
            cursor: pointer;
        }

        .quantity-input input {
            width: 50px;
            height: 30px;
            text-align: center;
            border: 1px solid #ddd;
            border-left: none;
            border-right: none;
        }

        .buy-now {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 10px 40px;
            font-size: 16px;
            cursor: pointer;
        }

        .wishlist {
            padding: 10px;
            border: 1px solid #ddd;
            cursor: pointer;
            background-color: white;
        }

        .shipping-info {
            border: 1px solid #ddd;
            margin-top: 30px;
            border-radius: 5px;
        }

        .shipping-row {
            display: flex;
            padding: 15px;
            align-items: center;
            gap: 20px;
            border-bottom: 1px solid #eee;
        }

        .shipping-row:last-child {
            border-bottom: none;
        }

        .shipping-icon {
            font-size: 24px;
            color: #333;
        }

        .shipping-text strong {
            display: block;
            margin-bottom: 5px;
        }

        .shipping-text span {
            color: #777;
            font-size: 14px;
        }

        .shipping-text a {
            color: #333;
            text-decoration: underline;
        }

        .section-heading {
            padding: 20px;
            text-align: center;
            background-color: #f5f5f5;
            margin-bottom: 30px;
        }

        .related-products {
            padding: 0 5% 50px;
        }

        .related-title {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .related-title::before {
            content: '';
            width: 5px;
            height: 20px;
            background-color: #e74c3c;
            margin-right: 10px;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .product-card {
            border: 1px solid #f5f5f5;
            padding: 10px;
            position: relative;
        }

        .product-card img {
            width: 100%;
            height: 180px;
            object-fit: contain;
        }

        .discount-tag {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: #e74c3c;
            color: white;
            padding: 2px 8px;
            font-size: 12px;
        }

        .card-actions {
            position: absolute;
            top: 10px;
            right: 10px;
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .card-action-btn {
            background-color: white;
            border: 1px solid #ddd;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        .product-card-title {
            margin-top: 10px;
            font-weight: 500;
        }

        .product-card-price {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 5px;
        }

        .current-price {
            font-weight: 500;
        }

        .original-price {
            color: #777;
            text-decoration: line-through;
            font-size: 14px;
        }

        .product-card-rating {
            color: #FFD700;
            font-size: 14px;
            margin-top: 5px;
        }

        .product-card-rating span {
            color: #777;
            margin-left: 5px;
        }

        .add-to-cart {
            background-color: black;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            margin-top: 10px;
            cursor: pointer;
        }

        footer {
            background-color: black;
            color: white;
            padding: 50px 5%;
        }

        .footer-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 30px;
        }

        .footer-section h3 {
            margin-bottom: 20px;
            font-size: 18px;
        }

        .footer-links {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .footer-links a {
            color: white;
            text-decoration: none;
            opacity: 0.8;
        }

        .footer-address {
            line-height: 1.6;
            opacity: 0.8;
        }

        .footer-social {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .social-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: #333;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .app-download {
            margin-top: 15px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .qr-code {
            width: 100px;
            height: 100px;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            color: black;
            font-size: 10px;
            text-align: center;
        }

        .app-buttons {
            display: flex;
            gap: 10px;
        }

        .app-button {
            border: 1px solid white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 12px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .copyright {
            text-align: center;
            padding: 20px;
            background-color: black;
            color: white;
            opacity: 0.7;
            font-size: 14px;
            border-top: 1px solid #333;
        }

        /* Customer Reviews Section */
        .reviews-section {
            padding: 0 5% 50px;
        }

        .review-summary {
            display: flex;
            justify-content: space-between;
            padding: 30px 0;
            border-bottom: 1px solid #eee;
        }

        .average-rating {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .big-rating {
            font-size: 48px;
            font-weight: bold;
        }

        .star-breakdown {
            width: 300px;
        }

        .star-row {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }

        .star-label {
            width: 50px;
        }

        .star-bar-container {
            flex: 1;
            height: 8px;
            background-color: #eee;
            margin: 0 10px;
        }

        .star-bar {
            height: 100%;
            background-color: #FFD700;
        }

        .star-count {
            width: 30px;
            text-align: right;
            color: #777;
            font-size: 14px;
        }

        .review-filters {
            display: flex;
            gap: 10px;
            margin: 20px 0;
        }

        .review-filter {
            padding: 5px 15px;
            background-color: #f5f5f5;
            border-radius: 20px;
            font-size: 14px;
            cursor: pointer;
        }

        .review-filter.active {
            background-color: #333;
            color: white;
        }

        .review-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .review-item {
            border-bottom: 1px solid #eee;
            padding-bottom: 20px;
        }

        .review-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .reviewer-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .reviewer-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: #777;
        }

        .reviewer-name {
            font-weight: 500;
        }

        .verified-badge {
            background-color: #4CAF50;
            color: white;
            font-size: 12px;
            padding: 2px 5px;
            border-radius: 3px;
            margin-left: 10px;
        }

        .review-date {
            color: #777;
            font-size: 14px;
        }

        .review-content {
            line-height: 1.6;
        }

        .review-images {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .review-image {
            width: 80px;
            height: 80px;
            background-color: #f5f5f5;
            border-radius: 5px;
        }

        .review-feedback {
            display: flex;
            gap: 15px;
            margin-top: 15px;
            color: #777;
            font-size: 14px;
        }

        .review-btn {
            display: flex;
            align-items: center;
            gap: 5px;
            cursor: pointer;
        }

        .load-more {
            text-align: center;
            margin-top: 30px;
        }

        .load-more-btn {
            background-color: white;
            border: 1px solid #ddd;
            padding: 10px 30px;
            cursor: pointer;
        }

        /* Write Review Form */
        .review-form-container {
            margin: 30px 0;
            padding: 30px;
            border: 1px solid #eee;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .review-form-title {
            font-size: 20px;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-family: inherit;
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .star-rating-input {
            display: flex;
            gap: 10px;
        }

        .star-rating-input label {
            font-size: 24px;
            color: #ddd;
            cursor: pointer;
        }

        .star-rating-input label.active {
            color: #FFD700;
        }

        .file-upload {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .file-upload-btn {
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            padding: 8px 15px;
            cursor: pointer;
        }

        .file-upload-text {
            color: #777;
            font-size: 14px;
        }

        .form-submit-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 12px 25px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
</head>

<body>
<!-- Announcement Bar -->
<div class="announcement-bar">
    Summer Sale For All Swim Suits And Free Express Delivery - Off 50%! <a href="#">ShopNow</a>
</div>

<!-- Header -->
<header>
    <div class="logo">Exclusive</div>
    <div class="nav-links">
        <a href="#">Home</a>
        <a href="#">Contact</a>
        <a href="#">About</a>
        <a href="#">Sign Up</a>
    </div>
    <div class="search-container">
        <input type="text" placeholder="What are you looking for?">
        <span>🔍</span>
    </div>
    <div class="icons">
        <span>❤️</span>
        <span>🛒</span>
        <span>👤</span>
    </div>
</header>

<!-- Breadcrumb -->
<div class="breadcrumb">
    <a href="#">Account</a> <span>/</span> <a href="#">Gaming</a> <span>/</span> Havic HV G-92 Gamepad
</div>

<!-- Product Section -->
<div class="product-container">
    <div class="product-images">
        <div class="thumbnails">
            <c:forEach var="image" items="${product.productImages}" >
            <div class="thumbnail"><img src="${image.url}" alt="Gamepad view 4"></div>
            </c:forEach>
        </div>
        <div class="main-image">
            <img src="${product.productImages[0].url}" alt="Havic HV G-92 Gamepad">
        </div>
    </div>
    <div class="product-details">
        <h1 class="product-title">${product.name}</h1>
        <div class="rating">
            ★★★★☆ <span>(150 Reviews)</span> <span class="stock">In Stock</span>
        </div>
        <div class="price">${product.price}</div>
        <div class="description">
            ${product.description}
        </div>
        <div class="divider"></div>
        <div class="options-label">Colours:</div>

        <div class="options-label">Variant:</div>
        <div class="size-options">
            <c:forEach var="item" items="${product.productVariants}">
                <div class="size-option selected">${item.attribute} - ${item.value}</div>
            </c:forEach>
        </div>
        <div class="quantity">
            <div class="quantity-input">
                <button>-</button>
                <input type="text" value="0">
                <button>+</button>
            </div>
            <button class="buy-now">Buy Now</button>
            <button class="wishlist">❤️</button>
        </div>

    </div>
</div>

<!-- Customer Reviews Section -->
<div class="reviews-section">
    <div class="section-heading">
        <h2>Customer Reviews</h2>
    </div>

    <div class="review-summary">
        <div class="average-rating">
            <div class="big-rating">4.5</div>
            <div class="rating">★★★★☆</div>
            <div>Based on 150 reviews</div>
        </div>

        <div class="star-breakdown">
            <div class="star-row">
                <div class="star-label">5 ★</div>
                <div class="star-bar-container">
                    <div class="star-bar" style="width: 65%"></div>
                </div>
                <div class="star-count">98</div>
            </div>
            <div class="star-row">
                <div class="star-label">4 ★</div>
                <div class="star-bar-container">
                    <div class="star-bar" style="width: 25%"></div>
                </div>
                <div class="star-count">37</div>
            </div>
            <div class="star-row">
                <div class="star-label">3 ★</div>
                <div class="star-bar-container">
                    <div class="star-bar" style="width: 7%"></div>
                </div>
                <div class="star-count">10</div>
            </div>
            <div class="star-row">
                <div class="star-label">2 ★</div>
                <div class="star-bar-container">
                    <div class="star-bar" style="width: 2%"></div>
                </div>
                <div class="star-count">3</div>
            </div>
            <div class="star-row">
                <div class="star-label">1 ★</div>
                <div class="star-bar-container">
                    <div class="star-bar" style="width: 1%"></div>
                </div>
                <div class="star-count">2</div>
            </div>
        </div>
    </div>

    <!-- Write Review Form -->
    <div class="review-form-container">
        <h3 class="review-form-title">Write Your Review</h3>
        <form>
            <div class="form-group">
                <label>Your Rating</label>
                <div class="star-rating-input">
                    <label class="active">★</label>
                    <label class="active">★</label>
                    <label class="active">★</label>
                    <label class="active">★</label>
                    <label>★</label>
                </div>
            </div>

            <div class="form-group">
                <label for="review-title">Review Title</label>
                <input type="text" id="review-title" class="form-control" placeholder="Give your review a title">
            </div>

            <div class="form-group">
                <label for="review-content">Your Review</label>
                <textarea id="review-content" class="form-control"
                          placeholder="Write your comments here"></textarea>
            </div>

            <div class="form-group">
                <label>Add Photos (optional)</label>
                <div class="file-upload">
                    <button type="button" class="file-upload-btn">Choose Files</button>
                    <span class="file-upload-text">No files selected</span>
                </div>
            </div>

            <div class="form-group">
                <label for="reviewer-name">Your Name</label>
                <input type="text" id="reviewer-name" class="form-control" placeholder="Enter your name">
            </div>

            <div class="form-group">
                <label for="reviewer-email">Email Address</label>
                <input type="email" id="reviewer-email" class="form-control" placeholder="Enter your email address">
            </div>

            <button type="submit" class="form-submit-btn">Submit Review</button>
        </form>
    </div>

    <div class="review-filters">
        <div class="review-filter active">All</div>
        <div class="review-filter">5 Star</div>
        <div class="review-filter">4 Star</div>
        <div class="review-filter">3 Star</div>
        <div class="review-filter">2 Star</div>
        <div class="review-filter">1 Star</div>
        <div class="review-filter">With Photos</div>
    </div>

    <div class="review-list">
        <div class="review-item">
            <div class="review-header">
                <div class="reviewer-info">
                    <div class="reviewer-avatar">JD</div>
                    <div>
                        <div class="reviewer-name">John Doe <span class="verified-badge">Verified Purchase</span>
                        </div>
                        <div class="rating">★★★★★</div>
                    </div>
                </div>
                <div class="review-date">March 1, 2025</div>
            </div>
            <div class="review-content">
                <strong>Amazing quality and responsiveness!</strong>
                <p>I've been using this gamepad for about two weeks now, and I'm extremely impressed with the build
                    quality. The buttons have a satisfying feel, and the triggers are perfectly responsive. I
                    particularly love the grip texture which prevents slipping during intense gaming sessions.
                    Battery life is outstanding - I've played for 8+ hours on a single charge.</p>
            </div>
            <div class="review-images">
                <div class="review-image"></div>
                <div class="review-image"></div>
            </div>
            <div class="review-feedback">
                <div class="review-btn">👍 Helpful (24)</div>
                <div class="review-btn">🔄 Report</div>
            </div>
        </div>

        <div class="review-item">
            <div class="review-header">
                <div class="reviewer-info">
                    <div class="reviewer-avatar">AS</div>
                    <div>
                        <div class="reviewer-name">Amanda Smith <span class="verified-badge">Verified
                                    Purchase</span></div>
                        <div class="rating">★★★★☆</div>
                    </div>
                </div>
                <div class="review-date">February 25, 2025</div>
            </div>
            <div class="review-content">
                <strong>Great gamepad with minor issues</strong>
                <p>The Havic HV G-92 Gamepad feels premium and works great with my PS5. Button placement is perfect
                    and the triggers have just the right amount of resistance. The only reason I'm giving it 4 stars
                    instead of 5 is because the D-pad feels a bit stiff for my taste, especially when playing
                    fighting games. Otherwise, this is an excellent controller for the price!</p>
            </div>
            <div class="review-feedback">
                <div class="review-btn">👍 Helpful (17)</div>
                <div class="review-btn">🔄 Report</div>
            </div>
        </div>

        <div class="related-products">
            <div class="related-title">
                <h3>Related Item</h3>
            </div>
            <div class="products-grid">
                <div class="product-card">
                    <span class="discount-tag">-40%</span>
                    <div class="card-actions">
                        <button class="card-action-btn">❤️</button>
                        <button class="card-action-btn">👁️</button>
                    </div>
                    <img src="/new1.jpg" alt="HAVIT HV-G92 Gamepad">
                    <h4 class="product-card-title">HAVIT HV-G92 Gamepad</h4>
                    <div class="product-card-price">
                        <span class="current-price">$120</span>
                        <span class="original-price">$160</span>
                    </div>
                    <div class="product-card-rating">
                        ★★★★★ <span>(88)</span>
                    </div>
                </div>
                <div class="product-card">
                    <span class="discount-tag">-35%</span>
                    <div class="card-actions">
                        <button class="card-action-btn">❤️</button>
                        <button class="card-action-btn">👁️</button>
                    </div>
                    <img src="/new1.jpg" alt="AK-900 Wired Keyboard">
                    <button class="add-to-cart">Add To Cart</button>
                    <h4 class="product-card-title">AK-900 Wired Keyboard</h4>
                    <div class="product-card-price">
                        <span class="current-price">$960</span>
                        <span class="original-price">$1160</span>
                    </div>
                    <div class="product-card-rating">
                        ★★★★☆ <span>(75)</span>
                    </div>
                </div>

                <div class="product-card">
                    <span class="discount-tag">-35%</span>
                    <div class="card-actions">
                        <button class="card-action-btn">❤️</button>
                        <button class="card-action-btn">👁️</button>
                    </div>
                    <img src="/new1.jpg" alt="AK-900 Wired Keyboard">
                    <button class="add-to-cart">Add To Cart</button>
                    <h4 class="product-card-title">AK-900 Wired Keyboard</h4>
                    <div class="product-card-price">
                        <span class="current-price">$960</span>
                        <span class="original-price">$1160</span>
                    </div>
                    <div class="product-card-rating">
                        ★★★★☆ <span>(75)</span>
                    </div>
                </div>

                <div class="product-card">
                    <span class="discount-tag">-35%</span>
                    <div class="card-actions">
                        <button class="card-action-btn">❤️</button>
                        <button class="card-action-btn">👁️</button>
                    </div>
                    <img src="/new1.jpg" alt="AK-900 Wired Keyboard">
                    <button class="add-to-cart">Add To Cart</button>
                    <h4 class="product-card-title">AK-900 Wired Keyboard</h4>
                    <div class="product-card-price">
                        <span class="current-price">$960</span>
                        <span class="original-price">$1160</span>
                    </div>
                    <div class="product-card-rating">
                        ★★★★☆ <span>(75)</span>
                    </div>
                </div>

                <div class="product-card">
                    <span class="discount-tag">-35%</span>
                    <div class="card-actions">
                        <button class="card-action-btn">❤️</button>
                        <button class="card-action-btn">👁️</button>
                    </div>
                    <img src="/new1.jpg" alt="AK-900 Wired Keyboard">
                    <button class="add-to-cart">Add To Cart</button>
                    <h4 class="product-card-title">AK-900 Wired Keyboard</h4>
                    <div class="product-card-price">
                        <span class="current-price">$960</span>
                        <span class="original-price">$1160</span>
                    </div>
                    <div class="product-card-rating">
                        ★★★★☆ <span>(75)</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

</html>