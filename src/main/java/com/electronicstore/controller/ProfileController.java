package com.electronicstore.controller;

import com.electronicstore.model.User;
import com.electronicstore.service.UserService;
import com.electronicstore.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        request.setAttribute("user", userService.getUserById(user.getId()));
        
        com.electronicstore.service.AddressService addressService = new com.electronicstore.service.AddressService();
        com.electronicstore.model.Address defaultAddress = addressService.getDefaultAddress(user.getId());
        request.setAttribute("defaultAddress", defaultAddress);
        
        request.getRequestDispatcher("/pages/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        user.setFullName(request.getParameter("fullName"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));

        if (userService.updateProfile(user)) {
            response.sendRedirect("profile?msg=Profile updated");
        } else {
            response.sendRedirect("profile?error=Update failed");
        }
    }
}