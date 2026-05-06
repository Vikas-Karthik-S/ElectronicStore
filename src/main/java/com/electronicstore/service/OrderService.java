package com.electronicstore.service;

import com.electronicstore.dao.implementations.OrderDAOImpl;
import com.electronicstore.dao.implementations.OrderItemDAOImpl;
import com.electronicstore.dao.implementations.ProductDAOImpl;
import com.electronicstore.dao.interfaces.OrderDAO;
import com.electronicstore.dao.interfaces.OrderItemDAO;
import com.electronicstore.dao.interfaces.ProductDAO;
import com.electronicstore.model.Order;
import com.electronicstore.model.OrderItem;
import java.util.List;

public class OrderService {
    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrderItemDAO orderItemDAO = new OrderItemDAOImpl();
    private ProductDAO productDAO = new ProductDAOImpl();

    public List<Order> getUserOrders(int userId) {
        return orderDAO.getOrdersByUserId(userId);
    }

    public Order getOrderDetails(int orderId) {
        return orderDAO.getOrderById(orderId);
    }

    public List<OrderItem> getOrderItems(int orderId) {
        return orderItemDAO.getItemsByOrderId(orderId);
    }

    public boolean cancelOrder(int orderId) {
        Order order = orderDAO.getOrderById(orderId);
        if (order != null && "PLACED".equals(order.getStatus())) {
            // Restore Stock
            List<OrderItem> items = orderItemDAO.getItemsByOrderId(orderId);
            for (OrderItem item : items) {
                productDAO.restoreStock(item.getProductId(), item.getQuantity());
            }
            orderDAO.updateStockRestored(orderId, true);
            
            return orderDAO.updateStatus(orderId, "CANCELLED");

        }
        return false;
    }
}