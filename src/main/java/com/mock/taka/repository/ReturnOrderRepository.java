package com.mock.taka.repository;

import com.mock.taka.domain.ReturnOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ReturnOrderRepository extends JpaRepository<ReturnOrder, String> {
        Optional<ReturnOrder> findByOrderId(String orderId);
}
