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

@WebServlet(name = "HomeController", urlPatterns = {"/home", ""})
public class HomeController extends HttpServlet {
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = productService.getAllCategories();
        List<Product> products = productService.getAllProducts();
        
        request.setAttribute("categories", categories);
        request.setAttribute("featuredProducts", products.subList(0, Math.min(products.size(), 8)));
        
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
}