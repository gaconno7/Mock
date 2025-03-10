package com.mock.taka.controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.mock.taka.domain.Evaluation;
import com.mock.taka.domain.Product;
import com.mock.taka.service.CategoryService;
import com.mock.taka.service.EvaluationService;
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
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
@RequestMapping("/product")
public class ProductController {

    ProductService productService;
    CategoryService categoryService;
    EvaluationService evaluationService;

    @GetMapping("/{id}")
    public String getDetail(ModelMap modelMap, @PathVariable(name = "id") String id) {
        Product product = productService.findById(id);
        List<Evaluation> evaluations = evaluationService.findAllByProductId(id);

        modelMap.addAttribute("product", product);
        modelMap.addAttribute("relatedProducts", productService.findRelatedProductsByName(product.getName(), product.getId()));
        modelMap.addAttribute("evaluations", evaluations);
        modelMap.addAttribute("countEvaluation", CollectionUtils.isEmpty(evaluations) ? 0 : evaluations.size());
        modelMap.addAttribute("averageRate", CollectionUtils.isEmpty(evaluations) ? 0 : evaluations.stream().map(Evaluation::getRate)
                .reduce(0, Integer::sum) * 1.0 / evaluations.size());
        modelMap.addAttribute("countRate1", evaluationService.countByRate(1, id)) ;
        modelMap.addAttribute("countRate2", evaluationService.countByRate(2, id));
        modelMap.addAttribute("countRate3", evaluationService.countByRate(3, id));
        modelMap.addAttribute("countRate4", evaluationService.countByRate(4, id));
        modelMap.addAttribute("countRate5", evaluationService.countByRate(5, id));
        return "client/product-detail";
    }

    @GetMapping("/all")
    public String getAllProduct(ModelMap modelMap) {
        modelMap.addAttribute("categories", categoryService.findAll());;
        return "client/product-item";
    }

}
