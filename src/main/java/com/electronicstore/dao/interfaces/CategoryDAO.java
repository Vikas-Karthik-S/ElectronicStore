package com.electronicstore.dao.interfaces;

import com.electronicstore.model.Category;
import java.util.List;

public interface CategoryDAO {
    List<Category> getAllCategories();
    Category getCategoryById(int id);
}