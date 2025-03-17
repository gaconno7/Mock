package com.mock.taka.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mock.taka.domain.CartItem;
import com.mock.taka.domain.Order;
import com.mock.taka.domain.OrderDetail;
import com.mock.taka.domain.User;
import com.mock.taka.repository.OrderDetailRepository;
import com.mock.taka.repository.OrderRepository;
import com.mock.taka.service.CartService;
import com.mock.taka.service.OrderService;
import com.mock.taka.service.VoucherService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/order")
public class OrderController {

    private final OrderRepository orderRepository;

    @Autowired
    private CartService cartService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private VoucherService voucherService;

    OrderController(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    @GetMapping("/process")
    public String checkout(Model model, HttpSession session) {
        List<String> selectedItems = (List<String>) session.getAttribute("selectedItems");

        if (selectedItems == null || selectedItems.isEmpty()) {
            return "redirect:/cart"; // Nếu không có sản phẩm, quay lại giỏ hàng
        }

        // Lấy danh sách sản phẩm dựa trên ID
        List<CartItem> orderItems = cartService.getCartItemsByIds(selectedItems);

        User user = (User) session.getAttribute("user");

        double totalPrice = 0.0;

        for (CartItem item : orderItems) {
            // Tính tổng tiền
            totalPrice += item.getProduct().getPrice() * item.getQuantity();
        }

        // Gửi dữ liệu tới trang checkout.jsp
        model.addAttribute("orderItems", orderItems);
        model.addAttribute("totalPrice", totalPrice);

        return "client/checkout";
    }

    @PostMapping("/confirm")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> confirmOrder(@RequestBody Map<String, String> orderData, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        try {
            // Get cart items from session
            List<String> selectedItems = (List<String>) session.getAttribute("selectedItems");

            List<CartItem> orderItems = cartService.getCartItemsByIds(selectedItems);

            User user = (User) session.getAttribute("user");
            
            // Extract order data
            String address = (String) orderData.get("address");
            
            // Get total price from request
            double totalPrice;
            try {
                // Handle different number formats (Double, String, Integer)
                Object totalPriceObj = orderData.get("totalPrice");
                if (totalPriceObj instanceof Number) {
                    totalPrice = ((Number) totalPriceObj).doubleValue();
                } else {
                    totalPrice = Double.parseDouble(totalPriceObj.toString());
                }
            } catch (Exception e) {
                response.put("success", false);
                response.put("message", "Invalid total price");
                return ResponseEntity.badRequest().body(response);
            }
            
            // Create order
            Order createdOrder = orderService.createOrder(
                    address,
                    orderItems,
                    totalPrice,
                    user
            );
            
            // Clear cart after successful order
            session.removeAttribute("cartItems");
            
            response.put("success", true);
            response.put("orderId", createdOrder.getId());
            response.put("redirectUrl", "/order/success?orderId=" + createdOrder.getId());
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }

    @PostMapping("/apply-coupon")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> applyCoupon(
            @RequestParam("couponCode") String couponCode, 
            @RequestParam("totalPrice") Double totalPrice) {

        Map<String, Object> response = new HashMap<>();

        // Kiểm tra mã giảm giá
        Double discountAmount = voucherService.validateAndApplyCoupon(couponCode, totalPrice);

        if (discountAmount == null) {
            response.put("success", false);
            response.put("message", "Invalid or expired coupon!");
            return ResponseEntity.badRequest().body(response);
        }

        // Cập nhật tổng tiền sau khi giảm giá
        Double newTotalPrice = totalPrice - discountAmount;

        // Trả về JSON
        response.put("success", true);
        response.put("newTotalPrice", newTotalPrice);
        response.put("message", "Coupon applied successfully! Discount: " + discountAmount + " VNĐ");
        return ResponseEntity.ok(response);
    }

}

