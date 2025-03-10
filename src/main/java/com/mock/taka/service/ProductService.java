package com.mock.taka.service;

import com.mock.taka.domain.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ProductService {
    List<Product> findTopProductsByCreatedDate();

    List<Product> findTopSellingProducts();

    Product findById(String id);

    List<Product> findRelatedProductsByName(String name, String id);

    Page<Product> findProductByFilter(int pageSize, int pageNum, String categoryId,
                                                         double minPrice, double maxPrice, String sortBy,
                                                         String searchValue);
}
