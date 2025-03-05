package com.mock.taka.controller;

import com.mock.taka.service.CategoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Controller
@RequestMapping("/home")
@RequiredArgsConstructor
@FieldDefaults(level=AccessLevel.PRIVATE, makeFinal = true)
public class HomeController {

    CategoryService categoryService;

    @GetMapping
    public String index(ModelMap modelMap) {
        modelMap.addAttribute("categories", categoryService.findAll());
        return "/client/index";
    }


}
