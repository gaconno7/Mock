package com.mock.taka.service.client;

import com.mock.taka.domain.Product;
import com.mock.taka.domain.ProductVariant;

public interface ProductVariantService {
    ProductVariant save(String value, Product product);
}
