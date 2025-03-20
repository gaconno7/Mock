package com.mock.taka.controller.client;

import com.mock.taka.domain.Order;
import com.mock.taka.domain.User;
import com.mock.taka.service.client.OrderService;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/user/order")
@RequiredArgsConstructor
@FieldDefaults(level= AccessLevel.PRIVATE, makeFinal = true)
public class ClientOrderController {

    OrderService orderService;

    @GetMapping("/history")
    public String showOrderView(ModelMap modelMap, HttpSession session) {
        List<Order> orders = (List<Order>) session.getAttribute("filteredOrders");
        if (orders == null) {
            orders = orderService.findAllByUserId(((User) session.getAttribute("user")).getId());
        }
        modelMap.addAttribute("orders", orders);
        session.removeAttribute("filteredOrders");
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
        return "client/order-detail";
    }


}
