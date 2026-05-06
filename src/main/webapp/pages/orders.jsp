<%@ page import="java.util.List" %>
<%@ page import="com.electronicstore.model.Order" %>
<%@ page import="com.electronicstore.model.OrderItem" %>
<%@ page import="com.electronicstore.model.Product" %>
<%@ page import="com.electronicstore.service.OrderService" %>
<%@ page import="com.electronicstore.service.ProductService" %>
<%@ include file="../partials/header.jsp" %>
<%@ include file="../partials/navbar.jsp" %>

<div class="container" style="padding-top: 40px; max-width: 1000px;">
    <div style="margin-bottom: 30px;">
        <h1 style="font-size: 2rem; font-weight: 700;">Your Orders</h1>
    </div>

    <% if (request.getParameter("msg") != null) { %>
        <div class="alert alert-success"><%= request.getParameter("msg") %></div>
    <% } %>
    <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-error"><%= request.getParameter("error") %></div>
    <% } %>

    <div class="orders-list">
        <% 
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            OrderService os = new OrderService();
            ProductService ps = new ProductService();
            
            if (orders != null && !orders.isEmpty()) {
                for (Order o : orders) {
        %>
            <div class="order-card" style="border: 1px solid var(--border-color); border-radius: 8px; margin-bottom: 25px; background: white; overflow: hidden; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
                <!-- Header -->
                <div class="order-header" style="background: #f8fafc; padding: 15px 20px; border-bottom: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap;">
                    <div style="display: flex; gap: 40px;">
                        <div>
                            <span style="font-size: 0.75rem; color: #64748b; text-transform: uppercase; font-weight: 600;">Order Placed</span><br>
                            <span style="font-weight: 500; font-size: 0.9rem;"><%= o.getOrderDate() %></span>
                        </div>
                        <div>
                            <span style="font-size: 0.75rem; color: #64748b; text-transform: uppercase; font-weight: 600;">Total</span><br>
                            <span style="font-weight: 500; font-size: 0.9rem;">&#8377;<%= String.format("%.2f", o.getTotalAmount()) %></span>
                        </div>
                        <div>
                            <span style="font-size: 0.75rem; color: #64748b; text-transform: uppercase; font-weight: 600;">Status</span><br>
                            <span style="font-weight: 700; font-size: 0.9rem; color: <%= "CANCELLED".equals(o.getStatus()) ? "#ef4444" : "#16a34a" %>;"><%= o.getStatus() %></span>
                        </div>
                    </div>
                    <div style="text-align: right;">
                        <span style="font-size: 0.75rem; color: #64748b; text-transform: uppercase; font-weight: 600;">Order #<%= o.getId() %></span><br>
                        <a href="orders?id=<%= o.getId() %>" style="color: var(--primary-color); font-size: 0.9rem; text-decoration: none; font-weight: 500;">View order details</a>
                    </div>
                </div>
                
                <!-- Body -->
                <div class="order-body" style="padding: 20px;">
                    <% 
                        List<OrderItem> items = os.getOrderItems(o.getId());
                        if (items != null) {
                            for (OrderItem item : items) {
                                Product p = ps.getProductById(item.getProductId());
                                if (p != null) {
                    %>
                        <div style="display: flex; gap: 20px; margin-bottom: 20px; align-items: start; border-bottom: 1px solid #f1f5f9; padding-bottom: 20px;">
                            <img src="${pageContext.request.contextPath}/assets/images/products/<%= p.getImageUrl() %>" style="width: 90px; height: 90px; object-fit: contain; border-radius: 8px; border: 1px solid #e2e8f0; padding: 5px;">
                            <div style="flex: 1;">
                                <a href="product-details?id=<%= p.getId() %>" style="font-weight: 600; font-size: 1.1rem; color: #1e293b; text-decoration: none; margin-bottom: 5px; display: block;"><%= p.getName() %></a>
                                <p style="color: #64748b; font-size: 0.9rem; margin-bottom: 10px;">Sold by: <%= p.getBrand() %></p>
                                <div style="display: flex; gap: 10px;">
                                    <a href="product-details?id=<%= p.getId() %>" class="btn btn-primary" style="padding: 6px 15px; font-size: 0.85rem; border-radius: 20px;">Buy it again</a>
                                    <a href="product-details?id=<%= p.getId() %>" class="btn btn-outline" style="padding: 6px 15px; font-size: 0.85rem; border-radius: 20px;">View your item</a>
                                </div>
                            </div>
                        </div>
                    <%          }
                            }
                        } 
                    %>
                    
                    <% if ("PLACED".equals(o.getStatus())) { %>
                        <div style="text-align: right; margin-top: 10px;">
                            <button type="button" class="btn btn-outline" style="color: #ef4444; border-color: #ef4444;" onclick="showCancelModal(<%= o.getId() %>)">Cancel Order</button>
                        </div>
                    <% } %>
                </div>
            </div>
        <% 
                }
            } else {
        %>
            <div style="text-align: center; padding: 50px; background: white; border-radius: 8px; border: 1px solid var(--border-color);">
                <div style="font-size: 3rem; margin-bottom: 15px;">&#128230;</div>
                <h2 style="font-size: 1.5rem; margin-bottom: 10px;">No orders found</h2>
                <p style="color: #64748b; margin-bottom: 20px;">You haven't placed any orders yet.</p>
                <a href="products" class="btn btn-primary">Start Shopping</a>
            </div>
        <% } %>
    </div>
</div>

<!-- Custom Cancel Modal -->
<div id="cancelModal" class="modal-overlay">
    <div class="modal-content">
        <div class="modal-icon">&#9888;</div>
        <h2 class="modal-title">Cancel Order?</h2>
        <p class="modal-text">Are you sure you want to cancel this order? This action cannot be undone.</p>
        <div class="modal-buttons">
            <button class="btn btn-outline" onclick="hideCancelModal()">No, Keep it</button>
            <form id="cancelForm" action="orders" method="POST">
                <input type="hidden" name="action" value="cancel">
                <input type="hidden" name="orderId" id="modalOrderId">
                <button type="submit" class="btn" style="background: #ef4444; color: white;">Yes, Cancel Order</button>
            </form>
        </div>
    </div>
</div>

<script>
    function showCancelModal(orderId) {
        document.getElementById('modalOrderId').value = orderId;
        document.getElementById('cancelModal').classList.add('active');
    }

    function hideCancelModal() {
        document.getElementById('cancelModal').classList.remove('active');
    }

    // Close modal if clicking outside the content
    window.onclick = function(event) {
        let modal = document.getElementById('cancelModal');
        if (event.target == modal) {
            hideCancelModal();
        }
    }
</script>

<%@ include file="../partials/footer.jsp" %>