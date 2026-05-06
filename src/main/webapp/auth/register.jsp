<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../partials/header.jsp" %>
<%@ include file="../partials/navbar.jsp" %>

<div class="container" style="display: flex; flex-direction: column; align-items: center; padding-top: 50px; padding-bottom: 50px;">
    <!-- Amazon Style Logo (Simple Text for now) -->
    <div style="margin-bottom: 20px;">
        <h1 style="font-size: 2rem; font-weight: 800; color: #1e293b;">ELECTRONIC<span>STORE</span></h1>
    </div>

    <div style="width: 350px; background: white; border: 1px solid #ddd; border-radius: 8px; padding: 25px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
        <h2 style="font-size: 1.8rem; font-weight: 500; margin-bottom: 20px;">Create Account</h2>
        
        <c:if test="${not empty param.error}">
            <div class="alert alert-error" style="margin-bottom: 15px; font-size: 0.9rem;"><c:out value="${param.error}"/></div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth" method="POST" onsubmit="return validateRegisterForm()">
            <input type="hidden" name="action" value="register">
            
            <div class="form-group" style="margin-bottom: 15px;">
                <label style="font-weight: 700; font-size: 0.85rem; display: block; margin-bottom: 5px;">Your name</label>
                <input type="text" name="fullName" class="form-control" placeholder="First and last name" required style="width: 100%; padding: 10px; border: 1px solid #888; border-radius: 3px;">
            </div>

            <div class="form-group" style="margin-bottom: 15px;">
                <label style="font-weight: 700; font-size: 0.85rem; display: block; margin-bottom: 5px;">Username</label>
                <input type="text" name="username" class="form-control" required style="width: 100%; padding: 10px; border: 1px solid #888; border-radius: 3px;">
            </div>

            <div class="form-group" style="margin-bottom: 15px;">
                <label style="font-weight: 700; font-size: 0.85rem; display: block; margin-bottom: 5px;">Mobile number</label>
                <input type="text" name="phone" class="form-control" placeholder="Mobile number" required style="width: 100%; padding: 10px; border: 1px solid #888; border-radius: 3px;">
            </div>

            <div class="form-group" style="margin-bottom: 15px;">
                <label style="font-weight: 700; font-size: 0.85rem; display: block; margin-bottom: 5px;">Email (optional)</label>
                <input type="email" name="email" class="form-control" required style="width: 100%; padding: 10px; border: 1px solid #888; border-radius: 3px;">
            </div>

            <div class="form-group" style="margin-bottom: 20px;">
                <label style="font-weight: 700; font-size: 0.85rem; display: block; margin-bottom: 5px;">Password</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="At least 6 characters" required style="width: 100%; padding: 10px; border: 1px solid #888; border-radius: 3px;">
                <p style="font-size: 0.75rem; color: #555; margin-top: 4px;">&#9432; Passwords must be at least 6 characters.</p>
            </div>

            <button type="submit" class="btn" style="width: 100%; background: #ffd814; border: 1px solid #fcd200; border-radius: 8px; padding: 10px; font-weight: 500; cursor: pointer; color: #111;">Continue</button>
            
            <p style="font-size: 0.75rem; margin-top: 15px; color: #111; line-height: 1.4;">
                By creating an account, you agree to ElectronicStore's <a href="#" style="color: #0066c0; text-decoration: none;">Conditions of Use</a> and <a href="#" style="color: #0066c0; text-decoration: none;">Privacy Notice</a>.
            </p>

            <div style="border-top: 1px solid #eee; margin-top: 25px; padding-top: 15px; font-size: 0.85rem;">
                Already have an account? <a href="${pageContext.request.contextPath}/auth/login.jsp" style="color: #0066c0; text-decoration: none;">Sign in &#9656;</a>
            </div>
        </form>
    </div>
</div>

<script>
function validateRegisterForm() {
    var pass = document.getElementById('password').value;
    if (pass.length < 6) {
        alert("Password must be at least 6 characters long.");
        return false;
    }
    return true;
}
</script>

<%@ include file="../partials/footer.jsp" %>