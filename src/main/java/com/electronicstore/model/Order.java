package com.electronicstore.model;

import java.sql.Timestamp;

public class Order {
    private int id;
    private int userId;
    private Timestamp orderDate;
    private double totalAmount;
    private String status;
    private String shippingAddress;
    private boolean stockRestored;


    public Order() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }
    public boolean isStockRestored() { return stockRestored; }
    public void setStockRestored(boolean stockRestored) { this.stockRestored = stockRestored; }
}