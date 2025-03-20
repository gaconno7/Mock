package com.mock.taka.controller;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

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
import com.mock.taka.config.AppConfig;
import com.mock.taka.domain.CartItem;
import com.mock.taka.domain.Order;
import com.mock.taka.domain.OrderDetail;
import com.mock.taka.domain.User;
import com.mock.taka.domain.Voucher;
import com.mock.taka.repository.OrderDetailRepository;
import com.mock.taka.repository.OrderRepository;
import com.mock.taka.service.CartService;
import com.mock.taka.service.OrderService;
import com.mock.taka.service.VNPayService;
import com.mock.taka.service.VoucherService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/order")
public class OrderController {

    private final OrderDetailRepository orderDetailRepository;

    private final AuthController authController;

    private final AppConfig appConfig;

    private final OrderRepository orderRepository;

    @Autowired
    private VNPayService vnPayService;

    @Autowired
    private CartService cartService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private VoucherService voucherService;

    OrderController(OrderRepository orderRepository, AppConfig appConfig, AuthController authController, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.appConfig = appConfig;
        this.authController = authController;
        this.orderDetailRepository = orderDetailRepository;
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

        //Lấy voucher
        List<Voucher> vouchers = voucherService.getAllVouchers();

        // Gửi dữ liệu tới trang checkout.jsp
        model.addAttribute("vouchers", vouchers);
        model.addAttribute("address", user.getAddress());
        model.addAttribute("orderItems", orderItems);
        model.addAttribute("totalPrice", totalPrice);

        return "client/checkout";
    }

    @PostMapping("/confirm")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> confirmOrder(
            @RequestBody Map<String, String> orderData,
            HttpSession session,
            HttpServletRequest request) { // Thêm HttpServletRequest để lấy IP

        Map<String, Object> response = new HashMap<>();

        try {
            // Lấy danh sách sản phẩm từ giỏ hàng
            List<String> selectedItems = (List<String>) session.getAttribute("selectedItems");
            List<CartItem> orderItems = cartService.getCartItemsByIds(selectedItems);

            // Lấy thông tin user từ session
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.put("success", false);
                response.put("message", "Người dùng chưa đăng nhập");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            }

            // Lấy thông tin địa chỉ và phương thức thanh toán
            String address = orderData.get("address");
            String paymentMethod = orderData.get("paymentMethod");

            // Xử lý tổng giá trị đơn hàng
            double totalPrice;
            try {
                Object totalPriceObj = orderData.get("totalPrice");
                if (totalPriceObj instanceof Number) {
                    totalPrice = ((Number) totalPriceObj).doubleValue();
                } else {
                    totalPrice = Double.parseDouble(totalPriceObj.toString());
                }
            } catch (Exception e) {
                response.put("success", false);
                response.put("message", "Giá trị đơn hàng không hợp lệ");
                return ResponseEntity.badRequest().body(response);
            }

            // Tạo mã đơn hàng (UUID)
            final String uuid = UUID.randomUUID().toString().replace("-", "");

            Order createdOrder = orderService.createOrder(address, orderItems, totalPrice, user, paymentMethod, "unpaid", uuid);

            // Nếu chọn VNPAY, chuyển hướng đến trang thanh toán
            if (!paymentMethod.equalsIgnoreCase("cod")) {
                // Lấy địa chỉ IP của người dùng
                String ip = vnPayService.getIpAddress(request);

                // Tạo URL thanh toán VNPAY
                String vnpUrl = vnPayService.generateVNPayURL(totalPrice, uuid, ip);
                System.out.println("=========================" + vnpUrl);

                response.put("success", true);
                response.put("message", "day la message");
                response.put("redirectUrl", vnpUrl);

                return ResponseEntity.ok(response);
            }

            // Xóa giỏ hàng sau khi đặt hàng thành công
            session.removeAttribute("cartItems");

            response.put("success", true);
            response.put("orderId", createdOrder.getId());
            response.put("redirectUrl", "/order/success?orderId=" + createdOrder.getId());

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi khi xác nhận đơn hàng: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }


    @GetMapping("/success")
    public String getThanksPage(Model model, @RequestParam("vnp_TxnRef") Optional<String> paymentRef, @RequestParam("vnp_ResponseCode") Optional<String> vnpayResponseCode) {
        if (vnpayResponseCode.isPresent() && paymentRef.isPresent()) {
            // thanh toán qua VNPAY, cập nhật trạng thái order
            String paymentStatus = vnpayResponseCode.get().equals("00")
                    ? "paid"
                    : "fail";
            orderService.updatePaymentStatus(paymentRef.get(), paymentStatus);
        }
        return "client/thanks";
    }
    

    @PostMapping("/apply-voucher")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> applyVoucher(
            @RequestParam("voucherId") String voucherId, 
            @RequestParam("totalPrice") Double totalPrice,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        // Kiểm tra mã giảm giá
        Double discountAmount = voucherService.validateAndApplyVoucher(voucherId, totalPrice);

        if (discountAmount == null) {
            response.put("success", false);
            response.put("message", "Invalid or expired voucher!");
            return ResponseEntity.badRequest().body(response);
        }

        // Cập nhật tổng tiền sau khi giảm giá
        Double newTotalPrice = totalPrice - discountAmount;

        if(newTotalPrice < 0) {
            newTotalPrice = 1.0;
        }

        session.setAttribute("newTotalPrice", newTotalPrice);

        DecimalFormat df = new DecimalFormat("#,###");

        // Trả về JSON
        response.put("success", true);
        response.put("newTotalPrice", newTotalPrice);
        response.put("message", "Voucher applied successfully! Discount: " + df.format(discountAmount) + " VNĐ");
        return ResponseEntity.ok(response);
    }

}

