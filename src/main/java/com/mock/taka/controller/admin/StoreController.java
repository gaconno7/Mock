package com.mock.taka.controller.admin;

import com.mock.taka.domain.Category;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.Store;
import com.mock.taka.domain.User;
import com.mock.taka.service.admin.AdminProductService;
import com.mock.taka.service.admin.AdminUserService;
import com.mock.taka.service.client.CategoryService;
import com.mock.taka.service.client.StoreService;
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

import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class StoreController {
    StoreService storeService;
    AdminProductService productService;
    CategoryService categoryService;
    AdminUserService userService;


    @GetMapping("/user/store/{userId}/create")
    public String getCreateStoreForUserPage(@PathVariable Long userId, Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "store");

        Optional<User> selectedUser = userService.findUserById(userId);
        if (selectedUser.isPresent()) {
            Store newStore = new Store();
            newStore.setUser(selectedUser.get());
            model.addAttribute("newStore", newStore);
            model.addAttribute("selectedUserId", userId);
            model.addAttribute("isUserPreselected", true);

        }
        return "store/create";
    }

    @PostMapping("/user/store/create")
    public String handleCreateStore(
            @ModelAttribute("newStore") @Valid Store str,
            @RequestParam(value = "userId", required = false) Long userId,
            BindingResult newStoreBindingResult,
            HttpSession session,
            Model model) {
        if (newStoreBindingResult.hasErrors()) {
            if (userId != null) {
                Optional<User> selectedUser = userService.findUserById(userId);
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
            return "store/create";
        }

        if (userId == null) {
            newStoreBindingResult.rejectValue("user", "error.user", "Vui lòng chọn người dùng");
            model.addAttribute("users", userService.getUserByRole("ROLE_USER"));
            return "store/create";
        }

        Optional<User> selectedUser = userService.findUserById(userId);
        if (selectedUser.isPresent()) {
            User user = selectedUser.get();
            str.setUser(user);
            userService.updateUserRole(user, "ROLE_SUPPLIER");
        } else {
            newStoreBindingResult.rejectValue("user", "error.user", "Người dùng không tồn tại");
            model.addAttribute("users", userService.getUserByRole("ROLE_USER"));
            return "store/create";
        }
        str.setImage("https://clipart-library.com/2023/grocery-store-clipart-xl.png");
        var store = storeService.createStore(str);
        var user = userService.findUserById(userId).orElse(null);

        session.removeAttribute("user");
        session.setAttribute("user", user);

        return "redirect:/over-view-store/" + store.getId();
    }

    @GetMapping("/store/update/{id}")
    public String getUpdateStorePage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "store");
        Optional<Store> currentStore = storeService.fetchStoreById(id);
        model.addAttribute("newStore", currentStore.get());
        return "store/update";
    }

    @PostMapping("/store/update")
    public String handleUpdateStore(@ModelAttribute("newStore") @Valid Store str,
                                    BindingResult newStoreBindingResult) {

        // validate
        if (newStoreBindingResult.hasErrors()) {
            return "store/update";
        }

        Store currentStore = storeService.fetchStoreById(str.getId()).get();

        currentStore.setName(str.getName());
        currentStore.setDescription(str.getDescription());

        storeService.createStore(currentStore);

        return "redirect:/store";
    }

    @GetMapping("/store/delete/{id}")
    public String getDeleteStorePage(Model model, @PathVariable long id, HttpServletRequest active) {
        active.setAttribute("activePage", "store");
        model.addAttribute("id", id);
        model.addAttribute("newStore", new Store());
        return "store/delete";
    }

    @PostMapping("/store/delete")
    public String postDeleteStore(Model model, @ModelAttribute("newStore") Store str) {
        Optional<Store> storeOpt = storeService.fetchStoreById(str.getId());
        if (storeOpt.isPresent()) {
            Store store = storeOpt.get();
            User user = store.getUser();
            storeService.deleteStore(str.getId());
            userService.updateUserRole(user, "ROLE_USER");
        }

        return "redirect:/store";
    }

    @GetMapping("/store/{id}/products")
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

            return "product/show";
        }

        return "redirect:/store";
    }

    // ===== Các phương thức liên quan đến khôi phục cửa hàng =====
    @GetMapping("/store/deleted")
    public String getDeletedStores(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "store");
        List<Store> deletedStores = storeService.fetchDeletedStores();
        model.addAttribute("deletedStores", deletedStores);
        return "store/deleted";
    }

    @GetMapping("/store/restore/{id}")
    public String getRestoreStore(Model model, @PathVariable String id, HttpServletRequest request) {
        request.setAttribute("activePage", "store");

        Optional<Store> storeOptional = storeService.fetchStoreById(id);
        if (storeOptional.isPresent()) {
            Store store = storeOptional.get();
            if (store.isDeleted()) {
                model.addAttribute("restoreStore", store);
                return "store/restore";
            }
        }
        return "redirect:/store?error=Không tìm thấy cửa hàng cần khôi phục";
    }

    @PostMapping("/store/restore")
    public String postRestoreStore(@ModelAttribute("restoreStore") Store storeForm) {
        Optional<Store> storeOptional = storeService.fetchStoreById(storeForm.getId());
        if (storeOptional.isPresent()) {
            Store store = storeOptional.get();
            if (store.isDeleted()) {
                // Khôi phục cửa hàng
                store.setDeleted(false);

                // Khôi phục quyền ROLE_SUPPLIER cho người dùng
                User user = store.getUser();
                if (user != null) {
                    userService.updateUserRole(user, "ROLE_SUPPLIER");
                }

                storeService.createStore(store);
                return "redirect:/store";
            }
        }
        return "redirect:/store?error=Không thể khôi phục cửa hàng";
    }
}
