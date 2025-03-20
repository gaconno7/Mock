package com.mock.taka.service.client.impl;

import com.mock.taka.domain.Order;
import com.mock.taka.repository.OrderRepository;
import com.mock.taka.service.client.OrderService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class OrderServiceImpl implements OrderService {

    OrderRepository orderRepository;

    @Override
    public List<Order> findAllByUserIdAndStatus(long id, String status) {
        return orderRepository.findByUserIdAndStatus(id, status);
    }

    @Override
    public Order findById(String id) {
        return orderRepository.findById(id).orElse(null);
    }

    @Override
    public Order saveStatus(String id, String status) {
        var order = orderRepository.findById(id).orElse(null);
        if(Objects.isNull(order)) return null;
        order.setStatus(status);
        return orderRepository.save(order);
    }

    @Override
    public List<Order> findAllByUserId(long id) {
        return orderRepository.findByUserId(id);
    }
}
