package com.mock.taka.repository.dao;

import com.mock.taka.domain.Evaluation;
import com.mock.taka.domain.OrderDetail;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.ProductPrice;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.*;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class EvaluationDAO {

    @PersistenceContext
    EntityManager em;

    public EvaluationDAO(EntityManager em) {
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

    // Phương thức đơn giản để kiểm tra dữ liệu có tồn tại không
    public List<Product> findProductByFilter(int pageSize, int pageNum, String categoryId, double minPrice, double maxPrice, String sortBy, String searchValue) {
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Product> cq = cb.createQuery(Product.class);
        Root<Product> productRoot = cq.from(Product.class);

        // Eager fetch related entities to avoid lazy loading issues
        productRoot.fetch("category", JoinType.LEFT);
        productRoot.fetch("price", JoinType.LEFT);

        List<Predicate> predicates = new ArrayList<>();

        // Add predicate for non-deleted products
        predicates.add(cb.equal(productRoot.get("deleted"), false));

        if (categoryId != null) {
            predicates.add(cb.equal(productRoot.get("category").get("id"), categoryId));
        }
//
//        if (minPrice >= 0 && maxPrice > 0) {
//            // Use path instead of join for filtering on price
//            predicates.add(cb.greaterThanOrEqualTo(productRoot.get("price").get("value"), minPrice));
//            predicates.add(cb.lessThanOrEqualTo(productRoot.get("price").get("value"), maxPrice));
//        }

        // Handle ordering separately from fetching to avoid cartesian products
        if (sortBy != null) {
            switch (sortBy) {
                case "latest":
                    cq.orderBy(cb.desc(productRoot.get("createdDate")));
                    break;
                case "popularity":
                    Expression<Long> orderCount = cb.count(productRoot.join("orderDetails", JoinType.LEFT).get("id"));
                    cq.groupBy(productRoot);
                    cq.orderBy(cb.desc(orderCount));
                    break;
                case "best-rating":
                    Expression<Double> avgRating = cb.avg(productRoot.join("evaluations", JoinType.LEFT).get("value"));
                    cq.groupBy(productRoot);
                    cq.orderBy(cb.desc(avgRating));
                    break;
                default:
                    break;
            }
        }

        if (searchValue != null && !searchValue.trim().isEmpty()) {
            predicates.add(cb.like(cb.lower(productRoot.get("name")), "%%" + searchValue.toLowerCase() + "%%"));
        }

        cq.where(predicates.toArray(new Predicate[0]));
        cq.distinct(true); // Avoid duplicates from multiple joins

        TypedQuery<Product> query = em.createQuery(cq);
        query.setFirstResult((pageNum - 1) * pageSize);
        query.setMaxResults(pageSize);

        List<Product> results = query.getResultList();

        // For debugging: Print the IDs of returned products
        System.out.println("Found " + results.size() + " products");
        for (Product p : results) {
            System.out.println("Product ID: " + p.getId() + ", Name: " + p.getName());
        }

        return results;
    }
}

