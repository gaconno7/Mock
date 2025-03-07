package com.mock.taka.controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.mock.taka.service.CategoryService;
import com.mock.taka.service.ProductService;
import com.mock.taka.service.UserService;
import com.mock.taka.service.impl.CloudinaryService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@Controller
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
@RequestMapping("/product")
public class ProductController {

    ProductService productService;
    CategoryService categoryService;
    Cloudinary cloudinaryConfig;

    @GetMapping("/{id}")
    public String getDetail(ModelMap modelMap, @PathVariable(name = "id") String id) {
        modelMap.addAttribute("product", productService.findById(id));
        return "client/product-detail";
    }



}
