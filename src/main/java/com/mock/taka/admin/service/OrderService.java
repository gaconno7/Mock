package com.mock.taka.admin.service;

import com.mock.taka.admin.repository.OrderDetailRepository;
import com.mock.taka.admin.repository.OrderRepository;
import com.mock.taka.domain.Order;
import com.mock.taka.domain.OrderDetail;
import com.mock.taka.domain.User;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
@Service
public class OrderService {

    private OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;

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
    public List<Order> fetchAllOrder(){
        return this.orderRepository.findAll();
    }
    public Optional<Order> fetchOrderById(String id){
        return this.orderRepository.findById(id);
    }
    public void deleteOrderById(String id){
        Optional<Order> orderOptional = this.fetchOrderById(id);
        if(orderOptional.isPresent()){
            Order order = orderOptional.get();
            List<OrderDetail> orderDetails = order.getOrderDetails();
            for (OrderDetail orderDetail : orderDetails){
                this.orderDetailRepository.deleteById(orderDetail.getId());
            }
            this.orderRepository.deleteById(id);
        }
    }
    public void updateOrder(Order ord) {
        Optional<Order> orderOptional = this.fetchOrderById(ord.getId());
        if(orderOptional.isPresent()){
            Order currentOrder = orderOptional.get();
            currentOrder.setStatus(ord.getStatus());
            this.orderRepository.save(currentOrder);
        }
    }
    public List<Order> fetchOrderByUser(User user) {
        return this.orderRepository.findByUser(user);
    }
}
