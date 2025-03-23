package com.mock.taka.repository.dao;

import com.mock.taka.domain.Evaluation;
import com.mock.taka.domain.Order;
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
import java.util.Date;
import java.util.List;

@Repository
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OrderDAO {

    @PersistenceContext
    EntityManager em;

    public OrderDAO(EntityManager em) {
        this.em = em;
    }

    public Page<Order> findOrderByFilter(int pageSize, int pageNum, 
                                             String status, Date orderDate, String searchValue, String searchType, String storeId, String userId) {
        CriteriaBuilder cb = em.getCriteriaBuilder();

        CriteriaQuery<Order> cq = cb.createQuery(Order.class);
        Root<Order> orderRoot = cq.from(Order.class);

        List<Predicate> predicates = new ArrayList<>();

        if (status != null) {
            predicates.add(cb.equal(orderRoot.get("status"), status));
        }
        if (orderDate != null) {
            predicates.add(cb.greaterThanOrEqualTo(orderRoot.get("orderDate"), orderDate));
        }
        if (storeId != null) {
            Join<Order, OrderDetail> orderDetailJoin = orderRoot.join("orderDetails");
            Join<OrderDetail, Product> productJoin = orderDetailJoin.join("product");
            predicates.add(cb.equal(productJoin.get("store").get("id"), storeId));
        }
        if(userId != null) {
            predicates.add(cb.equal(orderRoot.get("user").get("id"), userId));
        }

        if (searchType != null && searchValue != null && !searchValue.trim().isEmpty()) {
            if (searchType.equals("fullname")) {
                predicates.add(cb.like(cb.lower(orderRoot.get("user").get("fullname")), "%" + searchValue.toLowerCase() + "%"));
            } else {
                predicates.add(cb.like(cb.lower(orderRoot.get(searchType)), "%" + searchValue.toLowerCase() + "%"));
            }
        }

        cq.where(predicates.toArray(new Predicate[0]));

        TypedQuery<Order> query = em.createQuery(cq);
        query.setFirstResult((pageNum - 1) * pageSize);
        query.setMaxResults(pageSize);
        List<Order> results = query.getResultList();


        return new PageImpl<>(results, PageRequest.of(pageNum - 1, pageSize), countItem(status, orderDate, searchValue, searchType, storeId, userId));
    }

    public long countItem(String status, Date orderDate, String searchValue, String searchType, String storeId, String userId) {
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Long> countQuery = cb.createQuery(Long.class);
        Root<Order> countRoot = countQuery.from(Order.class);

        List<Predicate> predicates = new ArrayList<>();

        if (status != null) {
            predicates.add(cb.equal(countRoot.get("status"), status));
        }
        if (orderDate != null) {
            predicates.add(cb.greaterThanOrEqualTo(countRoot.get("orderDate"), orderDate));
        }
        if (storeId != null) {
            Join<Order, OrderDetail> orderDetailJoin = countRoot.join("orderDetails");
            Join<OrderDetail, Product> productJoin = orderDetailJoin.join("product");
            predicates.add(cb.equal(productJoin.get("store").get("id"), storeId));
        }
        if(userId != null) {
            predicates.add(cb.equal(countRoot.get("user").get("id"), userId));
        }

        if (searchType != null && searchValue != null && !searchValue.trim().isEmpty()) {
            if (searchType.equals("fullname")) {
                predicates.add(cb.like(cb.lower(countRoot.get("user").get("fullname")), "%" + searchValue.toLowerCase() + "%"));
            } else {
                predicates.add(cb.like(cb.lower(countRoot.get(searchType)), "%" + searchValue.toLowerCase() + "%"));
            }
        }


        countQuery.select(cb.count(countRoot)).where(predicates.toArray(new Predicate[0]));

        return em.createQuery(countQuery).getSingleResult();
    }


}

