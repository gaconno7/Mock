package com.mock.taka.admin.repository;

import com.mock.taka.domain.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface OrderRepository extends JpaRepository<Order, String> {
    @Query("SELECT o FROM Order o WHERE MONTH(o.orderDate) = :month AND YEAR(o.orderDate) = :year")
    List<Order> getOrdersByMonthAndYear(@Param("month") int month, @Param("year") int year);

    @Query("SELECT SUM(o.totalPrice) FROM Order o")
    Double getTotalPriceSum();
}
