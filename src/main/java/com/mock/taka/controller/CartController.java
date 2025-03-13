package com.mock.taka.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mock.taka.domain.CartItem;
import com.mock.taka.domain.User;
import com.mock.taka.service.CartService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user/cart")
public class CartController {
    @Autowired
    private CartService cartService;

    @GetMapping
    public String getCart(Model model, HttpSession httpSession) {
        User user = (User)httpSession.getAttribute("user");
        model.addAttribute("cartItems", cartService.getCartItems(user.getId()));
        model.addAttribute("totalCartPrice", cartService.calculateTotalCartPrice(user.getId()));
        return "client/cart/cart";
    }

    // @PostMapping("/update")
    // public String updateCartItem(@RequestParam String cartItemId, @RequestParam int quantity, Model model, HttpSession httpSession) {
    //     User user = (User)httpSession.getAttribute("user");
    //     model.addAttribute("cartItems", cartService.getCartItems(user.getId()));
    //     model.addAttribute("totalCartPrice", cartService.calculateTotalCartPrice());
    //     return "client/cart/cart";
    // }

    // @PostMapping("/remove")
    // public String removeCartItem(@RequestParam String cartItemId, Model model, HttpSession httpSession) {
    //     User user = (User)httpSession.getAttribute("user");
    //     model.addAttribute("cartItems", cartService.getCartItems(user.getId()));
    //     model.addAttribute("totalCartPrice", cartService.calculateTotalCartPrice());
    //     return "client/cart/cart";
    // }

    // @PostMapping("/update")
    // @ResponseBody
    // public ResponseEntity<Map<String, Object>> updateCartItem(
    //         @RequestParam String cartItemId, 
    //         @RequestParam int quantity, 
    //         HttpSession session) {

    //     User user = (User) session.getAttribute("user");
    //     if (user == null) {
    //         return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
    //     }

    //     // Cập nhật giỏ hàng
    //     boolean updated = cartService.updateCartItem(cartItemId, quantity);
    //     if (!updated) {
    //         return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
    //     }

    //     // Tạo phản hồi JSON
    //     Map<String, Object> response = new HashMap<>();
    //     response.put("quantity", quantity);
    //     response.put("subtotal", cartService.calculateTotalCartPrice(user.getId()));
    //     response.put("totalCartPrice", cartService.calculateTotalCartPrice(user.getId()));

    //     return ResponseEntity.ok(response);
    // }


    // @PostMapping("/remove")
    // @ResponseBody
    // public Map<String, Object> removeCartItem(@RequestParam String cartItemId, HttpSession session) {
    //     User user = (User) session.getAttribute("user");
    //     cartService.removeCartItem(cartItemId);

    //     Map<String, Object> response = new HashMap<>();
    //     response.put("totalCartPrice", cartService.calculateTotalCartPrice(user.getId()));

    //     return response;
    // }

    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateCartItem(
            @RequestParam String cartItemId, 
            @RequestParam int quantity, 
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        boolean updated = cartService.updateCartItem(cartItemId, quantity);
        if (!updated) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("quantity", quantity);
        // response.put("subtotal", cartService.calculateTotalCartPrice(user.getId()));
        response.put("totalCartPrice", cartService.calculateTotalCartPrice(user.getId()));

        return ResponseEntity.ok(response);
    }

    @PostMapping("/remove")
    @ResponseBody
    public ResponseEntity<String> removeCartItem(@RequestParam String cartItemId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Chưa đăng nhập!");
        }

        boolean removed = cartService.removeCartItem(cartItemId);
        if (!removed) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Không tìm thấy sản phẩm trong giỏ hàng!");
        }

        return ResponseEntity.ok("Sản phẩm đã bị xóa!");
    }


    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addToCart(
            @RequestParam String productId,
            @RequestParam(required = false) String productVariantId,
            @RequestParam int quantity,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        boolean added = cartService.addToCart(user, productId, productVariantId, quantity);
        if (!added) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("message", "Thêm vào giỏ hàng thành công!");
        response.put("totalCartPrice", cartService.calculateTotalCartPrice(user.getId()));

        return ResponseEntity.ok(response);
    }

    @PostMapping("/updateTotal")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateTotal(@RequestParam("selectedItems") String selectedItems) {
        // Chuyển chuỗi "1,2,3" thành danh sách Long
        List<String> selectedItemIds = Arrays.stream(selectedItems.split(","))
                .map(String::trim) // Loại bỏ khoảng trắng nếu có
                .filter(id -> !id.isEmpty()) // Lọc ra các phần tử rỗng
                .collect(Collectors.toList());

        // Lấy danh sách sản phẩm theo ID
        List<CartItem> selectedCartItems = cartService.getCartItemsByIds(selectedItemIds);
        System.out.println("===========================================");
        System.out.println(selectedItems);

        // Tính tổng tiền
        double totalSelectedCartPrice = selectedCartItems.stream()
                .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                .sum();

        Map<String, Object> response = new HashMap<>();
        response.put("totalSelectedCartPrice", totalSelectedCartPrice);
        System.out.println("========================");
        System.out.println(totalSelectedCartPrice);

        return ResponseEntity.ok(response);
    }


    @PostMapping("/proceedToCheckout")
    public ResponseEntity<String> proceedToCheckout(@RequestBody Map<String, List<String>> payload, HttpSession session) {
        List<String> selectedItems = payload.get("selectedItems");

        if (selectedItems == null || selectedItems.isEmpty()) {
            return ResponseEntity.badRequest().body("Không có sản phẩm nào được chọn.");
        }

        // Lưu danh sách ID sản phẩm vào session để sử dụng trong CheckoutController
        session.setAttribute("selectedItems", selectedItems);

        return ResponseEntity.ok("Chuyển sang trang thanh toán");
    }



}
