package com.mock.taka.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mock.taka.service.CartService;

@Controller
@RequestMapping("/cart")
public class CartController {
    @Autowired
    private CartService cartService;

    @GetMapping
    public String getCart(Model model) {
        model.addAttribute("cartItems", cartService.getCartItems());
        model.addAttribute("totalCartPrice", cartService.calculateTotalCartPrice());
        return "client/cart/cart";
    }

    @PostMapping("/update")
    public String updateCartItem(@RequestParam String cartItemId, @RequestParam int quantity, Model model) {
        cartService.updateCartItem(cartItemId, quantity);
        model.addAttribute("cartItems", cartService.getCartItems());
        model.addAttribute("totalCartPrice", cartService.calculateTotalCartPrice());
        return "client/cart/cart";
    }

    @PostMapping("/remove")
    public String removeCartItem(@RequestParam String cartItemId, Model model) {
        cartService.removeCartItem(cartItemId);
        model.addAttribute("cartItems", cartService.getCartItems());
        model.addAttribute("totalCartPrice", cartService.calculateTotalCartPrice());
        return "client/cart/cart";
    }
}
