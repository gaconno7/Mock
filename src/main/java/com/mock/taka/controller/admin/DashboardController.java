package com.mock.taka.controller.admin;

import com.mock.taka.domain.Order;
import com.mock.taka.service.admin.AdminOrderService;
import com.mock.taka.service.admin.AdminProductService;
import com.mock.taka.service.admin.AdminUserService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class DashboardController {
    AdminUserService userService;
    AdminProductService productService;
    AdminOrderService orderService;

    @GetMapping("/admin")
    public String getHomePage(Model model, HttpServletRequest active, @RequestParam(name = "year", required = false, defaultValue = "2025") int year) {
        active.setAttribute("activePage", "admin");
        active.setAttribute("activeYear", year);

        //Dashboard
        Long totalUsers = this.userService.getCountUser();
        model.addAttribute("totalUsers", totalUsers);
        Long totalProducts = this.productService.getCountProduct();
        model.addAttribute("totalProducts", totalProducts);
        Long totalOders = this.orderService.getCountOrder();
        model.addAttribute("totalOders", totalOders);
        Double totalRevenue = this.orderService.getTotalPrice();
        model.addAttribute("totalRevenue", totalRevenue);

        //Pie chart
        Long countListAdmins = this.userService.countByRoleName("ROLE_ADMIN");
        model.addAttribute("countListAdmins", countListAdmins);
        Long countListSuppliers = this.userService.countByRoleName("ROLE_SUPPLIER");
        model.addAttribute("countListSuppliers", countListSuppliers);
        Long countListUsers = this.userService.countByRoleName("ROLE_USER");
        model.addAttribute("countListUsers", countListUsers);

        //Line chart
        ArrayList<Double> totalRevenueByMonth = new ArrayList<>();
        for (int month = 1; month <= 12; month++) {
            List<Order> listOrder = this.orderService.findOrderByMonthAndYear(month, year);
            Double revenue = (double) 0;
            for (Order order : listOrder) {
                Double totalPrice = order.getTotalPrice();
                revenue = revenue + totalPrice;
            }
            totalRevenueByMonth.add(revenue);
        }
        model.addAttribute("totalRevenueByMonth", totalRevenueByMonth);
        return "admin/dashboard/show";
    }

}

