<footer>
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                    <h2 class="logo">ELECTRONICSTORE</h2>
                    <p>Your one-stop destination for premium electronics and gadgets.</p>
                </div>
                <div class="footer-col">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/products">Shop</a></li>
                        <li><a href="${pageContext.request.contextPath}/cart">Cart</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h3>Customer Service</h3>
                    <ul>
                        <li><a href="javascript:void(0)" onclick="showContactModal()">Contact Us</a></li>
                        <li><a href="javascript:void(0)" onclick="showShippingModal()">Shipping Policy</a></li>
                        <li><a href="javascript:void(0)" style="cursor: default;">Returns (No returns)</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 Vikas Karthik S | ElectronicStore. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Contact Modal -->
    <div id="contactModal" class="modal-overlay" onclick="closeContactModal(event)">
        <div class="modal-content" style="max-width: 500px; text-align: left;" onclick="event.stopPropagation()">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 2px solid #f1f5f9; padding-bottom: 15px;">
                <h2 style="font-size: 1.5rem; color: var(--primary-color);">Contact Us</h2>
                <button onclick="closeContactModal()" style="background: none; border: none; font-size: 1.5rem; cursor: pointer; color: #64748b;">&times;</button>
            </div>
            <div style="padding: 10px 0; font-size: 1.05rem;">
                <p style="margin-bottom: 15px;"><strong>Name:</strong> Vikas Karthik S</p>
                <p style="margin-bottom: 15px;"><strong>Phone:</strong> +91 6360171762</p>
                <p style="margin-bottom: 15px;"><strong>Email:</strong> <a href="mailto:vikaskarthik7680@gmail.com" style="color: var(--primary-color);">vikaskarthik7680@gmail.com</a></p>
            </div>
            <div style="margin-top: 25px; text-align: right;">
                <button class="btn btn-primary" onclick="closeContactModal()">Close</button>
            </div>
        </div>
    </div>

    <!-- Shipping Policy Modal -->
    <div id="shippingModal" class="modal-overlay" onclick="closeShippingModal(event)">
        <div class="modal-content" style="max-width: 600px; text-align: left;" onclick="event.stopPropagation()">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 2px solid #f1f5f9; padding-bottom: 15px;">
                <h2 style="font-size: 1.5rem; color: var(--primary-color);">Shipping Policy</h2>
                <button onclick="closeShippingModal()" style="background: none; border: none; font-size: 1.5rem; cursor: pointer; color: #64748b;">&times;</button>
            </div>
            <div style="padding: 10px 0; font-size: 1rem; color: #475569; max-height: 400px; overflow-y: auto;">
                <ul style="list-style-type: disc; padding-left: 20px; line-height: 1.8;">
                    <li><strong>Processing Time:</strong> All orders are processed within 1-2 business days. Orders are not shipped or delivered on weekends or holidays.</li>
                    <li><strong>Shipping Rates:</strong> Free shipping is available on all orders over &#8377;500. For orders below &#8377;500, standard shipping rates apply.</li>
                    <li><strong>Delivery Estimates:</strong> Standard shipping typically takes 3-5 business days. Express shipping is available at checkout for an additional fee.</li>
                    <li><strong>Damages:</strong> ElectronicStore is not liable for any products damaged or lost during shipping. If you received your order damaged, please contact the shipment carrier to file a claim.</li>
                </ul>
            </div>
            <div style="margin-top: 25px; text-align: right;">
                <button class="btn btn-primary" onclick="closeShippingModal()">Close</button>
            </div>
        </div>
    </div>

    <!-- Logout Success Modal -->
    <% if ("success".equals(request.getParameter("logout"))) { %>
    <div id="logoutModal" class="modal-overlay active" onclick="closeLogoutModal(event)">
        <div class="modal-content" style="max-width: 400px; text-align: center;" onclick="event.stopPropagation()">
            <div style="margin-bottom: 20px;">
                <h2 style="font-size: 1.5rem; color: var(--primary-color);">Logout Successful</h2>
            </div>
            <div style="margin-top: 25px;">
                <button class="btn btn-primary" onclick="closeLogoutModal()">OK</button>
            </div>
        </div>
    </div>
    <script>
        function closeLogoutModal(event) {
            document.getElementById('logoutModal').classList.remove('active');
            // Remove the query parameter from URL so it doesn't show again on refresh
            const url = new URL(window.location);
            url.searchParams.delete('logout');
            window.history.replaceState({}, document.title, url);
        }
    </script>
    <% } %>

    <script>
        function showContactModal() {
            document.getElementById('contactModal').classList.add('active');
        }
        function closeContactModal(event) {
            document.getElementById('contactModal').classList.remove('active');
        }
        function showShippingModal() {
            document.getElementById('shippingModal').classList.add('active');
        }
        function closeShippingModal(event) {
            document.getElementById('shippingModal').classList.remove('active');
        }
    </script>
</body>
</html>