package com.mock.taka.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.ProductImage;

@Repository
public interface ProductImageRepository extends JpaRepository<ProductImage, String>{

}
