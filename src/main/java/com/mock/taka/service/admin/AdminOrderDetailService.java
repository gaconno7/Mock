package com.mock.taka.service.admin;

import com.mock.taka.domain.OrderDetail;

import java.util.List;

public interface AdminOrderDetailService {
    List<OrderDetail> findAll();
    List<OrderDetail> fetchOrderDetail(String id);
}
