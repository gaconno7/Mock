package com.mock.taka.repository;


import java.util.List;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.Store;

@Repository
public interface ProductRepository extends JpaRepository<Product, String>, JpaSpecificationExecutor<Product> {
    List<Product> findByDeletedFalse();
    List<Product> findByStoreAndDeletedFalse(Store store);
  
    default Specification<Product> notDeleted() {
        return (root, query, criteriaBuilder) -> 
            criteriaBuilder.isFalse(root.get("deleted"));
    }
}
