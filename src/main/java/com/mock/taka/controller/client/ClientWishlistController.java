package com.mock.taka.controller.client;

import com.mock.taka.service.client.ProductService;
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
public class ClientWishlistController {

    ProductService productService;
    @GetMapping
    public String showView(ModelMap modelMap) {
        modelMap.addAttribute("newProducts", productService.findTopProductsByCreatedDate());
        return "client/wishlist";
    }
}
