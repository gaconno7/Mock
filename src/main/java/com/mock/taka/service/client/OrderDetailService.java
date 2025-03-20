package com.mock.taka.service.client;

import com.mock.taka.domain.OrderDetail;

import java.util.List;

public interface OrderDetailService {
    List<OrderDetail> findAllByOrderId(String orderId);
    boolean existsByProductIdAndOrderUserId(String productId, long userId);
}
