package com.mock.taka.service;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mock.taka.domain.CartItem;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.ProductVariant;
import com.mock.taka.domain.User;
import com.mock.taka.repository.CartItemRepository;
import com.mock.taka.repository.ProductRepository;
import com.mock.taka.repository.ProductVariantRepository;
import com.mock.taka.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Service
public class CartService {

    @Autowired
    private CartItemRepository cartItemRepository;

    @Autowired
    private ProductVariantRepository productVariantRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProductRepository productRepository;

    public List<CartItem> getCartItems(long userId) {
        return cartItemRepository.findByUserId(userId);
    }

    // public void updateCartItem(String cartItemId, int quantity) {
    //     CartItem item = cartItemRepository.findById(cartItemId).orElseThrow();
    //     item.setQuantity(quantity);
    //     cartItemRepository.save(item);
    // }

    public boolean addToCart(User user, String productId, String productVariantId, int quantity) {
        // Lấy sản phẩm từ DB
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm!"));

        // Lấy phiên bản sản phẩm nếu có
        ProductVariant productVariant = null;
        if (productVariantId != null && !productVariantId.isEmpty()) {
            productVariant = productVariantRepository.findById(productVariantId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy phiên bản sản phẩm!"));
        }

        // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
        Optional<CartItem> existingCartItem = cartItemRepository.findByUserAndProductAndProductVariant(user, product, productVariant);

        if (existingCartItem.isPresent()) {
            // Nếu đã có, cập nhật số lượng
            CartItem cartItem = existingCartItem.get();
            cartItem.setQuantity(cartItem.getQuantity() + quantity);
            cartItemRepository.save(cartItem);
        } else {
            // Nếu chưa có, thêm mới
            CartItem cartItem = new CartItem();
            cartItem.setUser(user);
            cartItem.setProduct(product);
            cartItem.setProductVariant(productVariant);
            cartItem.setQuantity(quantity);
            cartItemRepository.save(cartItem);
        }
        return true;
    }

    // public boolean updateCartItem(String cartItemId, int quantity) {
    //     CartItem cartItem = cartItemRepository.findById(cartItemId).orElse(null);
    //     if (cartItem == null) {
    //         return false; // Không tìm thấy sản phẩm, cập nhật thất bại
    //     }
    
    //     cartItem.setQuantity(quantity);
    //     cartItemRepository.save(cartItem);
    //     return true; // Cập nhật thành công
    // }
    

    // public void removeCartItem(String cartItemId) {
    //     cartItemRepository.deleteById(cartItemId);
    // }

    // public String calculateTotalCartPrice() {
    //     double total = cartItemRepository.findAll().stream().mapToDouble(CartItem::getTotalPrice).sum();
    //     DecimalFormat decimalFormat = new DecimalFormat("#,###.##");
    //     return decimalFormat.format(total);
    // }

    public boolean updateCartItem(String cartItemId, int quantity) {
        Optional<CartItem> cartItemOpt = cartItemRepository.findById(cartItemId);
        if (cartItemOpt.isPresent()) {
            CartItem cartItem = cartItemOpt.get();
            cartItem.setQuantity(quantity);
            cartItemRepository.save(cartItem);
            return true;
        }
        return false;
    }

    public boolean removeCartItem(String cartItemId) {
        if (cartItemRepository.existsById(cartItemId)) {
            cartItemRepository.deleteById(cartItemId);
            return true;
        }
        return false;
    }

    public double calculateTotalCartPrice(Long userId) {
        List<CartItem> cartItems = cartItemRepository.findByUserId(userId);
        return cartItems.stream().mapToDouble(CartItem::getTotalPrice).sum();
    }

    public List<CartItem> getCartItemsByIds(List<String> cartItemIds) {
        return cartItemRepository.findAllById(cartItemIds);
    }
}

