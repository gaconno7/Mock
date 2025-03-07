package com.mock.taka.service;

import org.springframework.stereotype.Service;

import com.mock.taka.repository.CartItemRepository;

@Service
public class CartItemService {
    private final CartItemRepository cartItemRepository;

    public CartItemService(CartItemRepository cartItemRepository) {
        this.cartItemRepository = cartItemRepository;
    }
}
