package com.mock.taka.controller.admin;

import com.mock.taka.domain.Order;
import com.mock.taka.domain.OrderDetail;
import com.mock.taka.service.admin.AdminOrderDetailService;
import com.mock.taka.service.admin.AdminOrderService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AdminOrderController {
    AdminOrderService orderService;
    AdminOrderDetailService orderDetailService;
  
    @GetMapping("/admin/order")
    public String getOrder(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "order");
        List<Order> ords = orderService.fetchAllOrder();
        model.addAttribute("order", ords);
        return "admin/order/show";
    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "order");
        List<OrderDetail> orddetail = orderDetailService.fetchOrderDetail(id);
        model.addAttribute("orddetail", orddetail);
        model.addAttribute("id", id);
        return "admin/order/detail";
    }

    @GetMapping("/admin/order/delete/{id}")
    public String getDeleteOrdPage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "order");
        model.addAttribute("id", id);
        model.addAttribute("newOrder", new Order());
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    public String postDeleteOrdPage(@ModelAttribute("newOrder") Order order, HttpServletRequest active) {
        active.setAttribute("activePage", "order");
        orderService.deleteOrderById(order.getId());
        return "redirect:/admin/order";
    }
} 
