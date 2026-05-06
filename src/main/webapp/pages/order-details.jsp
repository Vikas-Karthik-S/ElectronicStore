<%@ page import="java.util.List" %>
<%@ page import="com.electronicstore.model.Order" %>
<%@ page import="com.electronicstore.model.OrderItem" %>
<%@ page import="com.electronicstore.model.Product" %>
<%@ page import="com.electronicstore.service.ProductService" %>
<%@ include file="../partials/header.jsp" %>
<%@ include file="../partials/navbar.jsp" %>

<div class="container">
    <% 
        Order o = (Order) request.getAttribute("order");
        List<OrderItem> items = (List<OrderItem>) request.getAttribute("orderItems");
        ProductService ps = new ProductService();
        if (o != null) {
    %>
        <div class="section-title">
            <h1>Order #<%= o.getId() %> Details</h1>
            <p>Status: <%= o.getStatus() %></p>
        </div>

        <div class="cart-container">
            <div class="cart-items">
                <h3>Items</h3>
                <br>
                <% 
                    if (items != null) {
                        for (OrderItem item : items) {
                            Product p = ps.getProductById(item.getProductId());
                            if (p != null) {
                %>
                    <div class="cart-item">
                        <img src="${pageContext.request.contextPath}/assets/images/products/<%= p.getImageUrl() %>" alt="<%= p.getName() %>" style="width: 80px; height: 80px; object-fit: contain; border-radius: 8px;">
                        <div class="item-details">
                            <h4><%= p.getName() %></h4>
                            <p>Quantity: <%= item.getQuantity() %></p>
                        </div>
                        <div class="item-total">
                            &#8377;<%= String.format("%.2f", item.getPrice() * item.getQuantity()) %>
                        </div>
                    </div>
                <% } } } %>
            </div>

            <div class="order-summary">
                <h3>Order Summary</h3>
                <br>
                <p><strong>Order Date:</strong> <%= o.getOrderDate() %></p>
                <p><strong>Shipping Address:</strong><br><%= o.getShippingAddress() %></p>
                <br>
                <div class="summary-row summary-total">
                    <span>Total</span>
                    <span>&#8377;<%= String.format("%.2f", o.getTotalAmount()) %></span>
                </div>
            </div>
        </div>
    <% } %>
</div>

<%@ include file="../partials/footer.jsp" %>