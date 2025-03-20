package com.mock.taka.service.client.impl;

import com.mock.taka.domain.OrderDetail;
import com.mock.taka.repository.OrderDetailRepository;
import com.mock.taka.service.client.OrderDetailService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OrderDetailServiceImpl implements OrderDetailService {

    OrderDetailRepository orderDetailRepository;
    @Override
    public List<OrderDetail> findAllByOrderId(String orderId) {
        return orderDetailRepository.findAllByOrderId(orderId);
    }

    @Override
    public boolean existsByProductIdAndOrderUserId(String productId, long userId) {
        if(userId == 0) return false;
        return orderDetailRepository.existsByProductIdAndOrderUserId(productId, userId);
    }
}
