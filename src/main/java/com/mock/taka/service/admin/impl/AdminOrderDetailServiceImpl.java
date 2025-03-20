package com.mock.taka.service.admin.impl;


import com.mock.taka.domain.OrderDetail;
import com.mock.taka.repository.OrderDetailRepository;
import com.mock.taka.service.admin.AdminOrderDetailService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Service
public class AdminOrderDetailServiceImpl implements AdminOrderDetailService {
    OrderDetailRepository orderDetailRepository;
    public List<OrderDetail> findAll() {
        return orderDetailRepository.findAll();
    }
    public List<OrderDetail> fetchOrderDetail(String id){
        return orderDetailRepository.getOrderDetailByOrderId(id);
    }
}
