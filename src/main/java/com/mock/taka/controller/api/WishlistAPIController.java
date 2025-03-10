package com.mock.taka.controller.api;

import com.mock.taka.domain.WishlistItem;
import com.mock.taka.dto.WishlistItemRequest;
import com.mock.taka.service.WishlistService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/wishlists")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class WishlistAPIController {

    WishlistService wishlistService;

    @GetMapping
    public ResponseEntity<Page<WishlistItem>>  getWishlistItems(
            @RequestParam long userId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "8") int size ) {

        Pageable pageable = PageRequest.of(page, size);

        Page<WishlistItem> products = wishlistService.findAllByUserId(userId,pageable);
        return ResponseEntity.ok(products);
    }


    @PostMapping
    public ResponseEntity<?>  addWishlistItem(
            @RequestBody WishlistItemRequest request) {
            log.info(request.toString());
            var wishlistItem = wishlistService.save(request);
        return ResponseEntity.ok(wishlistItem);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteWishlistItem(
            @PathVariable(name = "id") String id
    ) {
        wishlistService.deleteById(id);
        return ResponseEntity.ok("Success");
    }
}
