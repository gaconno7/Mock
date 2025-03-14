package com.mock.taka.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.mock.taka.domain.Category;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.Store;
import com.mock.taka.repository.ProductRepository;
@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }
    public Product createProduct(Product pr) {
        return this.productRepository.save(pr);
    }


    public Optional<Product> fetchProductById(String id) {
        return this.productRepository.findById(id);
    }

    public void deleteProduct(String id) {
        Optional<Product> productOptional = productRepository.findById(id);
        productOptional.ifPresent(product -> {
            product.setDeleted(true);
            productRepository.save(product);
        });
    }
    public List<Product> fetchProducts() {
        return productRepository.findByDeletedFalse();
    }
    public List<Product> findByStoreAndIsDeletedFalse(Store store) {
        return productRepository.findByStoreAndDeletedFalse(store);
    }
    public List<Product> findByCategoryAndDeletedFalse(Category category) {
        return productRepository.findByCategoryAndDeletedFalse(category);
    }
    public List<Product> findByStoreAndCategoryAndDeletedFalse(Store store, Category category) {
        return productRepository.findByStoreAndCategoryAndDeletedFalse(store, category);
    }
    public List<Category> findCategoriesByStore(Store store) {
    List<Product> products = findByStoreAndIsDeletedFalse(store);
    return products.stream()
            .map(Product::getCategory)
            .distinct()
            .collect(Collectors.toList());
}
}
