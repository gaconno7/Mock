package com.mock.taka.service.client.impl;

import com.mock.taka.domain.Product;
import com.mock.taka.repository.EvaluationRepository;
import com.mock.taka.repository.ProductRepository;
import com.mock.taka.repository.dao.ProductDAO;
import com.mock.taka.service.client.ProductService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.Collections;
import java.util.List;
import java.util.Objects;

@Service
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    ProductRepository productRepository;
    ProductDAO productDAO;

    @Override
    public List<Product> findTopProductsByCreatedDate() {
        return productRepository.findTopProductsByCreatedDate();
    }

    @Override
    public Product findByDiscountMax() {
        return productRepository.findByDiscountMax();
    }

    @Override
    public Page<Product> findByStoreIdAndNameLike(int pageSize, int pageNum, String name, String storeId) {
        return productRepository.findByStoreIdAndNameLike(storeId,"%" + name + "%", PageRequest.of(pageNum - 1, pageSize));
    }

    @Override
    public List<Product> findTopSellingProducts() {
        return productRepository.findTopSellingProducts();
    }

    @Override
    public Product findById(String id) {
        return productRepository.findProductById(id).orElse(null);
    }

    @Override
    public List<Product> findRelatedProductsByName(String name, String id) {
        String searchValue = "";
        if(name.contains(" ")){
            String[] arr = name.split(" ");
            searchValue = arr[0];
        }

        List<Product> products = productRepository.findRelatedProductsByName(searchValue, id, PageRequest.of(0, 4));

        return CollectionUtils.isEmpty(products) ? null : products;
    }

    @Override
    public Page<Product> findProductByFilter(int pageSize, int pageNum, String categoryId,
                                             double minPrice, double maxPrice, String sortBy,
                                             String searchValue) {
        return productDAO.findProductByFilter(pageSize, pageNum, categoryId, minPrice, maxPrice, sortBy, searchValue);
    }


}
