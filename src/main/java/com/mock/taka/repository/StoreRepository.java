package com.mock.taka.repository;
import java.util.List;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.Store;

@Repository
public interface StoreRepository extends JpaRepository<Store, String>, JpaSpecificationExecutor<Store> {
  List<Store> findByDeletedFalse();
    
    // Specification để lọc các cửa hàng chưa bị xóa
    default Specification<Store> notDeleted() {
        return (root, query, criteriaBuilder) -> 
            criteriaBuilder.isFalse(root.get("deleted"));
    }
}
