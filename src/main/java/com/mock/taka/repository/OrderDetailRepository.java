package com.mock.taka.repository;

import com.mock.taka.domain.OrderDetail;
import com.mock.taka.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, String> {
    List<OrderDetail> findAllByOrderId(String orderId);
    boolean existsByProductIdAndOrderUserId(String productId, long userId);
    List<OrderDetail> getOrderDetailByOrderId(String id);
}
