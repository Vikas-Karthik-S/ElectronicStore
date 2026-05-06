<%@ page import="java.util.List" %>
<%@ page import="com.electronicstore.model.CartItem" %>
<%@ page import="com.electronicstore.model.Product" %>
<%@ page import="com.electronicstore.model.Address" %>
<%@ page import="com.electronicstore.model.User" %>
<%@ page import="com.electronicstore.service.ProductService" %>
<%@ page import="com.electronicstore.util.SessionUtil" %>
<%@ include file="../partials/header.jsp" %>
<%@ include file="../partials/navbar.jsp" %>

<%
    User user = SessionUtil.getLoggedInUser(request);
    Address defAddr = (Address) request.getAttribute("defaultAddress");
    List<CartItem> items = (List<CartItem>) request.getAttribute("cartItems");
    double total = 0;
    ProductService ps = new ProductService();
    if (items != null) {
        for (CartItem item : items) {
            Product p = ps.getProductById(item.getProductId());
            if (p != null) {
                total += p.getPrice() * item.getQuantity();
            }
        }
    }
%>

<div class="container" style="padding-top: 40px;">
    <div style="margin-bottom: 20px;">
        <a href="cart" style="color: var(--primary-color); font-weight: 600; display: flex; align-items: center; gap: 5px; text-decoration: none;">
            &#8592; Back to Cart
        </a>
    </div>
    <div style="margin-bottom: 30px;">
        <h1 style="font-size: 2rem; font-weight: 700;">Checkout</h1>
    </div>

    <div style="display: grid; grid-template-columns: 1fr 350px; gap: 30px; align-items: start;">
        <!-- Main Checkout Sections -->
        <div>
            <form id="checkoutForm" action="checkout" method="POST">
                <!-- 1. Shipping Address Section -->
                <div style="background: white; border-radius: 8px; border: 1px solid var(--border-color); margin-bottom: 20px;">
                    <div style="padding: 20px; border-bottom: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center;">
                        <h2 style="font-size: 1.2rem; font-weight: 700;">1. Shipping Address</h2>
                    </div>
                    <div style="padding: 20px;">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                            <div class="form-group">
                                <label style="font-weight: 600; font-size: 0.9rem; margin-bottom: 8px; display: block;">Full Name</label>
                                <input type="text" name="fullName" class="form-control" value="<%= user.getFullName() != null ? user.getFullName() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label style="font-weight: 600; font-size: 0.9rem; margin-bottom: 8px; display: block;">Phone Number</label>
                                <input type="text" name="phone" class="form-control" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" required>
                            </div>
                        </div>
                        
                        <div class="form-group" style="margin-bottom: 20px;">
                            <label style="font-weight: 600; font-size: 0.9rem; margin-bottom: 8px; display: block;">Street Address</label>
                            <input type="text" name="street" class="form-control" value="<%= defAddr != null ? defAddr.getStreet() : "" %>" required placeholder="Flat, House no., Building, Company, Apartment">
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px;">
                            <div class="form-group">
                                <label style="font-weight: 600; font-size: 0.9rem; margin-bottom: 8px; display: block;">City</label>
                                <input type="text" name="city" class="form-control" value="<%= defAddr != null ? defAddr.getCity() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label style="font-weight: 600; font-size: 0.9rem; margin-bottom: 8px; display: block;">State</label>
                                <input type="text" name="state" class="form-control" value="<%= defAddr != null ? defAddr.getState() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label style="font-weight: 600; font-size: 0.9rem; margin-bottom: 8px; display: block;">ZIP Code</label>
                                <input type="text" name="zipCode" class="form-control" value="<%= defAddr != null ? defAddr.getZipCode() : "" %>" required>
                            </div>
                        </div>
                        <input type="hidden" name="country" value="<%= defAddr != null ? defAddr.getCountry() : "India" %>">
                    </div>
                </div>

                <!-- 2. Shipping Method -->
                <div style="background: white; border-radius: 8px; border: 1px solid var(--border-color); margin-bottom: 20px;">
                    <div style="padding: 20px; border-bottom: 1px solid var(--border-color);">
                        <h2 style="font-size: 1.2rem; font-weight: 700;">2. Shipping Method</h2>
                    </div>
                    <div style="padding: 20px;">
                        <div style="display: flex; flex-direction: column; gap: 15px;">
                            <div style="display: flex; align-items: center; justify-content: space-between; padding: 15px; border: 1px solid var(--border-color); border-radius: 8px;">
                                <div style="display: flex; align-items: center; gap: 10px;">
                                    <input type="radio" name="shippingMethod" id="standard" value="standard" checked onchange="updateShipping()">
                                    <label for="standard" style="font-weight: 600; cursor: pointer;">Standard Shipping (3-5 business days)</label>
                                </div>
                                <span style="font-weight: 600;">
                                    <% if (total >= 500) { %> Free <% } else { %> &#8377;40.00 <% } %>
                                </span>
                            </div>
                            <div style="display: flex; align-items: center; justify-content: space-between; padding: 15px; border: 1px solid var(--border-color); border-radius: 8px;">
                                <div style="display: flex; align-items: center; gap: 10px;">
                                    <input type="radio" name="shippingMethod" id="express" value="express" onchange="updateShipping()">
                                    <label for="express" style="font-weight: 600; cursor: pointer;">Express Shipping (1-2 business days)</label>
                                </div>
                                <span style="font-weight: 600;">&#8377;100.00</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 3. Payment Method (Simulated) -->
                <div style="background: white; border-radius: 8px; border: 1px solid var(--border-color); margin-bottom: 20px;">
                    <div style="padding: 20px; border-bottom: 1px solid var(--border-color);">
                        <h2 style="font-size: 1.2rem; font-weight: 700;">3. Payment Method</h2>
                    </div>
                    <div style="padding: 20px;">
                        <div style="display: flex; align-items: center; gap: 10px; padding: 15px; border: 1px solid #fbbf24; background: #fffbeb; border-radius: 8px;">
                            <input type="radio" checked name="payment" id="cod">
                            <label for="cod" style="font-weight: 600; cursor: pointer;">Cash on Delivery (COD)</label>
                        </div>
                    </div>
                </div>

                <!-- 4. Review items and shipping -->
                <div style="background: white; border-radius: 8px; border: 1px solid var(--border-color);">
                    <div style="padding: 20px; border-bottom: 1px solid var(--border-color);">
                        <h2 style="font-size: 1.2rem; font-weight: 700;">4. Review items and shipping</h2>
                    </div>
                    <div style="padding: 20px;">
                        <% 
                            if (items != null) {
                                for (CartItem item : items) {
                                    Product p = ps.getProductById(item.getProductId());
                                    if (p != null) {
                                        // total is already calculated from before
                        %>
                            <div style="display: flex; gap: 20px; margin-bottom: 20px; padding-bottom: 20px; border-bottom: 1px solid #f1f5f9;">
                                <img src="${pageContext.request.contextPath}/assets/images/products/<%= p.getImageUrl() %>" style="width: 80px; height: 80px; object-fit: contain; border-radius: 8px;">
                                <div>
                                    <h4 style="font-weight: 600; margin-bottom: 5px;"><%= p.getName() %></h4>
                                    <p style="color: #ef4444; font-weight: 700;">&#8377;<%= p.getPrice() %></p>
                                    <p style="font-size: 0.9rem; color: #64748b;">Quantity: <%= item.getQuantity() %></p>
                                </div>
                            </div>
                        <% } } } %>
                        <%
                            double standardShipping = (total > 0 && total < 500) ? 40.0 : 0.0;
                            double finalTotal = total + standardShipping;
                        %>
                        <input type="hidden" name="totalAmount" id="totalAmountInput" value="<%= finalTotal %>">
                    </div>
                </div>
            </form>
        </div>

        <!-- Right Sidebar (Amazon Style Order Summary) -->
        <div style="position: sticky; top: 100px;">
            <div style="background: white; border-radius: 8px; border: 1px solid var(--border-color); padding: 20px;">
                <button type="button" onclick="document.getElementById('checkoutForm').submit()" class="btn btn-primary" style="width: 100%; padding: 12px; margin-bottom: 10px; background: #fbbf24; border-color: #f59e0b; color: #1e293b;">Place your order</button>
                <a href="cart" class="btn btn-outline" style="width: 100%; text-align: center; margin-bottom: 20px; display: block; font-size: 0.9rem; padding: 10px;">Review or edit cart</a>
                <p style="font-size: 0.8rem; text-align: center; color: #64748b; margin-bottom: 20px;">By placing your order, you agree to ElectronicStore's privacy notice and conditions of use.</p>
                
                <div style="border-top: 1px solid var(--border-color); padding-top: 15px;">
                    <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 15px;">Order Summary</h3>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 0.9rem;">
                        <span>Items:</span>
                        <span>&#8377;<%= String.format("%.2f", total) %></span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 0.9rem;">
                        <span>Shipping:</span>
                        <span id="summaryShipping">&#8377;<%= String.format("%.2f", standardShipping) %></span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 15px; font-size: 0.9rem; color: #16a34a;">
                        <span>Promotion Applied:</span>
                        <span>-&#8377;0.00</span>
                    </div>
                    <div style="border-top: 1px solid #fee2e2; padding-top: 15px; display: flex; justify-content: space-between; font-size: 1.2rem; font-weight: 800; color: #991b1b;">
                        <span>Order Total:</span>
                        <span id="summaryTotal">&#8377;<%= String.format("%.2f", finalTotal) %></span>
                    </div>
                    </div>
                </div>
            </div>
            
            <div style="margin-top: 20px; padding: 15px; background: #f8fafc; border: 1px solid var(--border-color); border-radius: 8px;">
                <p style="font-size: 0.85rem; color: #475569;"><strong>How are shipping costs calculated?</strong><br>Shipping is free for all orders above &#8377;500.</p>
            </div>
        </div>
    </div>
</div>

<script>
    const baseTotal = <%= total %>;
    const standardCost = (baseTotal > 0 && baseTotal < 500) ? 40.0 : 0.0;
    const expressCost = 100.0;

    function updateShipping() {
        const method = document.querySelector('input[name="shippingMethod"]:checked').value;
        let shipping = 0;
        
        if (method === 'express') {
            shipping = expressCost;
        } else {
            shipping = standardCost;
        }
        
        const newTotal = baseTotal + shipping;
        
        document.getElementById('summaryShipping').innerText = '\u20B9' + shipping.toFixed(2);
        document.getElementById('summaryTotal').innerText = '\u20B9' + newTotal.toFixed(2);
        document.getElementById('totalAmountInput').value = newTotal;
    }
</script>

<%@ include file="../partials/footer.jsp" %>