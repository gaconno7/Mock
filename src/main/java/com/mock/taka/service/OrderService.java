package com.mock.taka.service;

import com.mock.taka.domain.CartItem;
import com.mock.taka.domain.Order;
import com.mock.taka.domain.OrderDetail;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.User;
import com.mock.taka.repository.OrderDetailRepository;
import com.mock.taka.repository.OrderRepository;
import com.mock.taka.repository.ProductRepository;
import com.mock.taka.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    public Order createOrder(String address, List<CartItem> orderItems, double totalPrice, User user) {
        Order order = new Order();
        order.setAddress(address);
        order.setOrderDate(new Date());
        order.setStatus("pending");
        order.setUser(user);
        order.setTotalPrice(totalPrice);
        Order savedOrder = orderRepository.save(order);

        
        for(CartItem item : orderItems) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setAmount(item.getQuantity());
            orderDetail.setCreatedDate(new Date());
            orderDetail.setStatus("active");
            orderDetail.setOrder(order);
            orderDetail.setProduct(item.getProduct());
            orderDetailRepository.save(orderDetail);
        }

        return savedOrder;
    }
}
