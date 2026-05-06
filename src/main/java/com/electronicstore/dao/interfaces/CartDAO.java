package com.electronicstore.dao.interfaces;

import com.electronicstore.model.Cart;

public interface CartDAO {
    Cart getCartByUserId(int userId);
    Cart createCart(int userId);
}