package com.mock.taka.service;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mock.taka.domain.Cart;
import com.mock.taka.domain.CartItem;
import com.mock.taka.domain.User;
import com.mock.taka.repository.CartItemRepository;
import com.mock.taka.repository.CartRepository;
import com.mock.taka.repository.UserRepository;

@Service
public class CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartItemRepository cartItemRepository;

    public List<CartItem> getCartItems() {
        return cartItemRepository.findAll();
    }

    public void updateCartItem(String cartItemId, int quantity) {
        CartItem item = cartItemRepository.findById(cartItemId).orElseThrow();
        item.setQuantity(quantity);
        cartItemRepository.save(item);
    }

    public void removeCartItem(String cartItemId) {
        cartItemRepository.deleteById(cartItemId);
    }

    public String calculateTotalCartPrice() {
        double total = cartItemRepository.findAll().stream().mapToDouble(CartItem::getTotalPrice).sum();
        DecimalFormat decimalFormat = new DecimalFormat("#,###.##");
        return decimalFormat.format(total);
    }
}

