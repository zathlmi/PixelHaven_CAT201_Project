<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Your Cart | Pixel Haven</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: 'Roboto', sans-serif; background-color: #f9f9f9; color: #111; margin: 0; }

        /* --- NAVBAR STYLES --- */
        .navbar {
            background: white;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid #eee;
        }
        .logo { font-size: 20px; font-weight: 700; color: #000; text-decoration: none; }
        .nav-links { display: flex; gap: 30px; }
        .nav-item { text-decoration: none; color: #5f6368; font-weight: 500; font-size: 14px; text-transform: uppercase; }
        .nav-item:hover, .nav-item.active { color: #000; }
        .user-actions { display: flex; align-items: center; }
        .nav-action { text-decoration: none; color: #000; font-weight: 500; font-size: 14px; }
        .user-greeting { font-size: 14px; color: #333; font-weight: 500; margin-right: 15px; }

        /* --- CART CONTAINER --- */
        .cart-container {
            max-width: 1200px;
            width: 90%;
            margin: 40px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
        }

        h2 { margin-bottom: 20px; font-size: 24px; }

        /* Styles for items injected by JS */
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 15px;
            border: 1px solid #eee;
        }

        .item-info { display: flex; align-items: center; gap: 20px; flex: 1; }
        .item-img { width: 80px; height: 80px; object-fit: contain; }
        .item-details h4 { margin: 0 0 5px 0; font-size: 18px; }
        .item-details p { margin: 0; color: #666; font-size: 14px; }

        .item-actions { display: flex; align-items: center; gap: 30px; }
        .item-price { font-weight: 700; font-size: 16px; }
        .btn-remove { color: #d93025; border:none; background:none; cursor:pointer; font-size: 14px; font-weight: 500; }
        .btn-remove:hover { text-decoration: underline; }

        .cart-summary {
            margin-top: 30px;
            text-align: right;
            padding-top: 20px;
            border-top: 2px solid #f0f0f0;
            display: none; /* Hidden by default, shown if cart has items */
        }
        .total-price { font-size: 24px; font-weight: 700; margin-bottom: 20px; }

        .btn-checkout {
            background-color: #000;
            color: #fff;
            padding: 12px 30px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 700;
            font-size: 16px;
            display: inline-block;
            cursor: pointer;
        }
        .btn-checkout:hover { background-color: #333; }

        .empty-msg {
            text-align: center;
            padding: 60px;
            color: #666;
            font-size: 18px;
            display: none; /* Hidden by default */
        }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="logo">Pixel Haven</div>
    <div class="nav-links">
        <a href="index.jsp" class="nav-item">HOME</a>
        <a href="productList" class="nav-item">PRODUCTS</a>
        <a href="cart.jsp" class="nav-item active">CART</a>
        <%
            String currentUser = (String) session.getAttribute("username");
            if ("admin1@gmail.com".equals(currentUser)) {
        %>
        <a href="admin.jsp" class="nav-item" style="color: #d93025; font-weight: bold;">ADMIN PANEL</a>
        <% } %>
    </div>
    <div class="user-actions">
        <% if (currentUser != null) { %>
        <span class="user-greeting"><%= currentUser %></span>
        <a href="logout" class="nav-action">Logout</a>
        <% } else { %>
        <a href="login.jsp" class="nav-action">Log In</a>
        <% } %>
    </div>
</nav>

<div class="cart-container">
    <h2>Your Cart</h2>

    <div id="cart-items-list"></div>

    <div id="cart-summary" class="cart-summary">
        <div class="total-price">Total: RM <span id="total-amount">0.00</span></div>
        <a href="#" onclick="alert('Proceeding to checkout... (Demo Only)'); return false;" class="btn-checkout">Checkout</a>
    </div>

    <div id="empty-cart-msg" class="empty-msg">
        <p>Your cart is empty.</p>
        <a href="productList" style="color: #1a73e8; text-decoration: none; font-weight: 500;">Continue Shopping</a>
    </div>
</div>

<script>
    // 1. Helper to get the correct key
    function getCartKey() {
        // We use an empty string as fallback to avoid "null" being part of the string
        const user = "<%= (session.getAttribute("username") != null) ? session.getAttribute("username") : "" %>";

        if (user === "") {
            return 'pixelhaven_cart_guest';
        } else {
            return 'pixelhaven_cart_' + user;
        }
    }

    function renderCart() {
        // Try/Catch prevents the whole page from going blank if one line fails
        try {
            const cartKey = getCartKey();
            const cartData = localStorage.getItem(cartKey);
            const cart = cartData ? JSON.parse(cartData) : [];

            const listContainer = document.getElementById('cart-items-list');
            const summary = document.getElementById('cart-summary');
            const emptyMsg = document.getElementById('empty-cart-msg');
            const totalSpan = document.getElementById('total-amount');

            // Safety check: ensure all elements exist before working with them
            if (!listContainer || !summary || !emptyMsg || !totalSpan) return;

            // Clear current list
            listContainer.innerHTML = '';

            if (cart.length === 0) {
                summary.style.display = 'none';
                emptyMsg.style.display = 'block';
                return;
            }

            // Show summary and hide empty message
            summary.style.display = 'block';
            emptyMsg.style.display = 'none';

            let total = 0;

            cart.forEach((item, index) => {
                total += item.price * item.quantity;

                // Built with standard string concatenation to be JSP-safe
                let itemHtml = '<div class="cart-item">' +
                    '<div class="item-info">' +
                    '<img src="' + item.image + '" class="item-img">' +
                    '<div class="item-details">' +
                    '<h4>' + item.name + '</h4>' +
                    '<p>Color: ' + item.color + ' | Storage: ' + item.storage + '</p>' +
                    '<p>Qty: ' + item.quantity + '</p>' +
                    '</div>' +
                    '</div>' +
                    '<div class="item-actions">' +
                    '<span class="item-price">RM ' + (item.price * item.quantity).toFixed(2) + '</span>' +
                    '<button onclick="removeItem(' + index + ')" class="btn-remove">Remove</button>' +
                    '</div>' +
                    '</div>';

                listContainer.innerHTML += itemHtml;
            });

            totalSpan.innerText = total.toFixed(2);
        } catch (e) {
            console.error("Cart render failed:", e);
        }
    }

    function removeItem(index) {
        const cartKey = getCartKey();
        let cart = JSON.parse(localStorage.getItem(cartKey)) || [];

        cart.splice(index, 1);
        localStorage.setItem(cartKey, JSON.stringify(cart));
        renderCart();
    }

    // Run when page is ready
    document.addEventListener('DOMContentLoaded', renderCart);
</script>

</body>
</html>