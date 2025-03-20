//package com.mock.taka.controller.store;
//
//import java.io.IOException;
//import java.util.List;
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
//import jakarta.validation.Valid;
//
//
//
//@Controller
//@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
//@RequiredArgsConstructor
//public class StoreClientController {
//    AdminProductService productService;
//    StoreService storeService;
//    CategoryService categoryService;
//    CloudinaryService cloudinaryService;
//    ProductImageService productImageService;
//
//    @GetMapping("/store/manage")
//    public String getMethodName(Model model) {
//        List<Product> prs = this.productService.fetchProducts();
//        List<Category> categories = categoryService.fetchCategory();
//        model.addAttribute("products", prs);
//        model.addAttribute("categories", categories);
//        return "store/manage";
//    }
//    @GetMapping("/store/create")
//    public String getCreatePage(Model model) {
//        model.addAttribute("newProduct", new Product());
//        model.addAttribute("stores", storeService.fetchStore());
//        model.addAttribute("category", categoryService.fetchCategory());
//        return "store/create";
//    }
//
//    @PostMapping("/store/create")
//    public String handleCreateProduct(
//        @ModelAttribute("newProduct") @Valid Product pr,
//        BindingResult newProductBindingResult,
//        @RequestParam("imageFile") MultipartFile[] files,
//        @RequestParam("storeId") String storeId,
//        @RequestParam(value = "categoryId", required = false) String categoryId,
//        Model model) throws IOException {
//        // validate
//        if (newProductBindingResult.hasErrors()) {
//            model.addAttribute("stores", storeService.fetchStore());
//            model.addAttribute("category", categoryService.fetchCategory());
//            return "store/create";
//        }
//
//        Optional<Store> selectedStore = this.storeService.fetchStoreById(storeId);
//        if (selectedStore.isPresent()) {
//            pr.setStore(selectedStore.get());
//        } else {
//            newProductBindingResult.rejectValue("store", "error.product", "Cửa hàng không tồn tại");
//            model.addAttribute("stores", storeService.fetchStore());
//            model.addAttribute("category", categoryService.fetchCategory());
//            return "store/create";
//        }
//
//        Optional<Category> selectedCategory = this.categoryService.fetchCategoryById(categoryId);
//        if (selectedCategory.isPresent()) {
//            pr.setCategory(selectedCategory.get());
//        } else {
//            newProductBindingResult.rejectValue("category", "error.product", "Loại sản phẩm không tồn tại");
//            model.addAttribute("stores", storeService.fetchStore());
//            model.addAttribute("category", categoryService.fetchCategory());
//            return "store/create";
//        }
//
//        // Lưu sản phẩm trước
//        Product savedProduct = this.productService.createProduct(pr);
//
//        // Xử lý upload file
//        if (files != null && files.length > 0) {
//            try {
//                productImageService.uploadAndSaveProductImages(files, savedProduct);
//            } catch (Exception e) {
//                e.printStackTrace();
//                model.addAttribute("stores", storeService.fetchStore());
//                model.addAttribute("category", categoryService.fetchCategory());
//                model.addAttribute("uploadError", "Không thể tải lên hình ảnh: " + e.getMessage());
//                return "store/create";
//            }
//        }
//
//        return "redirect:/store/manage";
//    }
//
//
//}
