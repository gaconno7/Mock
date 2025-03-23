package com.mock.taka.repository;

import com.mock.taka.domain.Order;
import com.mock.taka.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Order, String> {
    List<Order> findByUserId(long userId);
    List<Order> findByUserIdAndStatus(long userId, String status);
    @Query("SELECT o FROM Order o WHERE MONTH(o.orderDate) = :month AND YEAR(o.orderDate) = :year")
    List<Order> getOrdersByMonthAndYear(@Param("month") int month, @Param("year") int year);

    @Query("SELECT SUM(o.totalPrice) FROM Order o")
    Double getTotalPriceSum();
    List<Order> findByUser(User user);
    Optional<Order> findByPaymentRef(String paymentRef);

    Page<Order> findByIdLikeAndStatusAndOrderDateGreaterThanEqual(String id, String status, Date orderDate, Pageable pageable);
    Page<Order> findByIdLikeAndStatus(String id, String status, Pageable pageable);
    Page<Order> findByStatusAndOrderDateGreaterThanEqual(String status, Date orderDate, Pageable pageable);
    Page<Order> findByIdAndOrderDateGreaterThanEqual(String id, Date orderDate, Pageable pageable);
    Page<Order> findByStatus(String status, Pageable pageable);
    Page<Order> findByIdLike(String id, Pageable pageable);
    Page<Order> findByOrderDateGreaterThanEqual(Date orderDate, Pageable pageable);


}
