<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; background-color: #fff; }
        .cart-container { max-width: 1000px; margin: auto; padding: 40px 20px; }
        .breadcrumb { font-size: 14px; color: #6c757d; }
        .cart-table { background: #fff; border-radius: 8px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); }
        .cart-table thead { background: #f8f9fa; font-weight: bold; }
        .cart-table th, .cart-table td { text-align: center; vertical-align: middle; padding: 15px; }
        .cart-table img { width: 50px; border-radius: 5px; }
        .remove-btn { color: red; font-size: 20px; cursor: pointer; }
        .cart-buttons { margin-top: 20px; display: flex; justify-content: space-between; }
        .coupon-section { display: flex; gap: 10px; align-items: center; margin-top: 20px; }
        .coupon-section input { flex: 1; height: 40px; }
        .cart-summary { border: 1px solid #000; border-radius: 8px; padding: 20px; margin-top: 20px; }
        .cart-summary h5 { font-weight: bold; }
        .cart-summary p { display: flex; justify-content: space-between; }
        .btn-danger { background-color: #d9534f; border-color: #d9534f; }
        .btn-link { text-decoration: none; display: inline-block; padding: 8px 12px; border: 1px solid #000; border-radius: 5px; text-align: center; }
        .quantity-control { display: flex; align-items: center; justify-content: center; }
        .quantity-control button { border: none; background: #ddd; padding: 5px 10px; cursor: pointer; }
        .quantity-control input { width: 40px; text-align: center; border: none; }
    </style>
    <script>
        function updateQuantity(button, delta) {
            let input = button.parentElement.querySelector("input");
            let value = parseInt(input.value) + delta;
            if (value >= 1) input.value = value;
        }
    </script>
</head>
<body>
    <div class="cart-container">
        <nav class="breadcrumb">Home / Cart</nav>
        
        <table class="table cart-table mt-3">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="d-flex align-items-center"><span class="remove-btn">&times;</span>&nbsp; <img src="https://cdn1.viettelstore.vn/images/Product/ProductImage/medium/MTXT-HP-14s-dq2644TU-1.jpg"> LCD Monitor</td>
                    <td>$650</td>
                    <td>
                        <div class="quantity-control">
                            <button onclick="updateQuantity(this, -1)">-</button>
                            <input type="text" value="1" readonly>
                            <button onclick="updateQuantity(this, 1)">+</button>
                        </div>
                    </td>
                    <td>$650</td>
                </tr>
                <tr>
                    <td class="d-flex align-items-center"><span class="remove-btn">&times;</span>&nbsp; <img src="https://cdn1.viettelstore.vn/images/Product/ProductImage/medium/MTXT-HP-14s-dq2644TU-1.jpg"> H1 Gamepad</td>
                    <td>$550</td>
                    <td>
                        <div class="quantity-control">
                            <button onclick="updateQuantity(this, -1)">-</button>
                            <input type="text" value="2" readonly>
                            <button onclick="updateQuantity(this, 1)">+</button>
                        </div>
                    </td>
                    <td>$1100</td>
                </tr>
            </tbody>
        </table>
        
        <div class="cart-buttons">
            <a href="#" class="btn-link">Return To Shop</a>
            <a href="#" class="btn-link">Update Cart</a>
        </div>
        
        <div class="row">
            <div class="col-md-6 coupon-section">
                <input type="text" class="form-control" placeholder="Coupon Code">
                <a href="#" class="btn btn-danger">Apply Coupon</a>
            </div>
            <div class="col-md-4 offset-md-2 cart-summary">
                <h5>Cart Total</h5>
                <p><span>Subtotal:</span> <span>$1750</span></p>
                <p><span>Shipping:</span> <span>Free</span></p>
                <p><strong><span>Total:</span> <span>$1750</span></strong></p>
                <a href="#" class="btn btn-danger w-100">Proceed to Checkout</a>
            </div>
        </div>
    </div>
</body>
</html>
