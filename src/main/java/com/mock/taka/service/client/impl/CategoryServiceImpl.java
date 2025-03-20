package com.mock.taka.service.client.impl;

import java.util.List;
import java.util.Optional;

import com.mock.taka.repository.CategoryRepository;
import com.mock.taka.service.client.CategoryService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import com.mock.taka.domain.Category;

@Service
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {

    CategoryRepository categoryRepository;

    @Override
    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    public Category createCategory(Category ctg) {
        return categoryRepository.save(ctg);
    }


    public Optional<Category> fetchCategoryById(String id) {
        return categoryRepository.findById(id);
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
