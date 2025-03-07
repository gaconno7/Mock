package com.mock.taka.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.Cart;
import com.mock.taka.domain.User;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    Cart findById(long id);
}
