package com.mock.taka.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.mock.taka.domain.Store;
import com.mock.taka.service.StoreService;


@Controller
@RequestMapping("store")
public class StoreController {
    private final StoreService storeService;

    public StoreController(StoreService storeService) {
        this.storeService = storeService;
    }

    @GetMapping("/{id}")
    public String getStorePage(@PathVariable("id") String storeId, Model model) {
        Store store = this.storeService.findStoreById(storeId).get();
        model.addAttribute("store", store);
        model.addAttribute("id", storeId);
        return "store/home";
    }
    
}
