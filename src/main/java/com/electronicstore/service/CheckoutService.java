package com.electronicstore.service;

import com.electronicstore.dao.implementations.OrderDAOImpl;
import com.electronicstore.dao.implementations.OrderItemDAOImpl;
import com.electronicstore.dao.implementations.ProductDAOImpl;
import com.electronicstore.dao.interfaces.OrderDAO;
import com.electronicstore.dao.interfaces.OrderItemDAO;
import com.electronicstore.dao.interfaces.ProductDAO;
import com.electronicstore.model.*;
import java.util.List;

public class CheckoutService {
    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrderItemDAO orderItemDAO = new OrderItemDAOImpl();
    private ProductDAO productDAO = new ProductDAOImpl();
    private CartService cartService = new CartService();

    public boolean placeOrder(int userId, String shippingAddress, double totalAmount) {
        List<CartItem> items = cartService.getCartItems(userId);
        if (items.isEmpty()) return false;

        // Create Order
        Order order = new Order();
        order.setUserId(userId);
        order.setTotalAmount(totalAmount);
        order.setStatus("PLACED");
        order.setShippingAddress(shippingAddress);

        int orderId = orderDAO.createOrder(order);
        if (orderId > 0) {
            for (CartItem cartItem : items) {
                Product product = productDAO.getProductById(cartItem.getProductId());
                
                // Create Order Item
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orderId);
                orderItem.setProductId(cartItem.getProductId());
                orderItem.setQuantity(cartItem.getQuantity());
                orderItem.setPrice(product.getPrice());
                
                orderItemDAO.addOrderItem(orderItem);
                
                // Update Stock
                productDAO.updateStock(product.getId(), cartItem.getQuantity());
            }
            
            // Clear Cart
            cartService.clearCart(userId);
            return true;
        }
        return false;
    }
}