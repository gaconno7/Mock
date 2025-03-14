package com.mock.taka.service;

import com.mock.taka.domain.Product;
import com.mock.taka.domain.ProductImage;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface ProductImageService {
    ProductImage saveProductImage(ProductImage productImage);

    List<ProductImage> saveProductImages(Product product, List<String> imageUrls);

    List<ProductImage> getImagesByProduct(Product product); 

    void deleteProductImage(String id);
 
    void deleteAllProductImages(Product product);

    List<ProductImage> uploadAndSaveProductImages(MultipartFile[] files, Product product) throws IOException;
}