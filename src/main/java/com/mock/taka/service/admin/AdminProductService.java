package com.mock.taka.service.admin;

import com.mock.taka.domain.Category;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.Store;

import java.util.List;
import java.util.Optional;

public interface AdminProductService {
    Product createProduct(Product pr);
    Optional<Product> fetchProductById(String id);
    void deleteProduct(String id);
    List<Product> getProductDeleted();
    List<Product> getProductDeletedByStoreId(String storeId);
    List<Product> fetchProducts();
    List<Product> fetchProductsByStoreId( String storeId);
    List<Product> fetchProductsByStoreIdAndCategoryId(String storeId, String categoryId);
    List<Product> findByStoreAndIsDeletedFalse(Store store);
    List<Product> findByCategoryAndDeletedFalse(Category category);
    List<Product> findByStoreId(String storeId);
    List<Product> findByStoreAndCategoryAndDeletedFalse(Store store, Category category);
    List<Category> findCategoriesByStore(Store store);
    long getCountProduct();

}
