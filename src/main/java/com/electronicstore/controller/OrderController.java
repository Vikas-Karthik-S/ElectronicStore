package com.electronicstore.controller;

import com.electronicstore.model.Order;
import com.electronicstore.model.OrderItem;
import com.electronicstore.model.User;
import com.electronicstore.service.OrderService;
import com.electronicstore.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/orders")
public class OrderController extends HttpServlet {
    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        String orderIdStr = request.getParameter("id");

        if (orderIdStr != null) {
            int orderId = Integer.parseInt(orderIdStr);
            Order order = orderService.getOrderDetails(orderId);
            List<OrderItem> items = orderService.getOrderItems(orderId);
            
            request.setAttribute("order", order);
            request.setAttribute("orderItems", items);
            request.getRequestDispatcher("/pages/order-details.jsp").forward(request, response);
        } else {
            List<Order> orders = orderService.getUserOrders(user.getId());
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/pages/orders.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("cancel".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            if (orderService.cancelOrder(orderId)) {
                response.sendRedirect("orders?msg=Order cancelled successfully");
            } else {
                response.sendRedirect("orders?error=Could not cancel order");
            }
        }
    }
}