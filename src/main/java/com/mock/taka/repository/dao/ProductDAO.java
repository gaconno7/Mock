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

    public Page<Product> findProductByFilter(int pageSize, int pageNum, String categoryId,
                                             double minPrice, double maxPrice, String sortBy,
                                             String searchValue) {
        CriteriaBuilder cb = em.getCriteriaBuilder();

        CriteriaQuery<Product> cq = cb.createQuery(Product.class);
        Root<Product> productRoot = cq.from(Product.class);

        List<Predicate> predicates = new ArrayList<>();
        predicates.add(cb.equal(productRoot.get("deleted"), false));

        if (categoryId != null) {
            predicates.add(cb.equal(productRoot.get("category").get("id"), categoryId));
        }

        if (minPrice >= 0 && maxPrice > 0) {
            predicates.add(cb.between(productRoot.get("price"), minPrice, maxPrice));
        }

        if (searchValue != null && !searchValue.trim().isEmpty()) {
            predicates.add(cb.like(cb.lower(productRoot.get("name")), "%" + searchValue.toLowerCase() + "%"));
        }

        cq.where(predicates.toArray(new Predicate[0]));

        if (sortBy != null) {
            switch (sortBy) {
                case "latest":
                    cq.orderBy(cb.desc(productRoot.get("createdDate")));
                    break;
                case "cheapest":
                    cq.orderBy(cb.asc(productRoot.get("price")));
                    break;
                case "best-rating":
                    Subquery<Double> avgRatingQuery = cq.subquery(Double.class);
                    Root<Product> subRootAvg = avgRatingQuery.from(Product.class);
                    Join<Product, Evaluation> subJoinAvg = subRootAvg.join("evaluations", JoinType.LEFT);
                    avgRatingQuery.select(cb.avg(subJoinAvg.get("rate"))).where(cb.equal(subRootAvg, productRoot));
                    cq.orderBy(cb.desc(avgRatingQuery.getSelection()));
                    break;
                default:
                    break;
            }
        }

        TypedQuery<Product> query = em.createQuery(cq);
        query.setFirstResult((pageNum - 1) * pageSize);
        query.setMaxResults(pageSize);
        List<Product> results = query.getResultList();


        return new PageImpl<>(results, PageRequest.of(pageNum - 1, pageSize), countItem(categoryId, minPrice, maxPrice, searchValue));
    }

    public long countItem(String categoryId, double minPrice,
                          double maxPrice, String searchValue) {
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Long> countQuery = cb.createQuery(Long.class);
        Root<Product> countRoot = countQuery.from(Product.class);

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

        return em.createQuery(countQuery).getSingleResult();
    }


}

