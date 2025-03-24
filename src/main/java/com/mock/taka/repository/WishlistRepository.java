package com.mock.taka.repository;

import com.mock.taka.domain.WishlistItem;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WishlistRepository extends JpaRepository<WishlistItem, String> {

    Page<WishlistItem> findAllByUserIdAndProductDeleted(long userId, Pageable pageable, boolean isDeleted);
    boolean existsByProductIdAndUserId( String productId, long userId);
}
