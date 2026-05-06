package com.electronicstore.service;

import com.electronicstore.dao.implementations.CategoryDAOImpl;
import com.electronicstore.dao.implementations.ProductDAOImpl;
import com.electronicstore.dao.implementations.ProductSpecDAOImpl;
import com.electronicstore.dao.interfaces.CategoryDAO;
import com.electronicstore.dao.interfaces.ProductDAO;
import com.electronicstore.dao.interfaces.ProductSpecDAO;
import com.electronicstore.model.Category;
import com.electronicstore.model.Product;
import com.electronicstore.model.ProductSpecification;
import java.util.List;

public class ProductService {
    private ProductDAO productDAO = new ProductDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();
    private ProductSpecDAO specDAO = new ProductSpecDAOImpl();

    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    public List<Product> getProductsByCategory(int categoryId) {
        return productDAO.getProductsByCategory(categoryId);
    }

    public Product getProductById(int id) {
        return productDAO.getProductById(id);
    }

    public List<Category> getAllCategories() {
        return categoryDAO.getAllCategories();
    }

    public List<ProductSpecification> getProductSpecs(int productId) {
        return specDAO.getSpecsByProductId(productId);
    }

    public List<Product> searchProducts(String query) {
        return productDAO.searchProducts(query);
    }

    public List<Product> filterProducts(Integer categoryId, String brand, Double minPrice, Double maxPrice, String sort) {
        return productDAO.filterProducts(categoryId, brand, minPrice, maxPrice, sort);
    }
}