package com.electronicstore.controller;

import com.electronicstore.model.Product;
import com.electronicstore.model.ProductSpecification;
import com.electronicstore.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/product-details")
public class ProductDetailController extends HttpServlet {
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String ajaxStr = request.getParameter("ajax");

        if (idStr != null) {
            try {
                int productId = Integer.parseInt(idStr);
                
                if ("true".equals(ajaxStr)) {
                    response.setContentType("text/html");
                    java.io.PrintWriter out = response.getWriter();
                    List<ProductSpecification> specs = productService.getProductSpecs(productId);

                    if (specs != null && !specs.isEmpty()) {
                        out.println("<table class='specs-table' style='width:100%; border-collapse: collapse; margin-top: 20px;'>");
                        for (ProductSpecification spec : specs) {
                            out.println("<tr style='border-bottom: 1px solid #e2e8f0;'>");
                            out.println("<td style='padding: 12px; font-weight: 600; color: #64748b; width: 40%;'>" + spec.getSpecName() + "</td>");
                            out.println("<td style='padding: 12px; color: #1e293b;'>" + spec.getSpecValue() + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                    } else {
                        out.println("<p style='padding: 20px; text-align: center; color: #64748b;'>No specifications available for this product.</p>");
                    }
                    return;
                }

                Product product = productService.getProductById(productId);
                List<ProductSpecification> specs = productService.getProductSpecs(productId);
                
                request.setAttribute("product", product);
                request.setAttribute("specifications", specs);
                request.getRequestDispatcher("/pages/product-details.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                if ("true".equals(ajaxStr)) {
                    response.setContentType("text/html");
                    response.getWriter().println("<p style='color: red;'>Invalid Product ID</p>");
                } else {
                    response.sendRedirect("products");
                }
            }
        } else {
            if ("true".equals(ajaxStr)) {
                response.setContentType("text/html");
                response.getWriter().println("<p style='color: red;'>Product ID missing</p>");
            } else {
                response.sendRedirect("products");
            }
        }
    }
}