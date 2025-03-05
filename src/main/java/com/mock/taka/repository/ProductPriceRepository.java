package com.mock.taka.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.ProductPrice;

@Repository
public interface ProductPriceRepository extends JpaRepository<ProductPrice, String>{

}
