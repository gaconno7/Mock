package com.mock.taka.service.client.impl;

import com.mock.taka.domain.Product;
import com.mock.taka.domain.ProductImage;
import com.mock.taka.repository.ProductImageRepository;
import com.mock.taka.service.client.ProductImageService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class ProductImageServiceImpl implements ProductImageService {

    private final ProductImageRepository productImageRepository;
    private final CloudinaryService cloudinaryService;

    public ProductImageServiceImpl(ProductImageRepository productImageRepository, CloudinaryService cloudinaryService) {
        this.productImageRepository = productImageRepository;
        this.cloudinaryService = cloudinaryService;
    }

    @Override
    public ProductImage saveProductImage(ProductImage productImage) {
        return productImageRepository.save(productImage);
    }

    @Override
    public List<ProductImage> saveProductImages(Product product, List<String> imageUrls) {
        List<ProductImage> productImages = new ArrayList<>();
        
        for (String url : imageUrls) {
            ProductImage productImage = ProductImage.builder()
                .product(product)
                .url(url)
                .status(true)
                .build();
                
            productImages.add(productImage);
        }
        
        return productImageRepository.saveAll(productImages);
    }

    private String getImageNameFromUrl(String url) {
        int lastSlashIndex = url.lastIndexOf('/');
        if (lastSlashIndex != -1 && lastSlashIndex < url.length() - 1) {
            return url.substring(lastSlashIndex + 1);
        }
        return url;
    }

    @Override
    public List<ProductImage> getImagesByProduct(Product product) {
        return productImageRepository.findByProduct(product);
    }

    @Override
    public void deleteProductImage(String id) {
        productImageRepository.deleteById(id);
    }

    @Override
    public void deleteAllProductImages(Product product) {
        List<ProductImage> images = productImageRepository.findByProduct(product);
        productImageRepository.deleteAll(images);
    }

    @Override
    public List<ProductImage> uploadAndSaveProductImages(MultipartFile[] files, Product product) throws IOException {
        List<MultipartFile> validFiles = new ArrayList<>();
        for (MultipartFile file : files) {
            if (file != null && !file.isEmpty()) {
                validFiles.add(file);
            }
        }

        if (validFiles.isEmpty()) {
            return new ArrayList<>();
        }
        MultipartFile[] validFilesArray = validFiles.toArray(new MultipartFile[0]);
        List<String> imageUrls = cloudinaryService.uploadFiles(validFilesArray, "products");
        return saveProductImages(product, imageUrls);
    }
}