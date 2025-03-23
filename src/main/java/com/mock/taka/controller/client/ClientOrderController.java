package com.mock.taka.controller.client;

import com.mock.taka.domain.*;
import com.mock.taka.service.client.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.text.DecimalFormat;
import java.util.*;

@Controller
@RequestMapping("/user/order")
@RequiredArgsConstructor
@FieldDefaults(level= AccessLevel.PRIVATE, makeFinal = true)
public class ClientOrderController {

    OrderService orderService;
    ReturnOrderService returnOrderService;
    VNPayService vnPayService;
    CartService cartService;
    VoucherService voucherService;
    @GetMapping("/history")
    public String showOrderView(ModelMap modelMap, HttpSession session) {
        List<Order> orders = (List<Order>) session.getAttribute("filteredOrders");
        if (orders == null) {
            orders = orderService.findAllByUserId(((User) session.getAttribute("user")).getId());
        }
        modelMap.addAttribute("orders", orders);
        session.removeAttribute("filteredOrders");
        orderService.findAllByStoreId("store9");
        return "client/order-history";
    }

    @GetMapping("/history/{status}")
    public String showOrderViewWithStatus(@PathVariable(name = "status") String status,
                                          HttpSession session) {
        User user = (User) session.getAttribute("user");
        List<Order> orders = orderService.findAllByUserIdAndStatus(user.getId(), status);
        session.setAttribute("filteredOrders", orders);
        return "redirect:/user/order/history";
    }


    @GetMapping("/{id}")
    public String showOrderDetail(@PathVariable(name = "id") String id,
                                          ModelMap modelMap) {
        modelMap.addAttribute("order", orderService.findById(id));
        modelMap.addAttribute("returnOrder", returnOrderService.findByOrderId(id));
        return "client/order-detail";
    }

    @GetMapping("/return-order/{id}")
    public String showReturnOrderView(@PathVariable(name = "id") String id,
                                      ModelMap modelMap) {
        modelMap.addAttribute("order", orderService.findById(id));
        return "client/return-order";
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
        model.addAttribute("name", user.getFullname());

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

            Order createdOrder = orderService.createOrder(address, orderItems, totalPrice, user, paymentMethod, "chua-thanh-toan", uuid);

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
                    ? "da-thanh-toan"
                    : "chua-thanh-toan";
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
        response.put("message", "Áp dụng thành công! Giảm: " + df.format(discountAmount) + " đ");
        return ResponseEntity.ok(response);
    }
}
