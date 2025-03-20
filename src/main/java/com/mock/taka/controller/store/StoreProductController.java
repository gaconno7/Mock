package com.mock.taka.controller.store;

import com.mock.taka.domain.*;
import com.mock.taka.service.admin.AdminProductService;
import com.mock.taka.service.client.CategoryService;
import com.mock.taka.service.client.ProductImageService;
import com.mock.taka.service.store.StoreService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class StoreProductController {
    AdminProductService productService;
    StoreService storeService;
    CategoryService categoryService;
    ProductImageService productImageService;

    @GetMapping("/store/product")
    public String getProduct(Model model, HttpServletRequest active, HttpSession session) {
        active.setAttribute("activePage", "product");
        List<Product> prs = this.productService.findByStoreId(((User) session.getAttribute("user")).getStore().getId() );
        List<Category> categories = categoryService.fetchCategory();
        model.addAttribute("products", prs);
        model.addAttribute("categories", categories);
        return "store/product/show";
    }

    @GetMapping("/store/product/create")
    public String getCreateProductPage(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "product");
        model.addAttribute("newProduct", new Product());
        model.addAttribute("stores", storeService.fetchStore());
        model.addAttribute("category", categoryService.fetchCategory());
        return "store/product/create";
    }

    @PostMapping("/store/product/create")
    public String handleCreateProduct(
        @ModelAttribute("newProduct") @Valid Product pr,
        BindingResult newProductBindingResult,
        @RequestParam("imageFile") MultipartFile[] files,
        HttpSession session,
        @RequestParam("categoryId") String categoryId,
        Model model) throws IOException {
    // validate     
    if (newProductBindingResult.hasErrors()) {
        model.addAttribute("stores", storeService.fetchStore());
        model.addAttribute("category", categoryService.fetchCategory());
        return "store/product/create";
    }
    
    Optional<Store> selectedStore = this.storeService.fetchStoreById(((User) session.getAttribute("user")).getStore().getId());
    if (selectedStore.isPresent()) {
        pr.setStore(selectedStore.get());
    } else {
        newProductBindingResult.rejectValue("store", "error.product", "Cửa hàng không tồn tại");
        model.addAttribute("stores", storeService.fetchStore());
        model.addAttribute("category", categoryService.fetchCategory());
        return "store/product/create";
    }
    
    Optional<Category> selectedCategory = this.categoryService.fetchCategoryById(categoryId);
    if (selectedCategory.isPresent()) {
        pr.setCategory(selectedCategory.get());
    } else {
        newProductBindingResult.rejectValue("category", "error.product", "Loại sản phẩm không tồn tại");
        model.addAttribute("stores", storeService.fetchStore());
        model.addAttribute("category", categoryService.fetchCategory());
        return "store/product/create";
    }
    
    // Lưu sản phẩm trước
    Product savedProduct = this.productService.createProduct(pr);
    
    // Xử lý upload file
    if (files != null && files.length > 0) {
        try {
            productImageService.uploadAndSaveProductImages(files, savedProduct);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("stores", storeService.fetchStore());
            model.addAttribute("category", categoryService.fetchCategory());
            model.addAttribute("uploadError", "Không thể tải lên hình ảnh: " + e.getMessage());
            return "store/product/create";
        }
    }
    
    return "redirect:/store/product";
}
    
    @GetMapping("/store/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "product");
        Optional<Product> currentProduct = this.productService.fetchProductById(id);
        if (currentProduct.isPresent()) {
            model.addAttribute("newProduct", currentProduct.get());
            List<ProductImage> productImages = productImageService.getImagesByProduct(currentProduct.get());
            model.addAttribute("productImages", productImages);
        }
        model.addAttribute("stores", storeService.fetchStore());
        model.addAttribute("category", categoryService.fetchCategory());
        return "store/product/update";
    }

    @PostMapping("/store/product/update")
    public String handleUpdateProduct(
            @ModelAttribute("newProduct") @Valid Product pr,
            BindingResult newProductBindingResult,
            @RequestParam("imageFile") MultipartFile[] files,
            @RequestParam("storeId") String storeId,
            @RequestParam("categoryId") String categoryId,
            Model model) throws Exception {

        if (newProductBindingResult.hasErrors()) {
            model.addAttribute("stores", storeService.fetchStore());
            model.addAttribute("category", categoryService.fetchCategory());
            return "store/product/update";
        }
    
        
        Optional<Store> selectedStore = this.storeService.fetchStoreById(storeId);
        Optional<Category> selectedCategory = this.categoryService.fetchCategoryById(categoryId);
        
        if (selectedStore.isPresent() && selectedCategory.isPresent()) {
            Optional<Product> optionalProduct = this.productService.fetchProductById(pr.getId());
            
            if (optionalProduct.isPresent()) {
                Product currentProduct = optionalProduct.get();
                
         
                currentProduct.setName(pr.getName());
                currentProduct.setPrice(pr.getPrice());
                currentProduct.setQuantity(pr.getQuantity());
                currentProduct.setDescription(pr.getDescription());
                
              
                currentProduct.setStore(selectedStore.get());
                currentProduct.setCategory(selectedCategory.get());
    
             
                Product updatedProduct = this.productService.createProduct(currentProduct);
                
               
                if (files != null && files.length > 0) { 
                    boolean hasNonEmptyFiles = false;
                    for (MultipartFile file : files) {
                        if (file != null && !file.isEmpty()) {
                            hasNonEmptyFiles = true;
                            break;
                        }
                    }
                    
                    if (hasNonEmptyFiles) {
                        productImageService.uploadAndSaveProductImages(files, updatedProduct);
                    }
                }
            }
        } else {
            if (!selectedStore.isPresent()) {
                newProductBindingResult.rejectValue("store", "error.product", "Cửa hàng không tồn tại");
            }
            if (!selectedCategory.isPresent()) {
                newProductBindingResult.rejectValue("category", "error.product", "Loại sản phẩm không tồn tại");
            }
            model.addAttribute("stores", storeService.fetchStore());
            model.addAttribute("category", categoryService.fetchCategory());
            return "store/product/update";
        }
    
        return "redirect:/store/product";
    }

    @GetMapping("/store/product/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "product");
        model.addAttribute("id", id);
        model.addAttribute("newProduct", new Product());
        return "store/product/delete";
    }

    @PostMapping("/store/product/delete")
    public String postDeleteProduct(Model model, @ModelAttribute("newProduct") Product pr) {
        Optional<Product> optionalProduct = this.productService.fetchProductById(pr.getId());
        if (optionalProduct.isPresent()) {
            productImageService.deleteAllProductImages(optionalProduct.get());
        }
        this.productService.deleteProduct(pr.getId());
        return "redirect:/store/product";
    }

    @GetMapping("/store/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "product");
        Optional<Product> optionalProduct = this.productService.fetchProductById(id);
        if (optionalProduct.isPresent()) {
            Product pr = optionalProduct.get();
            model.addAttribute("product", pr);
            List<ProductImage> productImages = productImageService.getImagesByProduct(pr);
            model.addAttribute("productImages", productImages);
        }
        model.addAttribute("id", id);
        return "store/product/detail";
    }

    @PostMapping("/store/product/delete-image/{imageId}")
    public String deleteProductImage(@PathVariable String imageId, @RequestParam("productId") String productId) {
        productImageService.deleteProductImage(imageId);
        return "redirect:/store/product/update/" + productId;
    }
    @GetMapping("/store/product/filter")
public String filterProducts(@RequestParam(required = false) String categoryId, Model model, HttpServletRequest active) {
    active.setAttribute("activePage", "product");
    
    List<Product> filteredProducts;

    if (categoryId != null && !categoryId.isEmpty()) {
    Optional<Category> category = categoryService.fetchCategoryById(categoryId);
    if (category.isPresent()) {
        filteredProducts = productService.findByCategoryAndDeletedFalse(category.get());
        model.addAttribute("selectedCategoryId", categoryId);
    } else {
        filteredProducts = productService.fetchProducts();
    }
    } else {
    filteredProducts = productService.fetchProducts();
}

    List<Category> categories = categoryService.fetchCategory();
    
    model.addAttribute("products", filteredProducts);
    model.addAttribute("categories", categories);
    
    return "store/product/show";
}
}