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

import com.mock.taka.domain.Product;
import com.mock.taka.domain.Store;
import com.mock.taka.service.ProductService;
import com.mock.taka.service.StoreService;

import jakarta.validation.Valid;
@Controller
public class StoreController {
    private final StoreService storeService;
    private final ProductService productService;

    public StoreController(StoreService storeService, ProductService productService) {
        this.storeService = storeService;
        this.productService = productService;
    }
    @GetMapping("/admin/store")
    public String getStore(Model model) {
        List<Store> str = this.storeService.fetchStore();
        model.addAttribute("store", str);
        return "/admin/store/show";
    }
       @GetMapping("/admin/store/create")
    public String getCreateStorePage(Model model) {
        model.addAttribute("newStore", new Store());
        return "admin/store/create";
    }

    @PostMapping("/admin/store/create")
    public String handleCreateStore(
            @ModelAttribute("newStore") @Valid Store str,
            BindingResult newStoreBindingResult) {
        // validate
        if (newStoreBindingResult.hasErrors()) {
            return "admin/store/create";
        }


        this.storeService.createStore(str);

        return "redirect:/admin/store";
    }
    @GetMapping("/admin/store/update/{id}")
    public String getUpdateStorePage(Model model, @PathVariable String id) {
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
    public String getDeleteStorePage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newStore", new Store());
        return "admin/store/delete";
    }

    @PostMapping("/admin/store/delete")
    public String postDeleteStore(Model model, @ModelAttribute("newStore") Store str) {
        this.storeService.deleteStore(str.getId());
        return "redirect:/admin/store";
    }
    @GetMapping("/admin/store/{id}/products")
public String getProductsByStore(Model model, @PathVariable String id) {
    Optional<Store> store = storeService.fetchStoreById(id);
    if (store.isPresent()) {
        List<Product> products = productService.findByStoreAndIsDeletedFalse(store.get());
        model.addAttribute("products", products);
        model.addAttribute("storeName", store.get().getName());
        return "admin/product/show"; 
    }
    return "redirect:/admin/store"; 
}
}
