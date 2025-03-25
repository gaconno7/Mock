package com.mock.taka.controller.client;

import com.mock.taka.domain.Evaluation;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.User;
import com.mock.taka.service.client.CategoryService;
import com.mock.taka.service.client.EvaluationService;
import com.mock.taka.service.client.OrderDetailService;
import com.mock.taka.service.client.ProductService;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

@Controller
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
@RequestMapping("/product")
public class ClientProductController {

    ProductService productService;
    CategoryService categoryService;
    EvaluationService evaluationService;
    OrderDetailService orderDetailService;

    @GetMapping("/{id-product}")
    public String getDetail(ModelMap modelMap, @PathVariable(name = "id-product") String id, HttpSession session) {
        Product product = productService.findById(id);
        List<Evaluation> evaluations = evaluationService.findAllByProductId(id);
        var user = (User) session.getAttribute("user");

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
        modelMap.addAttribute("isOrder", orderDetailService.existsByProductIdAndOrderUserId(product.getId(), Objects.isNull(user) ? 0 : user.getId()));
        return "client/product-detail";
    }

    @GetMapping("/all")
    public String getAllProduct(ModelMap modelMap) {
        modelMap.addAttribute("categories", categoryService.findAll());
        return "client/product-item";
    }

}
