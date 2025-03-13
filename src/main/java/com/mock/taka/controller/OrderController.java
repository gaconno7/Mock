package com.mock.taka.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mock.taka.domain.CartItem;
import com.mock.taka.domain.Order;
import com.mock.taka.domain.OrderDetail;
import com.mock.taka.domain.User;
import com.mock.taka.repository.OrderDetailRepository;
import com.mock.taka.repository.OrderRepository;
import com.mock.taka.service.CartService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private CartService cartService;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @GetMapping("/process")
    public String checkout(Model model, HttpSession session) {
        List<String> selectedItems = (List<String>) session.getAttribute("selectedItems");

        if (selectedItems == null || selectedItems.isEmpty()) {
            return "redirect:/cart"; // Nếu không có sản phẩm, quay lại giỏ hàng
        }

        // Lấy danh sách sản phẩm dựa trên ID
        List<CartItem> cartItems = cartService.getCartItemsByIds(selectedItems);

        User user = (User) session.getAttribute("user");

        // Lưu vào DB (Orders & OrderDetails)
        Order order = new Order();
        order.setUser(user);
        order.setStatus("pending");
        order.setOrderDate(new Date());
        // orderRepository.save(order);

        double totalPrice = 0.0;

        for (CartItem item : cartItems) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            orderDetail.setProduct(item.getProduct());
            orderDetail.setAmount(item.getQuantity());
            orderDetail.setStatus("active");
            // orderDetailRepository.save(orderDetail);

            // Tính tổng tiền
            totalPrice += item.getProduct().getPrice() * item.getQuantity();
        }

        // Gửi dữ liệu tới trang checkout.jsp
        model.addAttribute("cartItems", cartItems); 
        model.addAttribute("order", order);
        model.addAttribute("totalPrice", totalPrice); // Thêm tổng tiền

        return "client/checkout";
    }




}

