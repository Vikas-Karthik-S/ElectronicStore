<%@ page import="com.electronicstore.model.User" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../partials/header.jsp" %>
<%@ include file="../partials/navbar.jsp" %>

<% 
    User u = (User) request.getAttribute("user");
%>

<div class="container" style="padding-top: 40px; padding-bottom: 60px; max-width: 800px;">
    <div style="margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center;">
        <h1 style="font-size: 2rem; font-weight: 500;">Login & Security</h1>
        <a href="${pageContext.request.contextPath}/profile" style="color: #0066c0; text-decoration: none;">Back to Profile</a>
    </div>

    <c:if test="${not empty param.msg}">
        <div class="alert alert-success" style="margin-bottom: 20px;"><c:out value="${param.msg}"/></div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-error" style="margin-bottom: 20px;"><c:out value="${param.error}"/></div>
    </c:if>

    <div style="background: white; border: 1px solid #ddd; border-radius: 8px; width: 100%;">
        
        <!-- Name Section -->
        <div style="padding: 20px; border-bottom: 1px solid #ddd;">
            <div id="nameDisplay" style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h3 style="font-weight: 700; font-size: 1rem; margin-bottom: 5px;">Name</h3>
                    <p style="color: #475569; margin: 0;"><%= u.getFullName() != null ? u.getFullName() : "" %></p>
                </div>
                <button onclick="toggleEdit('name')" class="btn" style="background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 8px; padding: 8px 20px; cursor: pointer; font-weight: 500;">Edit</button>
            </div>
            <div id="nameEdit" style="display: none; margin-top: 15px;">
                <h3 style="font-weight: 700; font-size: 1rem; margin-bottom: 15px;">Change your name</h3>
                <form action="${pageContext.request.contextPath}/security" method="POST">
                    <input type="hidden" name="action" value="updateName">
                    <div class="form-group" style="margin-bottom: 15px;">
                        <label style="font-weight: 500; font-size: 0.9rem; display: block; margin-bottom: 5px;">New name</label>
                        <input type="text" name="fullName" class="form-control" value="<%= u.getFullName() != null ? u.getFullName() : "" %>" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px;">
                    </div>
                    <button type="submit" class="btn" style="background: #ffd814; border: 1px solid #fcd200; border-radius: 8px; padding: 10px 20px; font-weight: 500; cursor: pointer;">Save changes</button>
                </form>
            </div>
        </div>

        <!-- Email Section -->
        <div style="padding: 20px; border-bottom: 1px solid #ddd;">
            <div id="emailDisplay" style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h3 style="font-weight: 700; font-size: 1rem; margin-bottom: 5px;">Email</h3>
                    <p style="color: #475569; margin: 0;"><%= u.getEmail() %></p>
                </div>
                <button onclick="toggleEdit('email')" class="btn" style="background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 8px; padding: 8px 20px; cursor: pointer; font-weight: 500;">Edit</button>
            </div>
            <div id="emailEdit" style="display: none; margin-top: 15px;">
                <h3 style="font-weight: 700; font-size: 1rem; margin-bottom: 15px;">Change your email address</h3>
                <form action="${pageContext.request.contextPath}/security" method="POST">
                    <input type="hidden" name="action" value="updateEmail">
                    <div class="form-group" style="margin-bottom: 15px;">
                        <label style="font-weight: 500; font-size: 0.9rem; display: block; margin-bottom: 5px;">New email address</label>
                        <input type="email" name="email" class="form-control" value="<%= u.getEmail() %>" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px;">
                    </div>
                    <button type="submit" class="btn" style="background: #ffd814; border: 1px solid #fcd200; border-radius: 8px; padding: 10px 20px; font-weight: 500; cursor: pointer;">Save changes</button>
                </form>
            </div>
        </div>

        <!-- Phone Section -->
        <div style="padding: 20px; border-bottom: 1px solid #ddd;">
            <div id="phoneDisplay" style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h3 style="font-weight: 700; font-size: 1rem; margin-bottom: 5px;">Mobile Number</h3>
                    <p style="color: #475569; margin: 0;"><%= u.getPhone() != null && !u.getPhone().isEmpty() ? u.getPhone() : "Not provided" %></p>
                </div>
                <button onclick="toggleEdit('phone')" class="btn" style="background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 8px; padding: 8px 20px; cursor: pointer; font-weight: 500;">Edit</button>
            </div>
            <div id="phoneEdit" style="display: none; margin-top: 15px;">
                <h3 style="font-weight: 700; font-size: 1rem; margin-bottom: 15px;">Change your mobile number</h3>
                <form action="${pageContext.request.contextPath}/security" method="POST">
                    <input type="hidden" name="action" value="updatePhone">
                    <div class="form-group" style="margin-bottom: 15px;">
                        <label style="font-weight: 500; font-size: 0.9rem; display: block; margin-bottom: 5px;">New mobile number</label>
                        <input type="text" name="phone" class="form-control" value="<%= u.getPhone() != null ? u.getPhone() : "" %>" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px;">
                    </div>
                    <button type="submit" class="btn" style="background: #ffd814; border: 1px solid #fcd200; border-radius: 8px; padding: 10px 20px; font-weight: 500; cursor: pointer;">Save changes</button>
                </form>
            </div>
        </div>

        <!-- Password Section -->
        <div style="padding: 20px;">
            <div id="passwordDisplay" style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h3 style="font-weight: 700; font-size: 1rem; margin-bottom: 5px;">Password</h3>
                    <p style="color: #475569; margin: 0;">********</p>
                </div>
                <button onclick="toggleEdit('password')" class="btn" style="background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 8px; padding: 8px 20px; cursor: pointer; font-weight: 500;">Edit</button>
            </div>
            <div id="passwordEdit" style="display: none; margin-top: 15px;">
                <h3 style="font-weight: 700; font-size: 1rem; margin-bottom: 15px;">Change password</h3>
                <form action="${pageContext.request.contextPath}/security" method="POST">
                    <input type="hidden" name="action" value="updatePassword">
                    <div class="form-group" style="margin-bottom: 15px;">
                        <label style="font-weight: 500; font-size: 0.9rem; display: block; margin-bottom: 5px;">Current password</label>
                        <input type="password" name="currentPassword" class="form-control" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px;">
                    </div>
                    <div class="form-group" style="margin-bottom: 15px;">
                        <label style="font-weight: 500; font-size: 0.9rem; display: block; margin-bottom: 5px;">New password</label>
                        <input type="password" name="newPassword" class="form-control" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px;" minlength="6">
                    </div>
                    <div class="form-group" style="margin-bottom: 15px;">
                        <label style="font-weight: 500; font-size: 0.9rem; display: block; margin-bottom: 5px;">Confirm new password</label>
                        <input type="password" name="confirmPassword" class="form-control" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px;" minlength="6">
                    </div>
                    <button type="submit" class="btn" style="background: #ffd814; border: 1px solid #fcd200; border-radius: 8px; padding: 10px 20px; font-weight: 500; cursor: pointer;">Save changes</button>
                </form>
            </div>
        </div>

    </div>

    <script>
        function toggleEdit(section) {
            // Hide all edits and show all displays
            const sections = ['name', 'email', 'phone', 'password'];
            sections.forEach(s => {
                document.getElementById(s + 'Edit').style.display = 'none';
                document.getElementById(s + 'Display').style.display = 'flex';
            });

            // Show the requested edit and hide its display
            document.getElementById(section + 'Display').style.display = 'none';
            document.getElementById(section + 'Edit').style.display = 'block';
        }
    </script>
</div>

<%@ include file="../partials/footer.jsp" %>
