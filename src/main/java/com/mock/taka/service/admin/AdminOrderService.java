package com.mock.taka.service.admin;

import java.util.List;
import java.util.Optional;

import com.mock.taka.domain.Order;
import com.mock.taka.domain.User;

public interface AdminOrderService {

    List<Order> findOrderByMonthAndYear(int month, int year);

    long getCountOrder();

    Double getTotalPrice();

    List<Order> fetchAllOrder();

    Optional<Order> fetchOrderById(String id);

    void updateOrder(Order ord);

    List<Order> fetchOrderByUser(User user);
    void deleteOrderById(String id);
}
