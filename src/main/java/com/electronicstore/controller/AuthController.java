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

@WebServlet("/auth")
public class AuthController extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            User user = new User();
            user.setFullName(request.getParameter("fullName"));
            user.setUsername(request.getParameter("username"));
            user.setPassword(request.getParameter("password"));
            user.setEmail(request.getParameter("email"));
            user.setPhone(request.getParameter("phone"));

            if (userService.registerUser(user)) {
                response.sendRedirect("auth/login.jsp?msg=Registration successful");
            } else {
                response.sendRedirect("auth/register.jsp?error=Registration failed. Username or Email already exists");
            }
        } else if ("login".equals(action)) {
            User user = userService.login(request.getParameter("username"), request.getParameter("password"));
            if (user != null) {
                SessionUtil.setLoggedInUser(request, user);
                response.sendRedirect("home");
            } else {
                response.sendRedirect("auth/login.jsp?error=Invalid credentials");
            }
        }
    }
}