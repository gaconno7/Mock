package com.mock.taka.controller;

import com.mock.taka.domain.Product;
import com.mock.taka.service.CategoryService;
import com.mock.taka.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Controller
@RequestMapping("/home")
@RequiredArgsConstructor
@FieldDefaults(level=AccessLevel.PRIVATE, makeFinal = true)
public class HomeController {

    CategoryService categoryService;
    ProductService productService;

    @GetMapping
    public String index(ModelMap modelMap) {
        modelMap.addAttribute("categories", categoryService.findAll());
        modelMap.addAttribute("listSellingProducts", productService.findTopSellingProducts());
        modelMap.addAttribute("listTopProductByCreatedDate", productService.findTopProductsByCreatedDate());
        return "client/index";
    }


}
