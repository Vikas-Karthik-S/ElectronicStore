package com.electronicstore.controller;

import com.electronicstore.model.CartItem;
import com.electronicstore.model.User;
import com.electronicstore.service.CartService;
import com.electronicstore.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        if (user != null) {
            List<CartItem> items = cartService.getCartItems(user.getId());
            request.setAttribute("cartItems", items);
            request.getRequestDispatcher("/pages/cart.jsp").forward(request, response);
        } else {
            response.sendRedirect("auth/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId") != null ? request.getParameter("productId") : "0");
        int itemId = Integer.parseInt(request.getParameter("itemId") != null ? request.getParameter("itemId") : "0");
        int quantity = Integer.parseInt(request.getParameter("quantity") != null ? request.getParameter("quantity") : "1");

        boolean success = false;
        if ("add".equals(action)) {
            success = cartService.addToCart(user.getId(), productId, quantity);
        } else if ("update".equals(action)) {
            success = cartService.updateQuantity(itemId, quantity);
        } else if ("remove".equals(action)) {
            success = cartService.removeItem(itemId);
        } else if ("clear".equals(action)) {
            success = cartService.clearCart(user.getId());
        }

        if (success) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}