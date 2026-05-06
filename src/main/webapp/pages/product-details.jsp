<%@ page import="com.electronicstore.model.Product" %>
<%@ page import="com.electronicstore.model.ProductSpecification" %>
<%@ page import="java.util.List" %>
<%@ include file="../partials/header.jsp" %>
<%@ include file="../partials/navbar.jsp" %>

<div class="container">
    <% 
        Product p = (Product) request.getAttribute("product");
        if (p != null) {
    %>
        <div class="product-detail-container">
            <div class="detail-image">
                <img src="${pageContext.request.contextPath}/assets/images/products/<%= p.getImageUrl() %>" alt="<%= p.getName() %>">
            </div>
            <div class="detail-info">
                <span class="product-brand"><%= p.getBrand() %></span>
                <h1><%= p.getName() %></h1>
                <p class="detail-price">&#8377;<%= p.getPrice() %></p>
                <div class="detail-description">
                    <p><%= p.getDescription() %></p>
                </div>
                
                <div style="margin-top: 30px;">
                    <p><strong>Availability:</strong> <%= p.getStock() > 0 ? "In Stock (" + p.getStock() + ")" : "Out of Stock" %></p>
                </div>

                <div style="margin-top: 30px; display: flex; gap: 20px; align-items: center;">
                    <% if (session.getAttribute("user") != null) { %>
                        <input type="number" id="qty" value="1" min="1" max="<%= p.getStock() %>" class="form-control" style="width: 80px;">
                        <button class="btn btn-primary" onclick="addToCart(<%= p.getId() %>, document.getElementById('qty').value)">Add to Cart</button>
                    <% } else { %>
                        <a href="${pageContext.request.contextPath}/auth/login.jsp" class="btn btn-primary" style="padding: 12px 30px;">Login to Purchase</a>
                    <% } %>
                </div>

                <table class="specs-table">
                    <thead>
                        <tr>
                            <th colspan="2">Specifications</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<ProductSpecification> specs = (List<ProductSpecification>) request.getAttribute("specifications");
                            if (specs != null) {
                                for (ProductSpecification spec : specs) {
                        %>
                            <tr>
                                <th><%= spec.getSpecName() %></th>
                                <td><%= spec.getSpecValue() %></td>
                            </tr>
                        <% } } %>
                    </tbody>
                </table>
            </div>
        </div>
    <% } %>
</div>

<%@ include file="../partials/footer.jsp" %>