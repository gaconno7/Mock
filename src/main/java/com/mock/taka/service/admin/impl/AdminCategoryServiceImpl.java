package com.mock.taka.service.admin.impl;

import java.util.List;
import java.util.Optional;

import com.mock.taka.repository.CategoryRepository;
import com.mock.taka.service.admin.AdminCategoryService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import com.mock.taka.domain.Category;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AdminCategoryServiceImpl implements AdminCategoryService {
    CategoryRepository categoryRepository;

    @Override
    public Category createCategory(Category ctg) {
        return this.categoryRepository.save(ctg);
    }

    @Override
    public Optional<Category> fetchCategoryById(String id) {
        return this.categoryRepository.findById(id);
    }

    @Override
    public void deleteCategory(String id) {
        Optional<Category> CategoryOptional = categoryRepository.findById(id);
        CategoryOptional.ifPresent(category -> {
            category.setStatus(false);
            categoryRepository.save(category);
        });
    }

    @Override
    public List<Category> fetchCategory() {
        return categoryRepository.findByStatusTrue();
    }
    
}
