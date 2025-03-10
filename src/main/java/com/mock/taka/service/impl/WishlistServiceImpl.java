package com.mock.taka.service.impl;

import com.mock.taka.domain.User;
import com.mock.taka.domain.WishlistItem;
import com.mock.taka.dto.WishlistItemRequest;
import com.mock.taka.repository.ProductRepository;
import com.mock.taka.repository.UserRepository;
import com.mock.taka.repository.WishlistRepository;
import com.mock.taka.service.WishlistService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class WishlistServiceImpl implements WishlistService {
    WishlistRepository wishlistRepository;
    ProductRepository productRepository;
    UserRepository userRepository;

    @Override
    public Page<WishlistItem> findAllByUserId(long userId, Pageable pageable) {
        return wishlistRepository.findAllByUserId(userId, pageable);
    }

    @Override
    public WishlistItem save(WishlistItemRequest request) {
        var product = productRepository.findById(request.getProductId()).orElse(null);
        var user = userRepository.findById(request.getUserId()).orElse(null);
        return wishlistRepository.save(WishlistItem.builder().user(user).product(product).build());
    }

    @Override
    public void deleteById(String id) {
        wishlistRepository.deleteById(id);
    }
}
