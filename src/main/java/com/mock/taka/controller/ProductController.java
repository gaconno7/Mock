package com.mock.taka.controller;

import java.util.List;
import java.util.Optional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.mock.taka.domain.Product;
import com.mock.taka.domain.Store;
import com.mock.taka.service.ProductService;
import com.mock.taka.service.StoreService;
import com.mock.taka.service.UploadService;

import jakarta.validation.Valid;

@Controller
public class ProductController {
    private final ProductService productService;
    private final UploadService uploadService;
    private final StoreService storeService;

    public ProductController(ProductService productService, UploadService uploadService, StoreService storeService) {
        this.productService = productService;
        this.uploadService = uploadService;
        this.storeService = storeService;
    }
    @GetMapping("/admin/product")
    public String getProduct(Model model) {
        List<Product> prs = this.productService.fetchProducts();
        model.addAttribute("products", prs);
        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        model.addAttribute("stores", storeService.fetchStore());
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String handleCreateProduct(
            @ModelAttribute("newProduct") @Valid Product pr,
            BindingResult newProductBindingResult,
            @RequestParam("hoidanitFile") MultipartFile file,
            @RequestParam("storeId") String storeId,
            Model model) {
        // validate     
        if (newProductBindingResult.hasErrors()) {
            model.addAttribute("stores", storeService.fetchStore());
            return "admin/product/create";
        }
        Optional<Store> selectedStore = this.storeService.fetchStoreById(storeId);
        if (selectedStore.isPresent()) {
            pr.setStore(selectedStore.get());
        } else {
            newProductBindingResult.rejectValue("store", "error.product", "Cửa hàng không tồn tại");
            return "admin/product/create";
        }

        // upload image
        String image = this.uploadService.handleSaveUploadFile(file, "product");
        pr.setImage(image);

        this.productService.createProduct(pr);

        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable String id) {
        Optional<Product> currentProduct = this.productService.fetchProductById(id);
        model.addAttribute("newProduct", currentProduct.get());
        model.addAttribute("stores", storeService.fetchStore());
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
public String handleUpdateProduct(
        @ModelAttribute("newProduct") @Valid Product pr,
        BindingResult newProductBindingResult,
        @RequestParam("hoidanitFile") MultipartFile file,
        @RequestParam("storeId") String storeId) {
    // Validate
    if (newProductBindingResult.hasErrors()) {
        return "admin/product/update";
    }

    // Kiểm tra và cập nhật Store
    Optional<Store> selectedStore = this.storeService.fetchStoreById(storeId);
    if (selectedStore.isPresent()) {
        Product currentProduct = this.productService.fetchProductById(pr.getId()).get();
        
        // Cập nhật thông tin sản phẩm
        currentProduct.setName(pr.getName());
        currentProduct.setPrice(pr.getPrice());
        currentProduct.setQuantity(pr.getQuantity());
        currentProduct.setDescription(pr.getDescription());
        
        // Gán Store
        currentProduct.setStore(selectedStore.get());

        // Upload image nếu có
        if (!file.isEmpty()) {
            String img = this.uploadService.handleSaveUploadFile(file, "product");
            currentProduct.setImage(img);
        }

        this.productService.createProduct(currentProduct);
    } else {
        // Xử lý trường hợp không tìm thấy Store
        newProductBindingResult.rejectValue("store", "error.product", "Cửa hàng không tồn tại");
        return "admin/product/update";
    }

    return "redirect:/admin/product";
}

    @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable String id) {
        model.addAttribute("id", id);
        model.addAttribute("newProduct", new Product());
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete")
    public String postDeleteProduct(Model model, @ModelAttribute("newProduct") Product pr) {
        this.productService.deleteProduct(pr.getId());
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable String id) {
        Product pr = this.productService.fetchProductById(id).get();
        model.addAttribute("product", pr);
        model.addAttribute("id", id);
        return "admin/product/detail";
    }
}