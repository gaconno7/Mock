package com.mock.taka.service.admin.impl;

import com.mock.taka.domain.Order;
import com.mock.taka.domain.OrderDetail;
import com.mock.taka.domain.User;

import com.mock.taka.repository.OrderDetailRepository;
import com.mock.taka.repository.OrderRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

import com.mock.taka.service.admin.AdminOrderService;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class AdminOrderServiceImpl implements AdminOrderService{

    OrderRepository orderRepository;
    OrderDetailRepository orderDetailRepository;

    @Override
    public List<Order> findOrderByMonthAndYear(int month, int year) {
        return orderRepository.getOrdersByMonthAndYear(month, year);
    }

    @Override
    public long getCountOrder() {
        return orderRepository.count();
    }

    @Override
    public Double getTotalPrice() {
        return orderRepository.getTotalPriceSum();
    }

    @Override
    public List<Order> fetchAllOrder() {
        return orderRepository.findAll();
    }

    @Override
    public Optional<Order> fetchOrderById(String id) {
        return orderRepository.findById(id);
    }

    @Override
    public void deleteOrderById(String id) {
        Optional<Order> orderOptional = fetchOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            List<OrderDetail> orderDetails = order.getOrderDetails();
            for (OrderDetail orderDetail : orderDetails) {
                orderDetailRepository.deleteById(orderDetail.getId());
            }
            orderRepository.deleteById(id);
        }
    }

    @Override
    public void updateOrder(Order ord) {
        Optional<Order> orderOptional = fetchOrderById(ord.getId());
        if (orderOptional.isPresent()) {
            Order currentOrder = orderOptional.get();
            currentOrder.setStatus(ord.getStatus());
            orderRepository.save(currentOrder);
        }
    }

    @Override
    public List<Order> fetchOrderByUser(User user) {
        return orderRepository.findByUser(user);
    }
}
