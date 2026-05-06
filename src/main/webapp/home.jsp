<%@ page import="java.util.List" %>
<%@ page import="com.electronicstore.model.Category" %>
<%@ page import="com.electronicstore.model.Product" %>
<%@ include file="partials/header.jsp" %>
<%@ include file="partials/navbar.jsp" %>

<main class="container">
    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h1>The Future of <br>Tech is Here.</h1>
            <p>Experience the latest gadgets and electronics with premium quality and unmatched performance.</p>
            <br>
            <a href="products" class="btn btn-primary">Shop Now</a>
        </div>
    </section>

    <!-- Categories Section -->
    <section id="categories">
        <div class="section-title">
            <h2>Shop by Category</h2>
        </div>
        <div class="category-grid">
            <% 
                List<Category> categories = (List<Category>) request.getAttribute("categories");
                if (categories != null) {
                    for (Category cat : categories) {
            %>
                <a href="products?category=<%= cat.getId() %>" class="category-card">
                    <img src="${pageContext.request.contextPath}/assets/images/categories/<%= cat.getImageUrl() %>" alt="<%= cat.getName() %>" style="width: 100%; height: 120px; object-fit: contain; margin-bottom: 15px;">
                    <h3><%= cat.getName() %></h3>
                </a>
            <% 
                    }
                } 
            %>
        </div>
    </section>

    <!-- Featured Products Section -->
    <section id="featured">
        <div class="section-title">
            <h2>Featured Products</h2>
            <a href="products" class="btn btn-outline">View All</a>
        </div>
        <div class="product-grid">
            <% 
                List<Product> products = (List<Product>) request.getAttribute("featuredProducts");
                if (products != null) {
                    for (Product p : products) {
            %>
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/assets/images/products/<%= p.getImageUrl() %>" alt="<%= p.getName() %>" class="product-image">
                    <div class="product-info">
                        <span class="product-brand"><%= p.getBrand() %></span>
                        <h3 class="product-name"><a href="product-details?id=<%= p.getId() %>"><%= p.getName() %></a></h3>
                        <p class="product-price">&#8377;<%= p.getPrice() %></p>
                        <p class="product-description"><%= p.getDescription() != null && !p.getDescription().trim().isEmpty() ? p.getDescription() : "No description available." %></p>
                        <p class="product-stock <%= p.getStock() > 0 ? "stock-in" : "stock-out" %>">
                            <%= p.getStock() > 0 ? "Stock: " + p.getStock() + " available" : "Out of Stock" %>
                        </p>
                        <div style="display: flex; gap: 8px; margin-top: 15px;">
                            <% if (session.getAttribute("user") != null) { %>
                                <button class="btn btn-primary" onclick="addToCart(<%= p.getId() %>)" style="flex: 1; padding: 10px 5px; font-size: 0.85rem;">Add to Cart</button>
                            <% } else { %>
                                <a href="${pageContext.request.contextPath}/auth/login.jsp" class="btn btn-primary" style="flex: 1; text-align: center; padding: 10px 5px; font-size: 0.85rem;">Login to Buy</a>
                            <% } %>
                            <button class="btn btn-outline" onclick="showProductSpecs(<%= p.getId() %>, '<%= p.getName().replace("'", "\\'") %>')" style="flex: 1; padding: 10px 5px; font-size: 0.85rem;">View Details</button>
                        </div>
                    </div>
                </div>
            <% 
                    }
                } 
            %>
        </div>
    </section>
</main>

<!-- Specifications Modal -->
<div id="specsModal" class="modal-overlay" onclick="closeSpecsModal(event)">
    <div class="modal-content" style="max-width: 600px; text-align: left;" onclick="event.stopPropagation()">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 2px solid #f1f5f9; padding-bottom: 15px;">
            <h2 id="modalProductName" style="font-size: 1.5rem; color: var(--primary-color);">Product Specifications</h2>
            <button onclick="closeSpecsModal()" style="background: none; border: none; font-size: 1.5rem; cursor: pointer; color: #64748b;">&times;</button>
        </div>
        <div id="specsContent" style="max-height: 400px; overflow-y: auto;">
            <p style="text-align: center; padding: 20px;">Loading specifications...</p>
        </div>
        <div style="margin-top: 25px; text-align: right;">
            <button class="btn btn-primary" onclick="closeSpecsModal()">Close</button>
        </div>
    </div>
</div>

<script>
function showProductSpecs(productId, productName) {
    const modal = document.getElementById('specsModal');
    const content = document.getElementById('specsContent');
    const nameLabel = document.getElementById('modalProductName');
    
    nameLabel.innerText = productName;
    content.innerHTML = '<p style="text-align: center; padding: 20px;">Loading specifications...</p>';
    modal.classList.add('active');
    
    fetch('${pageContext.request.contextPath}/product-details?ajax=true&id=' + productId)
        .then(response => response.text())
        .then(html => {
            content.innerHTML = html;
        })
        .catch(err => {
            content.innerHTML = '<p style="color: red; padding: 20px;">Error loading specifications. Please try again later.</p>';
        });
}

function closeSpecsModal(event) {
    const modal = document.getElementById('specsModal');
    modal.classList.remove('active');
}
</script>

<%@ include file="partials/footer.jsp" %>
