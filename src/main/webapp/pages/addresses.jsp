<%@ page import="com.electronicstore.model.User" %>
<%@ page import="com.electronicstore.model.Address" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../partials/header.jsp" %>
<%@ include file="../partials/navbar.jsp" %>

<div class="container" style="padding-top: 40px; padding-bottom: 60px;">
    <div style="margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center;">
        <h1 style="font-size: 2rem; font-weight: 500;">Your Addresses</h1>
        <a href="${pageContext.request.contextPath}/profile" style="color: #0066c0; text-decoration: none;">Back to Profile</a>
    </div>

    <c:if test="${not empty param.msg}">
        <div class="alert alert-success" style="margin-bottom: 20px;"><c:out value="${param.msg}"/></div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-error" style="margin-bottom: 20px;"><c:out value="${param.error}"/></div>
    </c:if>

    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; margin-bottom: 40px;">
        
        <!-- Add New Address Card -->
        <div style="border: 2px dashed #ccc; border-radius: 8px; padding: 20px; display: flex; flex-direction: column; align-items: center; justify-content: center; cursor: pointer; min-height: 200px; color: #64748b;" onclick="resetForm(); document.getElementById('addAddressForm').style.display='block'; window.scrollTo({top: document.getElementById('addAddressForm').offsetTop, behavior: 'smooth'});">
            <div style="font-size: 40px; margin-bottom: 10px;">+</div>
            <h3 style="font-size: 1.2rem; font-weight: 500;">Add Address</h3>
        </div>

        <% 
            List<Address> addresses = (List<Address>) request.getAttribute("addresses");
            if (addresses != null) {
                for (Address addr : addresses) {
        %>
        <div style="border: 1px solid #ddd; border-radius: 8px; padding: 20px; display: flex; flex-direction: column; justify-content: space-between; min-height: 200px;">
            <div>
                <% if (addr.isDefault()) { %>
                    <span style="font-size: 0.8rem; background: #f1f5f9; padding: 3px 8px; border-radius: 4px; color: #475569; margin-bottom: 10px; display: inline-block;">Default</span>
                <% } %>
                <p style="margin: 0 0 5px 0; font-weight: 500;"><%= addr.getStreet() %></p>
                <p style="margin: 0 0 5px 0; color: #475569;"><%= addr.getCity() %>, <%= addr.getState() %></p>
                <p style="margin: 0 0 5px 0; color: #475569;"><%= addr.getZipCode() %></p>
                <p style="margin: 0 0 5px 0; color: #475569;"><%= addr.getCountry() %></p>
            </div>
            <div style="display: flex; gap: 15px; margin-top: 15px; border-top: 1px solid #eee; padding-top: 15px;">
                <a href="#" onclick="editAddress(<%= addr.getId() %>, '<%= addr.getStreet() %>', '<%= addr.getCity() %>', '<%= addr.getState() %>', '<%= addr.getZipCode() %>', '<%= addr.getCountry() %>', <%= addr.isDefault() %>); return false;" style="color: #0066c0; text-decoration: none; font-size: 0.9rem;">Edit</a>
                <form action="${pageContext.request.contextPath}/addresses" method="POST" style="display:inline; margin:0;" onsubmit="return confirm('Are you sure you want to remove this address?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= addr.getId() %>">
                    <button type="submit" style="color: #0066c0; background: none; border: none; padding: 0; font-size: 0.9rem; cursor: pointer; font-family: inherit;">Remove</button>
                </form>
            </div>
        </div>
        <%      }
            } 
        %>
    </div>

    <!-- Add Address Form (Hidden by default) -->
    <div id="addAddressForm" style="display: none; background: white; border: 1px solid #ddd; border-radius: 8px; padding: 25px; margin-top: 20px;">
        <h2 id="formTitle" style="font-size: 1.5rem; font-weight: 500; margin-bottom: 20px;">Add a new address</h2>
        <form action="${pageContext.request.contextPath}/addresses" method="POST">
            <input type="hidden" name="action" id="addressAction" value="add">
            <input type="hidden" name="id" id="addressId" value="">
            
            <div class="form-group" style="margin-bottom: 15px;">
                <label style="font-weight: 700; font-size: 0.9rem; display: block; margin-bottom: 5px;">Street</label>
                <input type="text" name="street" id="streetInput" class="form-control" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px;">
            </div>
            <div style="display: flex; gap: 15px; margin-bottom: 15px;">
                <div class="form-group" style="flex: 1;">
                    <label style="font-weight: 700; font-size: 0.9rem; display: block; margin-bottom: 5px;">City</label>
                    <input type="text" name="city" id="cityInput" class="form-control" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px;">
                </div>
                <div class="form-group" style="flex: 1;">
                    <label style="font-weight: 700; font-size: 0.9rem; display: block; margin-bottom: 5px;">State</label>
                    <input type="text" name="state" id="stateInput" class="form-control" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px;">
                </div>
            </div>
            <div style="display: flex; gap: 15px; margin-bottom: 15px;">
                <div class="form-group" style="flex: 1;">
                    <label style="font-weight: 700; font-size: 0.9rem; display: block; margin-bottom: 5px;">Zip Code</label>
                    <input type="text" name="zipCode" id="zipInput" class="form-control" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px;">
                </div>
                <div class="form-group" style="flex: 1;">
                    <label style="font-weight: 700; font-size: 0.9rem; display: block; margin-bottom: 5px;">Country</label>
                    <input type="text" name="country" id="countryInput" class="form-control" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px;">
                </div>
            </div>
            <div class="form-group" style="margin-bottom: 20px;">
                <label style="display: flex; align-items: center; gap: 8px; font-size: 0.9rem; cursor: pointer;">
                    <input type="checkbox" name="isDefault" id="defaultInput" value="true">
                    Make this my default address
                </label>
            </div>
            <div style="display: flex; gap: 15px;">
                <button type="submit" id="submitBtn" class="btn" style="background: #ffd814; border: 1px solid #fcd200; border-radius: 8px; padding: 10px 20px; font-weight: 500; cursor: pointer; color: #111;">Add Address</button>
                <button type="button" class="btn" onclick="resetForm(); document.getElementById('addAddressForm').style.display='none'" style="background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 8px; padding: 10px 20px; font-weight: 500; cursor: pointer; color: #111;">Cancel</button>
            </div>
        </form>
    </div>
    <script>
        function editAddress(id, street, city, state, zip, country, isDefault) {
            document.getElementById('addAddressForm').style.display = 'block';
            document.getElementById('formTitle').innerText = 'Edit address';
            document.getElementById('submitBtn').innerText = 'Update Address';
            
            document.getElementById('addressAction').value = 'update';
            document.getElementById('addressId').value = id;
            
            document.getElementById('streetInput').value = street;
            document.getElementById('cityInput').value = city;
            document.getElementById('stateInput').value = state;
            document.getElementById('zipInput').value = zip;
            document.getElementById('countryInput').value = country;
            document.getElementById('defaultInput').checked = isDefault;
            
            window.scrollTo({top: document.getElementById('addAddressForm').offsetTop, behavior: 'smooth'});
        }

        function resetForm() {
            document.getElementById('formTitle').innerText = 'Add a new address';
            document.getElementById('submitBtn').innerText = 'Add Address';
            
            document.getElementById('addressAction').value = 'add';
            document.getElementById('addressId').value = '';
            
            document.getElementById('streetInput').value = '';
            document.getElementById('cityInput').value = '';
            document.getElementById('stateInput').value = '';
            document.getElementById('zipInput').value = '';
            document.getElementById('countryInput').value = '';
            document.getElementById('defaultInput').checked = false;
        }
    </script>
</div>

<%@ include file="../partials/footer.jsp" %>
