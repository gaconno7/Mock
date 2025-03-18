package com.mock.taka.admin.service;


import com.mock.taka.admin.repository.OrderDetailRepository;
import com.mock.taka.domain.OrderDetail;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderDetailService {
    private OrderDetailRepository orderDetailRepository;
    public OrderDetailService(OrderDetailRepository repository) {
        this.orderDetailRepository = repository;
    }
    public List<OrderDetail> findAll() {
        return this.orderDetailRepository.findAll();
    }


}
