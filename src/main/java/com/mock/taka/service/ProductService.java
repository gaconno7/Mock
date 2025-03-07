package com.mock.taka.service;

import com.mock.taka.domain.Product;

import java.util.List;

public interface ProductService {
    List<Product> findTopProductsByCreatedDate();

    List<Product> findTopSellingProducts();

    Product findById(String id);
}
