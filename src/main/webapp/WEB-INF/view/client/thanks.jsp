<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cảm ơn đã đặt hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .thank-you-box {
            max-width: 500px;
            margin: 100px auto;
            background: white;
            padding: 40px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .thank-you-box i {
            font-size: 60px;
            color: #28a745;
        }
        .btn-home {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="thank-you-box">
    <i class="bi bi-check-circle-fill"></i>
    <h2 class="fw-bold mt-3">Cảm ơn bạn đã đặt hàng!</h2>
    <p class="text-muted">Chúng tôi đã nhận được đơn hàng của bạn và sẽ xử lý trong thời gian sớm nhất.</p>
    <a href="/home" class="btn btn-danger btn-home">Quay lại trang chủ</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
