package com.mock.taka.service.client.impl;

import com.mock.taka.domain.Product;
import com.mock.taka.domain.ProductVariant;
import com.mock.taka.repository.ProductVariantRepository;
import com.mock.taka.service.client.ProductVariantService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ProductVariantServiceImpl implements ProductVariantService {
    ProductVariantRepository productVariantRepository;
    @Override
    public ProductVariant save(String value, Product product) {
        return productVariantRepository.save(ProductVariant.builder().attribute(value).product(product).build());
    }
}
