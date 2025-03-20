package com.mock.taka.repository;

import com.mock.taka.domain.Order;
import com.mock.taka.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, String> {
    List<Order> findByUserId(long userId);
    List<Order> findByUserIdAndStatus(long userId, String status);
    @Query("SELECT o FROM Order o WHERE MONTH(o.orderDate) = :month AND YEAR(o.orderDate) = :year")
    List<Order> getOrdersByMonthAndYear(@Param("month") int month, @Param("year") int year);

    @Query("SELECT SUM(o.totalPrice) FROM Order o")
    Double getTotalPriceSum();
    List<Order> findByUser(User user);
}
