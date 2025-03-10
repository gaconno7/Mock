package com.mock.taka.controller;

import com.mock.taka.domain.User;
import com.mock.taka.service.ProductService;
import com.mock.taka.service.WishlistService;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
@RequestMapping("/user/wishlist")
public class WishlistController {

    ProductService productService;
    @GetMapping
    public String showView(ModelMap modelMap) {
        modelMap.addAttribute("newProducts", productService.findTopProductsByCreatedDate());
        return "client/wishlist";
    }
}
