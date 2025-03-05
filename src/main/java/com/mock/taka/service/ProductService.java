package com.mock.taka.service;

import com.mock.taka.domain.Product;

import java.util.List;

public interface ProductService {
    List<Product> findTopProductByCreatedDate();
    Product findById(String id);
}
