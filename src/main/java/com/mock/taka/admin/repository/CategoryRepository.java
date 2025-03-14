package com.mock.taka.admin.repository;


import java.util.List;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.Category;


@Repository
public interface CategoryRepository extends JpaRepository<Category, String>, JpaSpecificationExecutor<Category> {
    List<Category> findByStatusTrue();
  
    default Specification<Category> notDeleted() {
        return (root, query, criteriaBuilder) -> 
            criteriaBuilder.isFalse(root.get("deleted"));
    }
}
