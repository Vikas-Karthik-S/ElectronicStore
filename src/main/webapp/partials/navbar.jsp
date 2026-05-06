<%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <header>
        <div class="container">
            <nav class="navbar">
                <a href="${pageContext.request.contextPath}/home" class="logo">ELECTRONIC<span>STORE</span></a>

                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/home" class="nav-item">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/products" class="nav-item">Shop</a></li>
                    <li><a href="${pageContext.request.contextPath}/home#categories" class="nav-item">Categories</a>
                    </li>
                </ul>

                <div class="nav-icons">
                    <div class="search-bar">
                        <input type="text" id="searchInput" placeholder="Search tech..."
                            onkeypress="if(event.key === 'Enter') searchProducts()">
                        <button onclick="searchProducts()">&#128269;</button>
                    </div>

                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <a href="${pageContext.request.contextPath}/cart" class="nav-icon">
                                &#128722; Cart
                            </a>
                            <div class="user-dropdown">
                                <div class="dropdown-toggle">
                                    &#128100; Hi,
                                    <c:out value="${sessionScope.user.fullName}" /> &#9662;
                                </div>
                                <div class="dropdown-menu">
                                    <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">My
                                        Profile</a>
                                    <a href="${pageContext.request.contextPath}/orders" class="dropdown-item">My
                                        Orders</a>
                                    <div class="dropdown-divider"></div>
                                    <a href="${pageContext.request.contextPath}/logout" class="dropdown-item"
                                        style="color: #ef4444;">Logout</a>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/auth/login.jsp"
                                class="btn btn-primary">Login</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </nav>
        </div>
    </header>