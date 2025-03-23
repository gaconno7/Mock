package com.mock.taka.repository;

import com.mock.taka.domain.OrderDetail;
import com.mock.taka.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, String> {
    List<OrderDetail> findAllByOrderId(String orderId);
    boolean existsByProductIdAndOrderUserId(String productId, long userId);
    List<OrderDetail> getOrderDetailByOrderId(String id);

    @Query("SELECT od.order.id FROM OrderDetail od INNER JOIN Product p ON od.product = p WHERE p.store.id = :storeId")
    List<String> findOrderIdByProductStoreId(@Param("storeId") String storeId);
}
