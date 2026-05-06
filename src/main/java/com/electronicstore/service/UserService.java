package com.electronicstore.service;

import com.electronicstore.dao.implementations.UserDAOImpl;
import com.electronicstore.dao.interfaces.UserDAO;
import com.electronicstore.model.User;

public class UserService {
    private UserDAO userDAO = new UserDAOImpl();

    public boolean registerUser(User user) {
        if (userDAO.findByUsername(user.getUsername()) != null) return false;
        if (userDAO.findByEmail(user.getEmail()) != null) return false;
        return userDAO.register(user);
    }

    public User login(String username, String password) {
        return userDAO.login(username, password);
    }

    public User getUserById(int id) {
        return userDAO.findById(id);
    }

    public boolean updateProfile(User user) {
        return userDAO.updateProfile(user);
    }

    public boolean updatePassword(int userId, String newPassword) {
        return userDAO.updatePassword(userId, newPassword);
    }
}