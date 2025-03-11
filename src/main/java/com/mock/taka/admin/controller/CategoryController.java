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

import com.mock.taka.admin.service.CategoryService;
import com.mock.taka.admin.service.ProductService;
import com.mock.taka.domain.Category;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.Store;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
@Controller
public class CategoryController {
    private final CategoryService categoryService;
    private final ProductService productService;
    

    public CategoryController(CategoryService categoryService, ProductService productService) {
        this.categoryService = categoryService;
        this.productService = productService;
    }
    @GetMapping("/admin/category")
    public String getCategory(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "store");
        List<Category> ctg = this.categoryService.fetchCategory();
        model.addAttribute("category", ctg);
        return "/admin/category/show";
    }

       @GetMapping("/admin/category/create")
    public String getCreateCategoryPage(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "store");
        model.addAttribute("newCategory", new Category());
        return "admin/category/create";
    }

    @PostMapping("/admin/category/create")
    public String handleCategoryStore(
            @ModelAttribute("newCategory") @Valid Category ctg,
            BindingResult newCategoryBindingResult) {
        // validate
        if (newCategoryBindingResult.hasErrors()) {
            return "admin/category/create";
        }


        this.categoryService.createCategory(ctg);

        return "redirect:/admin/category";
    }
     @GetMapping("/admin/category/update/{id}")
    public String getUpdateCategoryPage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "store");
        Optional<Category> currentCategory = this.categoryService.fetchCategoryById(id);
        model.addAttribute("newCategory", currentCategory.get());
        return "admin/category/update";
    }

    @PostMapping("/admin/category/update")
    public String handleUpdateCategory(@ModelAttribute("newCategory") @Valid Category ctg,
            BindingResult newCategoryBindingResult) {

        // validate
        if (newCategoryBindingResult.hasErrors()) {
            return "admin/category/update";
        }

        Category currentCategory = this.categoryService.fetchCategoryById(ctg.getId()).get();

            currentCategory.setName(ctg.getName());
            currentCategory.setDescription(ctg.getDescription());
            

            this.categoryService.createCategory(currentCategory);
        

        return "redirect:/admin/category";
    }
    @GetMapping("/admin/category/delete/{id}")
    public String getDeleteCategoryPage(Model model, @PathVariable long id, HttpServletRequest active) {
        active.setAttribute("activePage", "store");
        model.addAttribute("id", id);
        model.addAttribute("newCategory", new Category());
        return "admin/category/delete";
    }

    @PostMapping("/admin/category/delete")
    public String postDeleteCategory(Model model, @ModelAttribute("newCategory") Category ctg) {
        this.categoryService.deleteCategory(ctg.getId());
        return "redirect:/admin/category";
    }
    @GetMapping("/admin/category/{id}/products")
    public String getProductsByCategory(Model model, @PathVariable String id, HttpServletRequest active) {
    active.setAttribute("activePage", "product");
    Optional<Category> category = categoryService.fetchCategoryById(id);
    if (category.isPresent()) {
        List<Product> products = productService.findByCategoryAndDeletedFalse(category.get());
        model.addAttribute("products", products);
        model.addAttribute("categoryName", category.get().getName());
        return "admin/product/show"; 
    }
    return "redirect:/admin/category"; 
}
    
}