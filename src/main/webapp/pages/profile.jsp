<%@ page import="com.electronicstore.model.User" %>
<%@ page import="com.electronicstore.model.Address" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../partials/header.jsp" %>
<%@ include file="../partials/navbar.jsp" %>

<% 
    User u = (User) request.getAttribute("user");
    Address defaultAddress = (Address) request.getAttribute("defaultAddress");
%>

<div class="container" style="padding-top: 40px; padding-bottom: 60px;">
    <div style="margin-bottom: 30px;">
        <h1 style="font-size: 2rem; font-weight: 500;">Your Account</h1>
    </div>

    <!-- Amazon Style Dashboard Cards -->
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin-bottom: 40px;">
        <!-- Card 1: Your Orders -->
        <a href="${pageContext.request.contextPath}/orders" style="display: flex; gap: 15px; padding: 20px; border: 1px solid #ddd; border-radius: 8px; text-decoration: none; color: inherit; transition: background 0.2s;">
            <div style="font-size: 40px;">&#128230;</div>
            <div>
                <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 5px;">Your Orders</h3>
                <p style="font-size: 0.9rem; color: #64748b;">Track, return, or buy things again</p>
            </div>
        </a>

        <!-- Card 2: Login & Security -->
        <a href="${pageContext.request.contextPath}/security" style="display: flex; gap: 15px; padding: 20px; border: 1px solid #ddd; border-radius: 8px; text-decoration: none; color: inherit; transition: background 0.2s;">
            <div style="font-size: 40px;">&#128737;</div>
            <div>
                <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 5px;">Login & Security</h3>
                <p style="font-size: 0.9rem; color: #64748b;">Edit login, name, and mobile number</p>
            </div>
        </a>

        <!-- Card 3: Your Addresses -->
        <a href="${pageContext.request.contextPath}/addresses" style="display: flex; gap: 15px; padding: 20px; border: 1px solid #ddd; border-radius: 8px; text-decoration: none; color: inherit; transition: background 0.2s;">
            <div style="font-size: 40px;">&#128205;</div>
            <div>
                <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 5px;">Your Addresses</h3>
                <p style="font-size: 0.9rem; color: #64748b;">Edit addresses for orders and gifts</p>
            </div>
        </a>
    </div>

    <div style="background: white; border: 1px solid #ddd; border-radius: 8px; width: 100%;">
        <div style="padding: 20px; border-bottom: 1px solid #ddd;">
            <h2 style="font-size: 1.5rem; font-weight: 500;">Profile Details</h2>
        </div>
        
        <div style="padding: 25px;">
            <div class="form-group" style="margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #f1f5f9; padding-bottom: 15px;">
                <div style="flex: 1;">
                    <label style="font-weight: 700; font-size: 0.9rem; display: block; margin-bottom: 5px;">Name</label>
                    <p style="font-size: 1rem; color: #111; margin: 0;"><%= u.getFullName() != null ? u.getFullName() : "" %></p>
                </div>
                <a href="${pageContext.request.contextPath}/security" style="color: #0066c0; font-size: 0.9rem; text-decoration: none;">Edit</a>
            </div>

            <div class="form-group" style="margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #f1f5f9; padding-bottom: 15px;">
                <div style="flex: 1;">
                    <label style="font-weight: 700; font-size: 0.9rem; display: block; margin-bottom: 5px;">Email</label>
                    <p style="font-size: 1rem; color: #111; margin: 0;"><%= u.getEmail() %></p>
                </div>
                <a href="${pageContext.request.contextPath}/security" style="color: #0066c0; font-size: 0.9rem; text-decoration: none;">Edit</a>
            </div>

            <div class="form-group" style="margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #f1f5f9; padding-bottom: 15px;">
                <div style="flex: 1;">
                    <label style="font-weight: 700; font-size: 0.9rem; display: block; margin-bottom: 5px;">Mobile Number</label>
                    <p style="font-size: 1rem; color: #111; margin: 0;"><%= u.getPhone() != null && !u.getPhone().isEmpty() ? u.getPhone() : "Not provided" %></p>
                </div>
                <a href="${pageContext.request.contextPath}/security" style="color: #0066c0; font-size: 0.9rem; text-decoration: none;">Edit</a>
            </div>

            <div class="form-group" style="margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #f1f5f9; padding-bottom: 15px;">
                <div style="flex: 1;">
                    <label style="font-weight: 700; font-size: 0.9rem; display: block; margin-bottom: 5px;">Username</label>
                    <p style="font-size: 1rem; color: #64748b; margin: 0;"><%= u.getUsername() %></p>
                </div>
            </div>

            <div class="form-group" style="margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #f1f5f9; padding-bottom: 15px;">
                <div style="flex: 1;">
                    <label style="font-weight: 700; font-size: 0.9rem; display: block; margin-bottom: 5px;">Member Since</label>
                    <p style="font-size: 1rem; color: #64748b; margin: 0;"><%= u.getCreatedAt() %></p>
                </div>
            </div>

            <div class="form-group" style="margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center;">
                <div style="flex: 1;">
                    <label style="font-weight: 700; font-size: 0.9rem; display: block; margin-bottom: 5px;">Primary Address</label>
                    <p style="font-size: 1rem; color: #64748b; margin: 0;">
                        <% if (defaultAddress != null) { %>
                            <%= defaultAddress.getStreet() %>, <%= defaultAddress.getCity() %>, <%= defaultAddress.getState() %> <%= defaultAddress.getZipCode() %>, <%= defaultAddress.getCountry() %>
                        <% } else { %>
                            No address added yet. <a href="${pageContext.request.contextPath}/addresses" style="color: #0066c0; text-decoration: none;">Add an address</a>
                        <% } %>
                    </p>
                </div>
                <a href="${pageContext.request.contextPath}/addresses" style="color: #0066c0; font-size: 0.9rem; text-decoration: none;">Edit</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="../partials/footer.jsp" %>