package com.electronicstore.controller;

import com.electronicstore.model.CartItem;
import com.electronicstore.model.User;
import com.electronicstore.service.CartService;
import com.electronicstore.service.CheckoutService;
import com.electronicstore.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.electronicstore.service.AddressService;
import com.electronicstore.model.Address;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {
    private CheckoutService checkoutService = new CheckoutService();
    private CartService cartService = new CartService();
    private AddressService addressService = new AddressService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("success".equals(action)) {
            request.getRequestDispatcher("/pages/success.jsp").forward(request, response);
            return;
        }

        User user = SessionUtil.getLoggedInUser(request);
        List<CartItem> items = cartService.getCartItems(user.getId());
        if (items.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        Address defaultAddress = addressService.getDefaultAddress(user.getId());
        request.setAttribute("defaultAddress", defaultAddress);
        request.setAttribute("cartItems", items);
        request.getRequestDispatcher("/pages/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipCode = request.getParameter("zipCode");
        String country = request.getParameter("country");
        
        String fullAddress = String.format("%s, %s, %s, %s, %s", street, city, state, zipCode, country);
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        if (checkoutService.placeOrder(user.getId(), fullAddress, totalAmount)) {
            response.sendRedirect("checkout?action=success");
        } else {
            response.sendRedirect("checkout?error=Failed to place order");
        }
    }
}