package com.mock.taka.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.Product;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, String>{

    @Query("SELECT p FROM Product p order by p.createdDate desc limit 5")
    List<Product> findTopProductsByCreatedDate();

    @Query("SELECT p FROM Product p " +
            "JOIN OrderDetail od ON p.id = od.product.id " +
            "GROUP BY p.id " +
            "HAVING SUM(od.amount) IS NOT NULL " +
            "ORDER BY SUM(od.amount) DESC")
    List<Product> findTopSellingProducts();

    @Query("SELECT p FROM Product p WHERE p.name LIKE CONCAT('%', :keyword, '%') AND p.id <> :productId")
    List<Product> findRelatedProductsByName(@Param("keyword") String keyword, @Param("productId") String productId);

}
