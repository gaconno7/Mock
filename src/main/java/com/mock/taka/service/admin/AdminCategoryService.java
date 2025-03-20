package com.mock.taka.service.admin;

import com.mock.taka.domain.Category;
import com.mock.taka.domain.Role;
import com.mock.taka.domain.User;

import java.util.List;
import java.util.Optional;

public interface AdminCategoryService {
    Category createCategory(Category ctg);
    Optional<Category> fetchCategoryById(String id);
    void deleteCategory(String id);
    List<Category> fetchCategory();
}
