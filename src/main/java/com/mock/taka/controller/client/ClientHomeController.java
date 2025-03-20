package com.mock.taka.controller.client;

import com.mock.taka.service.client.CategoryService;
import com.mock.taka.service.client.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Controller
@RequestMapping({"/home", "/"})
@RequiredArgsConstructor
@FieldDefaults(level=AccessLevel.PRIVATE, makeFinal = true)
public class ClientHomeController {

    CategoryService categoryService;
    ProductService productService;

    @GetMapping
    public String index(ModelMap modelMap) {
        modelMap.addAttribute("categories", categoryService.findAll());
        modelMap.addAttribute("product", productService.findByDiscountMax());
        modelMap.addAttribute("listSellingProducts", productService.findTopSellingProducts());
        modelMap.addAttribute("listTopProductByCreatedDate", productService.findTopProductsByCreatedDate());
        return "client/index";
    }


}
