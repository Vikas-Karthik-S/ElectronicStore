package com.electronicstore.dao.implementations;

import com.electronicstore.dao.interfaces.CartDAO;
import com.electronicstore.model.Cart;
import com.electronicstore.util.DBConnection;
import java.sql.*;

public class CartDAOImpl implements CartDAO {

    @Override
    public Cart getCartByUserId(int userId) {
        String sql = "SELECT * FROM Cart WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Cart cart = new Cart();
                    cart.setId(rs.getInt("id"));
                    cart.setUserId(rs.getInt("user_id"));
                    cart.setCreatedAt(rs.getTimestamp("created_at"));
                    return cart;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Cart createCart(int userId) {
        String sql = "INSERT INTO Cart (user_id) VALUES (?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, userId);
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return getCartByUserId(userId);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}