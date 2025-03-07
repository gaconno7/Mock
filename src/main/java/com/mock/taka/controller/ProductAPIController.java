package com.mock.taka.controller;

import com.mock.taka.domain.Product;
import com.mock.taka.repository.dao.EvaluationDAO;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Controller
@RequestMapping("/api/v1/products")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ProductAPIController {

    EvaluationDAO evaluationDAO;

    public ProductAPIController(EvaluationDAO evaluationDAO) {
        this.evaluationDAO = evaluationDAO;
    }

    @GetMapping("/search")
    public List<Product> filterProduct(
            @RequestParam(name = "page-size", defaultValue = "9") int pageSize,
            @RequestParam(name = "page", defaultValue = "1") int pageNum,
            @RequestParam(name = "category-id", required = false) String categoryId,
            @RequestParam(name = "min-price", defaultValue = "0") String minPrice,
            @RequestParam(name = "max-price", defaultValue = "1000000") String maxPrice,
            @RequestParam(name = "sort-by", required = false) String sortBy,
            @RequestParam(name = "search-value", required = false) String searchValue) {
        List<Product> result =  evaluationDAO.findProductByFilter(pageSize, pageNum, categoryId, Double.parseDouble(minPrice), Double.parseDouble(maxPrice), sortBy, searchValue);
        result.forEach(System.out::println);
        return result;
    }
}
