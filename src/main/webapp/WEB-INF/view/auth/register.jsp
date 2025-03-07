<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create an account - Exclusive</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #ffffff;
        }

        .announcement-bar {
            background-color: #000000;
            color: white;
            padding: 10px 0;
            text-align: center;
        }

        .announcement-bar button {
            background-color: transparent;
            border: none;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 10%;
            border-bottom: 1px solid #e0e0e0;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
        }

        .nav {
            display: flex;
            gap: 30px;
        }

        .nav-item {
            text-decoration: none;
            color: black;
        }

        .search-container {
            display: flex;
            background-color: #f5f5f5;
            border-radius: 5px;
            padding: 8px 15px;
        }

        .search-container input {
            border: none;
            background: transparent;
            outline: none;
            width: 200px;
        }

        .search-container button {
            background: transparent;
            border: none;
            cursor: pointer;
        }

        .main-content {
            display: flex;
            padding: 0;
            min-height: 70vh;
        }

        .image-section {
            flex: 1;
            background-color: #e6f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .form-section {
            flex: 1;
            padding: 50px 10%;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-title {
            font-size: 32px;
            margin-bottom: 20px;
        }

        .form-subtitle {
            margin-bottom: 30px;
            color: #555;
        }

        .form-control {
            margin-bottom: 20px;
        }

        .form-control input {
            width: 100%;
            padding:.75rem 0;
            border: none;
            border-bottom: 1px solid #ddd;
            outline: none;
            font-size: 16px;
        }

        .btn-primary {
            background-color: #e63946;
            color: white;
            border: none;
            padding: 15px;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin: 10px 0 20px;
        }

        .btn-google {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            background-color: white;
            color: black;
            border: 1px solid #ddd;
            padding: 15px;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin: 10px 0;
        }

        .login-link {
            text-align: center;
            margin: 20px 0;
        }

        .login-link a {
            color: #e63946;
            text-decoration: none;
            font-weight: bold;
        }

        footer {
            background-color: #000000;
            color: white;
            padding: 50px 10%;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
        }

        .footer-section {
            flex: 1;
            margin-right: 30px;
        }

        .footer-title {
            font-size: 20px;
            margin-bottom: 20px;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 10px;
        }

        .footer-links a {
            color: white;
            text-decoration: none;
        }

        .subscribe-form {
            display: flex;
            margin-top: 15px;
            border: 1px solid white;
            width: fit-content;
        }

        .subscribe-form input {
            background: transparent;
            border: none;
            padding: 10px;
            color: white;
            outline: none;
        }

        .subscribe-form button {
            background: transparent;
            border: none;
            color: white;
            padding: 0 10px;
            cursor: pointer;
        }

        .app-section img {
            height: 40px;
            margin-right: 10px;
        }

        .qr-code {
            width: 100px;
            height: 100px;
            background-color: white;
            margin-bottom: 10px;
        }

        .social-icons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .social-icon {
            width: 25px;
            height: 25px;
            background-color: white;
            border-radius: 50%;
        }

        .copyright {
            text-align: center;
            padding-top: 30px;
            border-top: 1px solid #333;
        }
    </style>
</head>
<body>
<div class="announcement-bar">
    Summer Sale For All Swim Suits And Free Express Delivery - OFF 50%! <button>ShopNow</button>
    <span style="float: right; margin-right: 20px;">English ▼</span>
</div>

<div class="header">
    <div class="logo">Exclusive</div>
    <div class="nav">
        <a href="#" class="nav-item">Home</a>
        <a href="#" class="nav-item">Contact</a>
        <a href="#" class="nav-item">About</a>
        <a href="#" class="nav-item">Sign Up</a>
    </div>
    <div class="search-container">
        <input type="text" placeholder="What are you looking for?">
        <button>🔍</button>
    </div>
</div>

<div class="main-content">
    <form class="form-section" method="post" action="<c:url value="/register"/> ">
        <h1 class="form-title">Đăng ký</h1>
        <p class="form-subtitle">Enter your details below</p>

        <div class="form-control">
            <input type="text" placeholder="Họ và tên" name="full-name" required>
        </div>

        <div class="form-control">
            <input type="email" placeholder="Email" name="email" required>
        </div>

        <div class="form-control">
            <input type="password" placeholder="Mật khẩu" name="password" required>
        </div>

        <div class="form-control">
            <input type="password" placeholder="Nhập lại mật khẩu" name="re-password" required>
        </div>

        <button class="btn-primary" type="submit">OK</button>

        <button class="btn-google">
            <img src="https://th.bing.com/th/id/OIP.8QehHn1i3PEPr3ivNJP2fAHaHa?rs=1&pid=ImgDetMain" alt="Google logo" style="width: 20px; height: 20px;">
            Đăng nhập với Google
        </button>

        <div class="login-link">
            Bạn đã có tài khoản? <a href="<c:url value="/login"/> ">Đăng nhập</a>
        </div>
    </form>
</div>

<footer>
    <div class="footer-content">
        <div class="footer-section">
            <h3 class="footer-title">Exclusive</h3>
            <ul class="footer-links">
                <li><a href="#">Subscribe</a></li>
            </ul>
            <p>Get 10% off your first order</p>
            <div class="subscribe-form">
                <input type="email" placeholder="Enter your email">
                <button>→</button>
            </div>
        </div>

        <div class="footer-section">
            <h3 class="footer-title">Support</h3>
            <p>111 Bijoy sarani, Dhaka,<br>DH 1515, Bangladesh.</p>
            <p>exclusive@gmail.com</p>
            <p>+88015-88888-9999</p>
        </div>

        <div class="footer-section">
            <h3 class="footer-title">Account</h3>
            <ul class="footer-links">
                <li><a href="#">My Account</a></li>
                <li><a href="#">Login / Register</a></li>
                <li><a href="#">Cart</a></li>
                <li><a href="#">Wishlist</a></li>
                <li><a href="#">Shop</a></li>
            </ul>
        </div>

        <div class="footer-section">
            <h3 class="footer-title">Quick Link</h3>
            <ul class="footer-links">
                <li><a href="#">Privacy Policy</a></li>
                <li><a href="#">Terms Of Use</a></li>
                <li><a href="#">FAQ</a></li>
                <li><a href="#">Contact</a></li>
            </ul>
        </div>

        <div class="footer-section">
            <h3 class="footer-title">Download App</h3>
            <p>Save $3 with App New User Only</p>
            <div class="qr-code"></div>
            <div class="app-store-links">
                <img src="/api/placeholder/120/40" alt="Google Play">
                <img src="/api/placeholder/120/40" alt="App Store">
            </div>
            <div class="social-icons">
                <div class="social-icon"></div>
                <div class="social-icon"></div>
                <div class="social-icon"></div>
                <div class="social-icon"></div>
            </div>
        </div>
    </div>

    <div class="copyright">
        © Copyright Rimel 2022. All right reserved
    </div>
</footer>
</body>
</html>