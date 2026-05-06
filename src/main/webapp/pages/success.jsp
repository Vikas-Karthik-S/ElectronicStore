<%@ include file="../partials/header.jsp" %>
<%@ include file="../partials/navbar.jsp" %>

<div class="container" style="text-align: center; padding: 100px 0;">
    <div style="display: inline-flex; align-items: center; justify-content: center; width: 120px; height: 120px; background: #dcfce7; border-radius: 50%; margin-bottom: 30px;">
        <span style="font-size: 60px; color: #166534;">&#10004;</span>
    </div>
    
    <h1 style="font-size: 3rem; font-weight: 800; color: #1e293b; margin-bottom: 20px;">Order Placed Successfully!</h1>
    <p style="font-size: 1.2rem; color: #64748b; margin-bottom: 40px;">Thank you for your purchase. Your gadgets are on their way!</p>
    
    <div style="display: flex; gap: 20px; justify-content: center;">
        <a href="${pageContext.request.contextPath}/orders" class="btn btn-primary" style="padding: 15px 40px;">View My Orders</a>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline" style="padding: 15px 40px;">Continue Shopping</a>
    </div>
</div>

<%@ include file="../partials/footer.jsp" %>
