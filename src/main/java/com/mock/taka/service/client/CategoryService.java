package com.mock.taka.service.client;

import java.util.List;
import java.util.Optional;

import com.mock.taka.domain.Category;

public interface CategoryService {
    List<Category> findAll();
    Category createCategory(Category ctg);

   Optional<Category> fetchCategoryById(String id);

    void deleteCategory(String id);

    List<Category> fetchCategory();
}
