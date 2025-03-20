package com.mock.taka.controller.client;

import com.mock.taka.service.client.CategoryService;
import com.mock.taka.service.client.ProductService;
import com.mock.taka.service.store.StoreService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level=AccessLevel.PRIVATE, makeFinal = true)
public class ClientHomeController {

    CategoryService categoryService;
    ProductService productService;
    StoreService storeService;

    @GetMapping({"/home", "/"})
    public String index(ModelMap modelMap) {
        modelMap.addAttribute("categories", categoryService.findAll());
        modelMap.addAttribute("product", productService.findByDiscountMax());
        modelMap.addAttribute("listSellingProducts", productService.findTopSellingProducts());
        modelMap.addAttribute("listTopProductByCreatedDate", productService.findTopProductsByCreatedDate());
        return "client/index";
    }
    @GetMapping("/over-view-store/{id}")
    public String showOverView( ModelMap modelMap,
                               @PathVariable(name = "id") String id) {
        modelMap.addAttribute("store", storeService.fetchStoreById(id).orElse(null));
        return "client/over-view-store";
    }

}
