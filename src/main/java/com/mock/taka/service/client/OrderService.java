package com.mock.taka.service.client;

import com.mock.taka.domain.CartItem;
import com.mock.taka.domain.Order;
import com.mock.taka.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Date;
import java.util.List;

public interface OrderService {
    List<Order> findAllByUserId(long id);
    List<Order> findAllByUserIdAndStatus(long id, String status);
    Order findById(String id);
    Order saveStatus(String id, String status);
    Order createOrder(String address, List<CartItem> orderItems, double totalPrice, User user, String paymentMethod, String status, String paymentRef);
    void updatePaymentStatus(String paymentRef, String paymentStatus);
    List<Order> findAllByStoreId(String id);
    Page<Order> filterOrderWithStatus(int pageSize, int pageNum,
                                      String status, Date orderDate, String searchValue, String searchType, String storeId, String userId);
}
