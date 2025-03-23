package com.mock.taka.controller.store;

import com.mock.taka.domain.Order;
import com.mock.taka.domain.User;
import com.mock.taka.service.client.*;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/store/order")
@RequiredArgsConstructor
@FieldDefaults(level= AccessLevel.PRIVATE, makeFinal = true)
public class StoreOrderController {
    OrderService orderService;
    @GetMapping("/history")
    public String showOrderView(ModelMap modelMap, HttpSession session) {
        List<Order> orders = (List<Order>) session.getAttribute("filteredOrders");
        if (orders == null) {
            orders = orderService.findAllByStoreId(((User) session.getAttribute("user")).getStore().getId());
        }
        modelMap.addAttribute("orders", orders);
        session.removeAttribute("filteredOrders");
        return "store/order-history";
    }

    @GetMapping("/history/{status}")
    public String showOrderViewWithStatus(@PathVariable(name = "status") String status,
                                          HttpSession session) {
        User user = (User) session.getAttribute("user");
        List<Order> orders = orderService.findAllByUserIdAndStatus(user.getId(), status);
        session.setAttribute("filteredOrders", orders);
        return "redirect:/store/order/history";
    }


    @PutMapping("/process/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, String>> processOrder(@PathVariable(name = "id") String id) {
        orderService.saveStatus(id, "van-chuyen");
        Map<String, String> message = new HashMap<>();
        message.put("message", "Cập nhật thành công");
        return ResponseEntity.ok(message);
    }
}
