package com.mock.taka.admin.controller;

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

import com.mock.taka.domain.Category;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.Store;
import com.mock.taka.domain.User;
import com.mock.taka.admin.service.CategoryService;
import com.mock.taka.admin.service.ProductService;
import com.mock.taka.admin.service.StoreService;
import com.mock.taka.admin.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
@Controller
public class StoreController {
    private final StoreService storeService;
    private final ProductService productService;
    private final CategoryService categoryService;
    private final UserService userService;

    public StoreController(
        StoreService storeService,
        ProductService productService,
        CategoryService categoryService,
        UserService userService) {
        this.storeService = storeService;
        this.productService = productService;
        this.categoryService = categoryService;
        this.userService = userService;
    }
    @GetMapping("/admin/store")
    public String getStore(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "store");
        List<Store> str = this.storeService.fetchStore();
        model.addAttribute("store", str);
        return "/admin/store/show";
    }
    //    @GetMapping("/admin/store/create")
    // public String getCreateStorePage(Model model, HttpServletRequest active) {
    //     active.setAttribute("activePage", "store");
    //     model.addAttribute("newStore", new Store());
    //     model.addAttribute("users", userService.getUserByRole("ROLE_USER"));
    //     return "admin/store/create";
    // }
    @GetMapping("/admin/user/{userId}/store/create")
public String getCreateStoreForUserPage(@PathVariable Long userId, Model model, HttpServletRequest active) {
    active.setAttribute("activePage", "store");
    
    Optional<User> selectedUser = this.userService.findUserById(userId);
    if (selectedUser.isPresent()) {
        Store newStore = new Store();
        newStore.setUser(selectedUser.get());
        model.addAttribute("newStore", newStore);
        model.addAttribute("selectedUserId", userId);
        model.addAttribute("isUserPreselected", true);
        return "admin/store/create";
    } else {
        return "redirect:/admin/user";
    }
}
    

    @PostMapping("/admin/store/create")
public String handleCreateStore(
        @ModelAttribute("newStore") @Valid Store str,
        @RequestParam(value = "userId", required = false) Long userId,
        BindingResult newStoreBindingResult,
        Model model) {
    if (newStoreBindingResult.hasErrors()) {
        if (userId != null) {
            Optional<User> selectedUser = this.userService.findUserById(userId);
            if (selectedUser.isPresent()) {
                model.addAttribute("selectedUserId", userId);
                model.addAttribute("isUserPreselected", true);
                str.setUser(selectedUser.get());
            } else {
                model.addAttribute("users", userService.getUserByRole("ROLE_USER"));
            }
        } else {
            model.addAttribute("users", userService.getUserByRole("ROLE_USER"));
        }
        return "admin/store/create";
    }
    
    if (userId == null) {
        newStoreBindingResult.rejectValue("user", "error.user", "Vui lòng chọn người dùng");
        model.addAttribute("users", userService.getUserByRole("ROLE_USER"));
        return "admin/store/create";
    }
    
    Optional<User> selectedUser = this.userService.findUserById(userId);
    if (selectedUser.isPresent()) {
        User user = selectedUser.get();
        str.setUser(user);
        this.userService.updateUserRole(user, "ROLE_SUPPLIER");
    } else {
        newStoreBindingResult.rejectValue("user", "error.user", "Người dùng không tồn tại");
        model.addAttribute("users", userService.getUserByRole("ROLE_USER"));
        return "admin/store/create";
    }

    this.storeService.createStore(str);

    return "redirect:/admin/store";
}
    
    @GetMapping("/admin/store/update/{id}")
    public String getUpdateStorePage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "store");
        Optional<Store> currentStore = this.storeService.fetchStoreById(id);
        model.addAttribute("newStore", currentStore.get());
        return "admin/store/update";
    }

    @PostMapping("/admin/store/update")
    public String handleUpdateStore(@ModelAttribute("newStore") @Valid Store str,
            BindingResult newStoreBindingResult) {

        // validate
        if (newStoreBindingResult.hasErrors()) {
            return "admin/store/update";
        }

        Store currentStore = this.storeService.fetchStoreById(str.getId()).get();

            currentStore.setName(str.getName());
            currentStore.setDescription(str.getDescription());
            

            this.storeService.createStore(currentStore);
        

        return "redirect:/admin/store";
    }
    @GetMapping("/admin/store/delete/{id}")
    public String getDeleteStorePage(Model model, @PathVariable long id, HttpServletRequest active) {
        active.setAttribute("activePage", "store");
        model.addAttribute("id", id);
        model.addAttribute("newStore", new Store());
        return "admin/store/delete";
    }

    @PostMapping("/admin/store/delete")
    public String postDeleteStore(Model model, @ModelAttribute("newStore") Store str) {
        Optional<Store> storeOpt = this.storeService.fetchStoreById(str.getId());
        if (storeOpt.isPresent()) {
            Store store = storeOpt.get();
            User user = store.getUser();
            this.storeService.deleteStore(str.getId());
            this.userService.updateUserRole(user,   "ROLE_USER");
        }
        
        return "redirect:/admin/store";
    }
    @GetMapping("/admin/store/{id}/products")
public String getProductsByStore(
        Model model, 
        @PathVariable String id,
        @RequestParam(required = false) String categoryId,
        HttpServletRequest active) {
    
    active.setAttribute("activePage", "store");
    Optional<Store> store = storeService.fetchStoreById(id);
    
    if (store.isPresent()) {
        List<Product> products;
        
      
        if (categoryId != null && !categoryId.isEmpty()) {
            Optional<Category> category = categoryService.fetchCategoryById(categoryId);
            if (category.isPresent()) {
           
                products = productService.findByStoreAndCategoryAndDeletedFalse(store.get(), category.get());
                model.addAttribute("selectedCategoryId", categoryId);
            } else {
             
                products = productService.findByStoreAndIsDeletedFalse(store.get());
            }
        } else {
         
            products = productService.findByStoreAndIsDeletedFalse(store.get());
        }
        
        List<Category> storeCategories = productService.findCategoriesByStore(store.get());
        
        model.addAttribute("products", products);
        model.addAttribute("storeName", store.get().getName());
        model.addAttribute("categories", storeCategories);
        model.addAttribute("storeId", id);
        
        return "admin/product/show"; 
    }
    
    return "redirect:/admin/store"; 
}

}
