package com.mock.taka.admin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;


import com.mock.taka.admin.service.OrderDetailService;
import com.mock.taka.admin.service.OrderService;
import com.mock.taka.domain.Order;
import com.mock.taka.domain.OrderDetail;

import jakarta.servlet.http.HttpServletRequest;
@Controller
public class OrderController {
    private final OrderService orderService;
    private final OrderDetailService orderDetailService;
    public OrderController(OrderService orderService, OrderDetailService orderDetailService) {
        this.orderService = orderService;
        this.orderDetailService = orderDetailService;
   
    }
    @GetMapping("/admin/order")
    public String getOrder(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "order");
        List<Order> ords = this.orderService.fetchAllOrder();
        model.addAttribute("order", ords);
        return "admin/order/show";
    }
    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "order");
        List<OrderDetail> orddetail = this.orderDetailService.fetchOrderDetail(id);
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
        this.orderService.deleteOrderById(order.getId());
        return "redirect:/admin/order";
    }
}
