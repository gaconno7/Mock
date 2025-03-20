//package com.mock.taka.controller.store;
//
//import java.io.IOException;
//import java.util.Optional;
//
//import com.mock.taka.service.admin.AdminProductService;
//import com.mock.taka.service.client.CategoryService;
//import com.mock.taka.service.client.ProductImageService;
//import com.mock.taka.service.client.impl.CloudinaryService;
//import com.mock.taka.service.store.StoreService;
//import lombok.AccessLevel;
//import lombok.RequiredArgsConstructor;
//import lombok.experimental.FieldDefaults;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.validation.BindingResult;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.multipart.MultipartFile;
//
//import com.mock.taka.domain.Category;
//import com.mock.taka.domain.Product;
//import com.mock.taka.domain.Store;
//
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.validation.Valid;
//
//@RequiredArgsConstructor
//@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
//@Controller
//public class ProductClientController {
//    AdminProductService productService;
//    StoreService storeService;
//    CategoryService categoryService;
//    CloudinaryService cloudinaryService;
//    ProductImageService productImageService;
//
//
//    @GetMapping("/store/product/create")
//    public String getCreateProductPage(Model model, HttpServletRequest active) {
//        active.setAttribute("activePage", "product");
//        model.addAttribute("newProduct", new Product());
//        model.addAttribute("stores", storeService.fetchStore());
//        model.addAttribute("category", categoryService.fetchCategory());
//        return "store/product/create";
//    }
//
//    @PostMapping("/store/product/create")
//public String handleCreateProduct(
//        @ModelAttribute("newProduct") @Valid Product pr,
//        BindingResult newProductBindingResult,
//        @RequestParam("imageFile") MultipartFile[] files,
//        @RequestParam("storeId") String storeId,
//        @RequestParam(value = "categoryId", required = false) String categoryId,
//        Model model) throws IOException {
//    // validate
//    if (newProductBindingResult.hasErrors()) {
//        model.addAttribute("stores", storeService.fetchStore());
//        model.addAttribute("category", categoryService.fetchCategory());
//        return "store/product/create";
//    }
//
//    Optional<Store> selectedStore = this.storeService.fetchStoreById(storeId);
//    if (selectedStore.isPresent()) {
//        pr.setStore(selectedStore.get());
//    } else {
//        newProductBindingResult.rejectValue("store", "error.product", "Cửa hàng không tồn tại");
//        model.addAttribute("stores", storeService.fetchStore());
//        model.addAttribute("category", categoryService.fetchCategory());
//        return "store/product/create";
//    }
//
//    Optional<Category> selectedCategory = this.categoryService.fetchCategoryById(categoryId);
//    if (selectedCategory.isPresent()) {
//        pr.setCategory(selectedCategory.get());
//    } else {
//        newProductBindingResult.rejectValue("category", "error.product", "Loại sản phẩm không tồn tại");
//        model.addAttribute("stores", storeService.fetchStore());
//        model.addAttribute("category", categoryService.fetchCategory());
//        return "store/product/create";
//    }
//
//    // Lưu sản phẩm trước
//    Product savedProduct = this.productService.createProduct(pr);
//
//    // Xử lý upload file
//    if (files != null && files.length > 0) {
//        try {
//            productImageService.uploadAndSaveProductImages(files, savedProduct);
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.addAttribute("stores", storeService.fetchStore());
//            model.addAttribute("category", categoryService.fetchCategory());
//            model.addAttribute("uploadError", "Không thể tải lên hình ảnh: " + e.getMessage());
//            return "store/product/create";
//        }
//    }
//
//    return "redirect:/store/manage";
//}
//}
