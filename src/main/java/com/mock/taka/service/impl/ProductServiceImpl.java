package com.mock.taka.service.impl;

import com.mock.taka.domain.Product;
import com.mock.taka.repository.ProductRepository;
import com.mock.taka.service.ProductService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    ProductRepository productRepository;

    @Override
    public List<Product> findTopProductByCreatedDate() {
        return productRepository.findTopProductsByCreatedDate();
    }

    @Override
    public Product findById(String id) {
        return productRepository.findById(id).orElse(null);
    }
}
