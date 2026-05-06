package com.electronicstore.service;

import com.electronicstore.dao.implementations.CartDAOImpl;
import com.electronicstore.dao.implementations.CartItemDAOImpl;
import com.electronicstore.dao.interfaces.CartDAO;
import com.electronicstore.dao.interfaces.CartItemDAO;
import com.electronicstore.model.Cart;
import com.electronicstore.model.CartItem;
import java.util.List;

public class CartService {
    private CartDAO cartDAO = new CartDAOImpl();
    private CartItemDAO cartItemDAO = new CartItemDAOImpl();

    public Cart getOrCreateCart(int userId) {
        Cart cart = cartDAO.getCartByUserId(userId);
        if (cart == null) {
            cart = cartDAO.createCart(userId);
        }
        return cart;
    }

    public boolean addToCart(int userId, int productId, int quantity) {
        Cart cart = getOrCreateCart(userId);
        CartItem existingItem = cartItemDAO.getItem(cart.getId(), productId);
        if (existingItem != null) {
            return cartItemDAO.updateQuantity(existingItem.getId(), existingItem.getQuantity() + quantity);
        } else {
            CartItem newItem = new CartItem();
            newItem.setCartId(cart.getId());
            newItem.setProductId(productId);
            newItem.setQuantity(quantity);
            return cartItemDAO.addItem(newItem);
        }
    }

    public List<CartItem> getCartItems(int userId) {
        Cart cart = getOrCreateCart(userId);
        return cartItemDAO.getItemsByCartId(cart.getId());
    }

    public boolean updateQuantity(int itemId, int quantity) {
        if (quantity <= 0) return cartItemDAO.removeItem(itemId);
        return cartItemDAO.updateQuantity(itemId, quantity);
    }

    public boolean removeItem(int itemId) {
        return cartItemDAO.removeItem(itemId);
    }

    public boolean clearCart(int userId) {
        Cart cart = getOrCreateCart(userId);
        return cartItemDAO.clearCart(cart.getId());
    }
}