package com.electronicstore.dao.interfaces;

import com.electronicstore.model.OrderItem;
import java.util.List;

public interface OrderItemDAO {
    boolean addOrderItem(OrderItem item);
    List<OrderItem> getItemsByOrderId(int orderId);
}