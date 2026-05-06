package com.electronicstore.controller;

import com.electronicstore.model.User;
import com.electronicstore.service.UserService;
import com.electronicstore.util.PasswordUtil;
import com.electronicstore.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/security")
public class SecurityController extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Fetch fresh user data
        User freshUser = userService.getUserById(user.getId());
        request.setAttribute("user", freshUser);
        request.getRequestDispatcher("/pages/security.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        User freshUser = userService.getUserById(user.getId());
        
        if ("updateName".equals(action)) {
            String newName = request.getParameter("fullName");
            freshUser.setFullName(newName);
            if (userService.updateProfile(freshUser)) {
                response.sendRedirect(request.getContextPath() + "/security?msg=Name updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/security?error=Failed to update name");
            }
            return;
        }

        if ("updateEmail".equals(action)) {
            String newEmail = request.getParameter("email");
            freshUser.setEmail(newEmail);
            if (userService.updateProfile(freshUser)) {
                response.sendRedirect(request.getContextPath() + "/security?msg=Email updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/security?error=Failed to update email");
            }
            return;
        }

        if ("updatePhone".equals(action)) {
            String newPhone = request.getParameter("phone");
            freshUser.setPhone(newPhone);
            if (userService.updateProfile(freshUser)) {
                response.sendRedirect(request.getContextPath() + "/security?msg=Mobile number updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/security?error=Failed to update mobile number");
            }
            return;
        }

        if ("updatePassword".equals(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect(request.getContextPath() + "/security?error=New passwords do not match");
                return;
            }

            if (!PasswordUtil.checkPassword(currentPassword, freshUser.getPassword())) {
                response.sendRedirect(request.getContextPath() + "/security?error=Current password is incorrect");
                return;
            }

            if (userService.updatePassword(freshUser.getId(), newPassword)) {
                response.sendRedirect(request.getContextPath() + "/security?msg=Password updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/security?error=Failed to update password");
            }
            return;
        }

        response.sendRedirect(request.getContextPath() + "/security");
    }
}
