package com.mock.taka.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, String> {
    Optional<Order> findByPaymentRef(String paymentRef);
}
