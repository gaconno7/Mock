<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            height: 100vh;
            justify-content: center;
            align-items: center;
            background-color: #f8f9fa;
        }
        .container {
            display: flex;
            max-width: 900px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .image-section {
            flex: 1;
            background: url('your-image-url.jpg') no-repeat center;
            background-size: cover;
        }
        .form-section {
            flex: 1;
            padding: 40px;
        }
        .btn-google {
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="image-section d-none d-md-block"></div>
        <div class="form-section">
            <h2>Create an account</h2>
            <p>Enter your details below</p>
            <form>
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="Name">
                </div>
                <div class="mb-3">
                    <input type="email" class="form-control" placeholder="Email or Phone Number">
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" placeholder="Password">
                </div>
                <button type="submit" class="btn btn-danger w-100">Create Account</button>
                <div class="mt-3 text-center">
                    <button type="button" class="btn btn-light btn-google w-100">
                        <img src="https://img.icons8.com/color/16/000000/google-logo.png" alt="Google"> Sign up with Google
                    </button>
                </div>
            </form>
            <div class="mt-3 text-center">
                <p>Already have an account? <a href="#">Log in</a></p>
            </div>
        </div>
    </div>
</body>
</html>
