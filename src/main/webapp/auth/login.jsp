<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../partials/header.jsp" %>
<%@ include file="../partials/navbar.jsp" %>

<div class="container" style="display: flex; justify-content: center; align-items: center; min-height: 70vh;">
    <div class="checkout-form" style="width: 400px;">
        <h2 style="text-align: center; margin-bottom: 30px;">Login</h2>
        
        <c:if test="${not empty param.error}">
            <div class="alert alert-error"><c:out value="${param.error}"/></div>
        </c:if>
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success"><c:out value="${param.msg}"/></div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth" method="POST">
            <input type="hidden" name="action" value="login">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <br>
            <button type="submit" class="btn btn-primary" style="width: 100%;">Login</button>
            <p style="text-align: center; margin-top: 20px;">
                Don't have an account? <a href="${pageContext.request.contextPath}/auth/register.jsp" style="color: var(--primary-color);">Register</a>
            </p>
        </form>
    </div>
</div>

<%@ include file="../partials/footer.jsp" %>