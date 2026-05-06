package com.electronicstore.controller;

import com.electronicstore.model.Category;
import com.electronicstore.model.Product;
import com.electronicstore.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductController extends HttpServlet {
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryIdStr = request.getParameter("category");
        String searchQuery = request.getParameter("search");
        String brand = request.getParameter("brand");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String sort = request.getParameter("sort");
        if (sort == null || sort.isEmpty()) sort = "asc";

        List<Product> products;
        if (searchQuery != null && !searchQuery.isEmpty()) {
            products = productService.searchProducts(searchQuery);
        } else if (categoryIdStr != null || brand != null || minPriceStr != null || maxPriceStr != null || sort != null) {
            Integer categoryId = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Integer.parseInt(categoryIdStr) : null;
            Double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Double.parseDouble(minPriceStr) : null;
            Double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Double.parseDouble(maxPriceStr) : null;
            products = productService.filterProducts(categoryId, brand, minPrice, maxPrice, sort);
        } else {
            products = productService.getAllProducts();
        }

        request.setAttribute("products", products);
        request.setAttribute("categories", productService.getAllCategories());
        request.getRequestDispatcher("/pages/products.jsp").forward(request, response);
    }
}