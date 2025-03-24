package com.mock.taka.service.admin.impl;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import com.mock.taka.repository.ProductRepository;
import com.mock.taka.service.admin.AdminProductService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import com.mock.taka.domain.Category;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.Store;
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class AdminProductServiceImpl implements AdminProductService {
    ProductRepository productRepository;

    @Override
    public Product createProduct(Product pr) {
        return this.productRepository.save(pr);
    }

    @Override
    public Optional<Product> fetchProductById(String id) {
        return this.productRepository.findById(id);
    }

    @Override
    public void deleteProduct(String id) {
        Optional<Product> productOptional = productRepository.findById(id);
        productOptional.ifPresent(product -> {
            product.setDeleted(true);
            productRepository.save(product);
        });
    }

    @Override
    public List<Product> getProductDeleted() {
        return productRepository.findByDeletedTrue();
    }

    @Override
    public List<Product> fetchProducts() {
        return productRepository.findByDeletedFalse();
    }

    @Override
    public List<Product> findByStoreAndIsDeletedFalse(Store store) {
        return productRepository.findByStoreAndDeletedFalse(store);
    }

    @Override
    public List<Product> findByStoreId(String storeId) {
        return productRepository.findByStoreId(storeId);
    }

    @Override
    public List<Product> findByCategoryAndDeletedFalse(Category category) {
        return productRepository.findByCategoryAndDeletedFalse(category);
    }
    public List<Product> findByStoreAndCategoryAndDeletedFalse(Store store, Category category) {
        return productRepository.findByStoreAndCategoryAndDeletedFalse(store, category);
    }

    @Override
    public List<Category> findCategoriesByStore(Store store) {
        List<Product> products = findByStoreAndIsDeletedFalse(store);
        return products.stream()
                .map(Product::getCategory)
                .distinct()
                .collect(Collectors.toList());
    }

    @Override
    public long getCountProduct() {
        return this.productRepository.countProductByDeletedIsFalse();
    }
}
