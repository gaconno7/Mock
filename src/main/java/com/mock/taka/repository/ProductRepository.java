package com.mock.taka.repository;

import com.mock.taka.domain.Category;
import com.mock.taka.domain.Store;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.Product;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, String>, JpaSpecificationExecutor<Product> {

    @Query("select distinct p from Product p " +
            "left join Evaluation e on e.product = p " +
            "where p.deleted = false order by p.createdDate desc limit 5")
    List<Product> findTopProductsByCreatedDate();

    @Query("SELECT p FROM Product p " +
            "JOIN OrderDetail od ON p.id = od.product.id " +
            "WHERE p.deleted = false " +
            "GROUP BY p.id " +
            "HAVING SUM(od.amount) IS NOT NULL " +
            "ORDER BY SUM(od.amount) DESC")
    List<Product> findTopSellingProducts();

    @Query("SELECT p FROM Product p " +
            "JOIN Evaluation e ON e.product = p " +
            "WHERE p.name LIKE CONCAT('%', :keyword, '%') " +
            "AND p.id <> :productId AND p.deleted = false ")
    List<Product> findRelatedProductsByName(@Param("keyword") String keyword, @Param("productId") String productId, Pageable pageable);

    @Query("SELECT p FROM Product p LEFT JOIN FETCH p.evaluations " +
            "WHERE p.id = :productId AND p.deleted = false ")
    Optional<Product> findProductById(@Param("productId") String productId);


    @Query("SELECT p " +
            "FROM Product p " +
            "ORDER BY p.discountPrice desc " +
            "LIMIT 1")
    Product findByDiscountMax();

    Page<Product> findByStoreIdAndNameLike(String storeId ,String name, Pageable pageable);

    List<Product> findByDeletedFalse();
    List<Product> findByStoreId(String id);
    List<Product> findByStoreAndDeletedFalse(Store store);
    List<Product> findByCategoryAndDeletedFalse(Category category);
    List<Product> findByStoreAndCategoryAndDeletedFalse(Store store, Category category);
    Long countProductByDeletedIsFalse();

    List<Product> findByDeletedTrue();
    default Specification<Product> notDeleted() {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.isFalse(root.get("deleted"));
    }

}
