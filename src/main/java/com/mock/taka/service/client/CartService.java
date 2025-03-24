package com.mock.taka.service.client;


import com.mock.taka.domain.CartItem;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.ProductVariant;
import com.mock.taka.domain.User;
import com.mock.taka.repository.CartItemRepository;
import com.mock.taka.repository.ProductRepository;
import com.mock.taka.repository.ProductVariantRepository;
import com.mock.taka.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CartService {

    CartItemRepository cartItemRepository;

    ProductVariantRepository productVariantRepository;

    ProductRepository productRepository;

    public List<CartItem> getCartItems(long userId) {
        return cartItemRepository.findByUserIdAndProductDeleted(userId, false);
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
        List<CartItem> cartItems = cartItemRepository.findByUserIdAndProductDeleted(userId, false);
        return cartItems.stream().mapToDouble(CartItem::getTotalPrice).sum();
    }

    public List<CartItem> getCartItemsByIds(List<String> cartItemIds) {
        return cartItemRepository.findAllByIdInAndProductDeleted(cartItemIds, false);
    }
}


