package com.mock.taka.service.client.impl;

import com.mock.taka.domain.CartItem;
import com.mock.taka.domain.Order;
import com.mock.taka.domain.OrderDetail;
import com.mock.taka.domain.User;
import com.mock.taka.repository.OrderDetailRepository;
import com.mock.taka.repository.OrderRepository;
import com.mock.taka.service.client.OrderService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class OrderServiceImpl implements OrderService {

    OrderRepository orderRepository;
    OrderDetailRepository orderDetailRepository;

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

    public Order createOrder(String address, List<CartItem> orderItems, double totalPrice, User user, String paymentMethod, String status, String paymentRef) {
        Order order = new Order();
        order.setAddress(address);
        order.setOrderDate(new Date());
        order.setStatus(status);
        order.setUser(user);
        order.setTotalPrice(totalPrice);
        order.setPaymentMethod(paymentMethod);
        order.setPaymentRef(paymentMethod.equals("COD") ? "UNKNOWN" : paymentRef);
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

    public void updatePaymentStatus(String paymentRef, String paymentStatus) {
        Optional<Order> orderOptional = this.orderRepository.findByPaymentRef(paymentRef);
        if (orderOptional.isPresent()) {
            // update
            Order order = orderOptional.get();
            order.setStatus(paymentStatus);
            this.orderRepository.save(order);
        }
    }
}
