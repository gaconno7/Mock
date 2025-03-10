package com.mock.taka.repository.dao;

import com.mock.taka.domain.Category;
import com.mock.taka.domain.Evaluation;
import com.mock.taka.domain.OrderDetail;
import com.mock.taka.domain.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.*;
import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ProductDAO {

    @PersistenceContext
    EntityManager em;

    public ProductDAO(EntityManager em) {
        this.em = em;
    }

//    public List<Product> findProductByFilter(int pageSize, int pageNum, String categoryId, double minPrice, double maxPrice, String sortBy, String searchValue) {
//        CriteriaBuilder cb = em.getCriteriaBuilder();
//        CriteriaQuery<Product> cq = cb.createQuery(Product.class);
//        Root<Product> productRoot = cq.from(Product.class);
//        List<Predicate> predicates = new ArrayList<>();
//
//        // Add predicate for non-deleted products
////        predicates.add(cb.equal(productRoot.get("deleted"), false));
////
//        if (categoryId != null) {
//            predicates.add(cb.equal(productRoot.get("category").get("id"), categoryId));
//        }
////
////        // Uncomment and fix price filter
////        if (minPrice >= 0 && maxPrice > 0) {
////            Join<Product, ProductPrice> priceJoin = productRoot.join("price", JoinType.INNER);
////            predicates.add(cb.greaterThanOrEqualTo(priceJoin.get("value"), minPrice));
////            predicates.add(cb.lessThanOrEqualTo(priceJoin.get("value"), maxPrice));
////        }
////
////        // Ensure the group by clause for aggregation functions
////        if (sortBy != null) {
////            switch (sortBy) {
////                case "latest":
////                    cq.orderBy(cb.desc(productRoot.get("createdDate")));
////                    break;
////                case "popularity":
////                    Join<Product, OrderDetail> orderJoin = productRoot.join("orderDetails", JoinType.LEFT);
////                    cq.groupBy(productRoot.get("id"));
////                    cq.orderBy(cb.desc(cb.count(orderJoin.get("id"))));
////                    break;
////                case "best-rating":
////                    Join<Product, Evaluation> evaluationJoin = productRoot.join("evaluations", JoinType.LEFT);
////                    cq.groupBy(productRoot.get("id"));
////                    cq.orderBy(cb.desc(cb.avg(evaluationJoin.get("value"))));
////                    break;
////                default:
////                    break;
////            }
////        }
////
////        if (searchValue != null && !searchValue.trim().isEmpty()) {
////            predicates.add(cb.like(cb.lower(productRoot.get("name")), "%" + searchValue.toLowerCase() + "%"));
////        }
//
//        cq.where(predicates.toArray(new Predicate[0]));
//
//        TypedQuery<Product> query = em.createQuery(cq);
//        query.setFirstResult((pageNum - 1) * pageSize);
//        query.setMaxResults(pageSize);
//
//        return query.getResultList();
//    }

    public Page<Product> findProductByFilter(int pageSize, int pageNum, String categoryId,
                                             double minPrice, double maxPrice, String sortBy,
                                             String searchValue) {
        CriteriaBuilder cb = em.getCriteriaBuilder();

        /** ========== Tạo query chính ========= */
        CriteriaQuery<Product> cq = cb.createQuery(Product.class);
        Root<Product> productRoot = cq.from(Product.class);
        Join<Product, Category> categoryJoin = productRoot.join("category", JoinType.LEFT);

        List<Predicate> predicates = new ArrayList<>();
        predicates.add(cb.equal(productRoot.get("deleted"), false));

        if (categoryId != null) {
            predicates.add(cb.equal(categoryJoin.get("id"), categoryId));
        }

        if (minPrice >= 0 && maxPrice > 0) {
            predicates.add(cb.between(productRoot.get("price"), minPrice, maxPrice));
        }

        if (searchValue != null && !searchValue.trim().isEmpty()) {
            predicates.add(cb.like(cb.lower(productRoot.get("name")), "%" + searchValue.toLowerCase() + "%"));
        }

        cq.where(predicates.toArray(new Predicate[0]));

        // Sắp xếp theo tiêu chí được chọn
        if (sortBy != null) {
            if (sortBy.equals("latest")) {
                cq.orderBy(cb.desc(productRoot.get("createdDate")));
            } else if (sortBy.equals("popularity")) {
                Subquery<Long> orderCountQuery = cq.subquery(Long.class);
                Root<Product> subRoot = orderCountQuery.from(Product.class);
                Join<Product, OrderDetail> subJoin = subRoot.join("orderDetails", JoinType.LEFT);
                orderCountQuery.select(cb.count(subJoin.get("id"))).where(cb.equal(subRoot, productRoot));

                cq.orderBy(cb.desc(orderCountQuery.getSelection()));
            } else if (sortBy.equals("best-rating")) {
                Subquery<Double> avgRatingQuery = cq.subquery(Double.class);
                Root<Product> subRoot = avgRatingQuery.from(Product.class);
                Join<Product, Evaluation> subJoin = subRoot.join("evaluations", JoinType.LEFT);
                avgRatingQuery.select(cb.avg(subJoin.get("value"))).where(cb.equal(subRoot, productRoot));

                cq.orderBy(cb.desc(avgRatingQuery.getSelection()));
            }
        }

        TypedQuery<Product> query = em.createQuery(cq);
        query.setFirstResult((pageNum - 1) * pageSize);
        query.setMaxResults(pageSize);
        List<Product> results = query.getResultList();

        /** ========== Query đếm số lượng ========= */
        CriteriaQuery<Long> countQuery = cb.createQuery(Long.class);
        Root<Product> countRoot = countQuery.from(Product.class);

        // Tạo một danh sách Predicate riêng biệt để tránh lỗi
        List<Predicate> countPredicates = new ArrayList<>();
        countPredicates.add(cb.equal(countRoot.get("deleted"), false));

        if (categoryId != null) {
            countPredicates.add(cb.equal(countRoot.get("category").get("id"), categoryId));
        }

        if (minPrice >= 0 && maxPrice > 0) {
            countPredicates.add(cb.between(countRoot.get("price"), minPrice, maxPrice));
        }

        if (searchValue != null && !searchValue.trim().isEmpty()) {
            countPredicates.add(cb.like(cb.lower(countRoot.get("name")), "%" + searchValue.toLowerCase() + "%"));
        }

        countQuery.select(cb.count(countRoot)).where(countPredicates.toArray(new Predicate[0]));

        Long totalElements = em.createQuery(countQuery).getSingleResult();

        return new PageImpl<>(results, PageRequest.of(pageNum - 1, pageSize), totalElements);
    }

}

