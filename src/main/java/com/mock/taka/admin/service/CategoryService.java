package com.mock.taka.service;

import java.util.List;
import java.util.Optional;
import org.springframework.stereotype.Service;
import com.mock.taka.domain.Category;
import com.mock.taka.repository.CategoryRepository;

@Service
public class CategoryService {
    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }
    public Category createCategory(Category ctg) {
        return this.categoryRepository.save(ctg);
    }


    public Optional<Category> fetchCategoryById(String id) {
        return this.categoryRepository.findById(id);
    }

    public void deleteCategory(String id) {
        Optional<Category> CategoryOptional = categoryRepository.findById(id);
        CategoryOptional.ifPresent(category -> {
            category.setStatus(false);
            categoryRepository.save(category);
        });
    }
    public List<Category> fetchCategory() {
        return categoryRepository.findByStatusTrue();
    }
    
}
