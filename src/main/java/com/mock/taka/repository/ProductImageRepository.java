package com.mock.taka.repository;

import com.mock.taka.domain.Product;
import com.mock.taka.domain.ProductImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductImageRepository extends JpaRepository<ProductImage, String> {
    List<ProductImage> findByProduct(Product product);
}