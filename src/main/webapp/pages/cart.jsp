<%@ page import="java.util.List" %>
<%@ page import="com.electronicstore.model.CartItem" %>
<%@ page import="com.electronicstore.model.Product" %>
<%@ page import="com.electronicstore.service.ProductService" %>
<%@ include file="../partials/header.jsp" %>
<%@ include file="../partials/navbar.jsp" %>

<div class="container">
    <div class="section-title">
        <h1>Shopping Cart</h1>
    </div>

    <div class="cart-container">
        <div class="cart-items">
            <% 
                List<CartItem> items = (List<CartItem>) request.getAttribute("cartItems");
                ProductService ps = new ProductService();
                double subtotal = 0;

                if (items != null && !items.isEmpty()) {
                    for (CartItem item : items) {
                        Product p = ps.getProductById(item.getProductId());
                        if (p != null) {
                            double itemTotal = p.getPrice() * item.getQuantity();
                            subtotal += itemTotal;
            %>
                <div class="cart-item">
                    <img src="${pageContext.request.contextPath}/assets/images/products/<%= p.getImageUrl() %>" alt="<%= p.getName() %>" style="width: 80px; height: 80px; object-fit: contain; border-radius: 8px;">
                    <div class="item-details">
                        <h3><%= p.getName() %></h3>
                        <p class="product-brand"><%= p.getBrand() %></p>
                        <p class="product-price">&#8377;<%= p.getPrice() %></p>
                    </div>
                    <div class="qty-control">
                        <button class="qty-btn" onclick="updateCartQuantity(<%= item.getId() %>, <%= item.getQuantity() - 1 %>)">-</button>
                        <span><%= item.getQuantity() %></span>
                        <button class="qty-btn" onclick="updateCartQuantity(<%= item.getId() %>, <%= item.getQuantity() + 1 %>)">+</button>
                    </div>
                    <div class="item-total" style="width: 100px; text-align: right; font-weight: 700;">
                        &#8377;<%= String.format("%.2f", itemTotal) %>
                    </div>
                    <button class="btn btn-outline" style="color: red; border-color: red;" onclick="removeFromCart(<%= item.getId() %>)">Remove</button>
                </div>
            <% 
                        }
                    }
                } else {
            %>
                <p>Your cart is empty.</p>
                <a href="products" class="btn btn-primary">Start Shopping</a>
            <% } %>
        </div>

        <% if (items != null && !items.isEmpty()) { %>
        <div class="order-summary">
            <h3>Order Summary</h3>
            <br>
            <%
                double shipping = (subtotal > 0 && subtotal < 500) ? 40.0 : 0.0;
                double total = subtotal + shipping;
            %>
            <div class="summary-row">
                <span>Subtotal</span>
                <span>&#8377;<%= String.format("%.2f", subtotal) %></span>
            </div>
            <div class="summary-row">
                <span>Shipping</span>
                <span>
                    <% if (shipping > 0) { %>
                        &#8377;<%= String.format("%.2f", shipping) %>
                    <% } else { %>
                        FREE
                    <% } %>
                </span>
            </div>
            <div class="summary-row summary-total">
                <span>Total</span>
                <span>&#8377;<%= String.format("%.2f", total) %></span>
            </div>
            <br>
            <a href="checkout" class="btn btn-primary" style="width: 100%; text-align: center;">Proceed to Checkout</a>
        </div>
        <% } %>
    </div>
</div>

<%@ include file="../partials/footer.jsp" %>