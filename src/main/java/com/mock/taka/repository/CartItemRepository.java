package com.mock.taka.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.CartItem;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.ProductVariant;
import com.mock.taka.domain.User;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, String> {
    List<CartItem> findByUserIdAndProductDeleted(long id, boolean status);

    @Query(value = "SELECT * FROM cart_items WHERE user_id = :userId AND product_variant_id = :productVariantId", nativeQuery = true)
    Optional<CartItem> findByUserIdAndProductVariantId(@Param("userId") long userId, @Param("productVariantId") String productVariantId);

    Optional<CartItem> findByUserAndProductAndProductVariant(User user, Product product, ProductVariant productVariant);

    List<CartItem> findAllByIdInAndProductDeleted(List<String> cartItemIds, boolean status);
}
