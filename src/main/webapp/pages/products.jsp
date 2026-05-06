<%@ page import="java.util.List" %>
<%@ page import="com.electronicstore.model.Category" %>
<%@ page import="com.electronicstore.model.Product" %>
<%@ include file="../partials/header.jsp" %>
<%@ include file="../partials/navbar.jsp" %>

<div class="container">
    <div class="products-page">
        <!-- Sidebar -->
        <aside class="filters-sidebar">
            <div class="filter-group">
                <h3>Categories</h3>
                <% 
                    String currentCat = request.getParameter("category");
                    if (currentCat == null) currentCat = "";
                    currentCat = currentCat.trim();
                %>
                <div class="filter-option <%= currentCat.isEmpty() ? "active" : "" %>" onclick="filterByCategory('')">
                    <span>All Categories</span>
                </div>
                <% 
                    List<Category> categories = (List<Category>) request.getAttribute("categories");
                    if (categories != null) {
                        for (Category cat : categories) {
                            String catId = String.valueOf(cat.getId()).trim();
                            boolean isActive = catId.equals(currentCat);
                %>
                    <div class="filter-option <%= isActive ? "active" : "" %>" onclick="filterByCategory(<%= cat.getId() %>)">
                        <span><%= cat.getName() %></span>
                    </div>
                <% } } %>
            </div>

            <div class="filter-group">
                <h3>Price Range</h3>
                <form id="priceFilterForm">
                    <div class="form-group">
                        <input type="number" name="minPrice" class="form-control" placeholder="Min" value="<%= request.getParameter("minPrice") != null ? request.getParameter("minPrice") : "" %>">
                    </div>
                    <div class="form-group">
                        <input type="number" name="maxPrice" class="form-control" placeholder="Max" value="<%= request.getParameter("maxPrice") != null ? request.getParameter("maxPrice") : "" %>">
                    </div>
                    <button type="submit" class="btn btn-outline" style="width:100%">Apply</button>
                </form>
            </div>

            <div class="filter-group">
                <h3>Sort By</h3>
                <select id="sortSelect" class="form-control" style="width: 100%; padding: 8px; border-radius: 8px; border: 1px solid var(--border-color);">
                    <option value="asc" <%= "asc".equals(request.getParameter("sort")) ? "selected" : "" %>>Price: Low to High</option>
                    <option value="desc" <%= "desc".equals(request.getParameter("sort")) ? "selected" : "" %>>Price: High to Low</option>
                </select>
            </div>
        </aside>

        <!-- Product Grid -->
        <main style="flex: 1;">
            <div class="section-title">
                <h2>Products</h2>
            </div>
            <div class="product-grid">
                <% 
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    if (products != null && !products.isEmpty()) {
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
                    } else {
                %>
                    <p>No products found matching your criteria.</p>
                <% } %>
            </div>
        </main>
    </div>
</div>

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

document.addEventListener('DOMContentLoaded', function() {
    const params = new URLSearchParams(window.location.search);
    const catId = (params.get('category') || '').trim();
    
    document.querySelectorAll('.filter-option').forEach(option => {
        const onclick = option.getAttribute('onclick');
        if (onclick) {
            const isAllCategories = catId === '' && onclick.includes("filterByCategory('')");
            const isSpecificCategory = catId !== '' && onclick.includes('filterByCategory(' + catId + ')');

            if (isAllCategories || isSpecificCategory) {
                option.classList.add('active');
                option.style.backgroundColor = 'var(--primary-color)';
                option.style.color = 'white';
                option.style.fontWeight = '700';
                const span = option.querySelector('span');
                if (span) span.style.color = 'white';
            }
        }
    });
});
</script>

<%@ include file="../partials/footer.jsp" %>