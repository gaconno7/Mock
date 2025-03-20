package com.mock.taka.service.client;

import com.mock.taka.domain.Order;

import java.util.List;

public interface OrderService {
    List<Order> findAllByUserId(long id);
    List<Order> findAllByUserIdAndStatus(long id, String status);
    Order findById(String id);
    Order saveStatus(String id, String status);
}
