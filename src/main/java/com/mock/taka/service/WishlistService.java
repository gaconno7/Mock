package com.mock.taka.service;

import com.mock.taka.domain.User;
import com.mock.taka.domain.WishlistItem;
import com.mock.taka.dto.WishlistItemRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface WishlistService {

    Page<WishlistItem> findAllByUserId(long userId, Pageable pageable);
    WishlistItem save(WishlistItemRequest request);

    void deleteById(String id);
}
