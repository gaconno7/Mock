package com.mock.taka.admin.service;

import com.mock.taka.admin.repository.OrderRepository;
import com.mock.taka.domain.Order;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class OrderService {

    private OrderRepository orderRepository;
    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public List<Order> findOrderByMonthAndYear(int month, int year){
        return this.orderRepository.getOrdersByMonthAndYear(month, year);
    }

    public long getCountOrder() {
        return this.orderRepository.count();
    }

    public Double getTotalPrice(){
        return this.orderRepository.getTotalPriceSum();
    }
}
