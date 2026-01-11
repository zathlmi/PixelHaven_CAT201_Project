<%@ page import="java.util.List" %>
<%@ page import="com.pixelhaven.model.PixelPhone" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="style.css">
    <title>Pixel Haven | Offers</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

    <style>
        /* BASE STYLES */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Roboto', sans-serif; background-color: #f9f9f9; color: #111; }

        /* --- SIGN UP BUTTON STYLE (From Home Page) --- */
        .btn-signup {
            background-color: #000;
            color: #fff;
            padding: 8px 24px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            margin-left: 20px;
            transition: background 0.2s;
        }
        .btn-signup:hover { background-color: #333; }

        /* --- NAVBAR STYLES (Identical to Home Page) --- */
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
        .logo { font-size: 24px; font-weight: 700; color: #000; text-decoration: none; }

        .nav-links { display: flex; gap: 30px; }
        .nav-item { text-decoration: none; color: #000; font-weight: 600; font-size: 14px; text-transform: uppercase; }
        .nav-item:hover, .nav-item.active { color: #000; }

        .user-actions { display: flex; align-items: center; }
        .nav-action { text-decoration: none; color: #000; font-weight: 700; font-size: 14px; }
        .user-greeting { font-size: 14px; color: #000; font-weight: 400; margin-right: 20px; }

        /* --- PRODUCT GRID STYLES --- */
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .series-header { width: 100%; font-size: 24px; font-weight: 700; margin-top: 40px; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #eee; text-align: left; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 25px; margin-bottom: 40px; }

        .card { background: white; border-radius: 20px; padding: 25px 20px; text-align: center; transition: transform 0.3s ease, box-shadow 0.3s ease; border: 1px solid #f0f0f0; display: flex; flex-direction: column; justify-content: space-between; min-height: 500px; }
        .card:hover { transform: translateY(-5px); box-shadow: 0 15px 30px rgba(0,0,0,0.08); }
        .card img { width: 100%; height: 220px; object-fit: contain; margin-bottom: 15px; transition: opacity 0.2s; }

        .product-name { font-size: 18px; font-weight: 700; margin-bottom: 5px; }
        .description { color: #666; font-size: 13px; margin-bottom: 15px; height: 35px; overflow: hidden; }

        /* Options & Buttons */
        .options-container { margin-bottom: 10px; }
        .options-label { font-size: 10px; text-transform: uppercase; letter-spacing: 1px; color: #888; margin-bottom: 6px; font-weight: 700; }
        .color-group { display: flex; gap: 8px; justify-content: center; margin-bottom: 15px; }
        .color-dot { width: 24px; height: 24px; border-radius: 50%; cursor: pointer; border: 1px solid #ddd; position: relative; }
        .color-dot.active::after { content: ''; position: absolute; top: -3px; left: -3px; right: -3px; bottom: -3px; border: 2px solid #000; border-radius: 50%; }
        .storage-group { display: flex; gap: 6px; justify-content: center; flex-wrap: wrap; }
        .storage-btn { padding: 6px 12px; border: 1px solid #ddd; border-radius: 8px; background: white; cursor: pointer; font-size: 11px; color: #444; }
        .storage-btn.active { border-color: #000; background-color: #000; color: white; }
        .price { font-size: 18px; font-weight: 700; margin: 15px 0; }

        .btn-specs { background-color: transparent; color: #000; border: 2px solid #000; padding: 15px 0; width: 100%; border-radius: 30px; font-size: 16px; font-weight: 700; cursor: pointer; transition: all 0.2s; margin-bottom: 12px; display: block; }
        .btn-specs:hover { background-color: #f0f0f0; }
        .btn-buy { background-color: #000; color: #fff; padding: 10px 0; width: 100%; border-radius: 30px; font-size: 14px; font-weight: 700; border: none; cursor: pointer; transition: background 0.2s; }
        .btn-buy:hover { background-color: #333; }
    </style>

    <script>
        function updateProduct(element, type, phoneId, value, extraData) {
            let siblings = element.parentNode.children;
            for (let i = 0; i < siblings.length; i++) { siblings[i].classList.remove('active'); }
            element.classList.add('active');

            if (type === 'color') {
                let img = document.getElementById('img-' + phoneId);
                img.src = 'images/' + value;
                document.getElementById('input-color-' + phoneId).value = extraData;
            } else if (type === 'storage') {
                document.getElementById('price-' + phoneId).innerText = 'RM ' + parseFloat(value).toFixed(2);
                document.getElementById('input-storage-' + phoneId).value = extraData;
                document.getElementById('input-price-' + phoneId).value = value;
            }
        }

        // --- NEW PERSISTENT CART LOGIC ---
        function addToCartPersistent(phoneId, phoneName) {
            // 1. Get the current logged-in username from JSP
            const currentUser = "<%= (session.getAttribute("username") != null) ? session.getAttribute("username") : "" %>";

            // 2. CHECK: If user is not logged in, redirect to login page
            if (currentUser === "") {
                alert("Please log in to add items to your cart.");
                window.location.href = "login.jsp";
                return; // Stop the rest of the function from running
            }

            // 3. If logged in, proceed with the unique user key
            const cartKey = 'pixelhaven_cart_' + currentUser;

            let color = document.getElementById('input-color-' + phoneId).value;
            let storage = document.getElementById('input-storage-' + phoneId).value;
            let price = document.getElementById('input-price-' + phoneId).value;
            let image = document.getElementById('img-' + phoneId).getAttribute('src');

            let cart = JSON.parse(localStorage.getItem(cartKey)) || [];

            let item = {
                id: phoneId,
                name: phoneName,
                color: color,
                storage: storage,
                price: parseFloat(price),
                image: image,
                quantity: 1
            };

            let existingItem = cart.find(i => i.id === phoneId && i.color === color && i.storage === storage);
            if (existingItem) {
                existingItem.quantity += 1;
            } else {
                cart.push(item);
            }

            localStorage.setItem(cartKey, JSON.stringify(cart));
            alert(phoneName + " added to your cart!");
        }
    </script>
</head>
<body>

<nav class="navbar">
    <div class="logo">Pixel Haven</div>
    <div class="nav-links">
        <a href="index.jsp" class="nav-item">HOME</a>
        <a href="productList" class="nav-item active">PRODUCTS</a>
        <a href="cart.jsp" class="nav-item">CART</a>

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
        <a href="register.jsp" class="btn-signup">Sign Up</a>
        <% } %>
    </div>
</nav>

<div class="container">
        <%
       List<PixelPhone> phones = (List<PixelPhone>) request.getAttribute("phones");
       String currentSeries = "";
       boolean firstGroup = true;

       if (phones != null) {
           for (int i = 0; i < phones.size(); i++) {
               PixelPhone p = phones.get(i);
               if (!p.getSeries().equals(currentSeries)) {
                   if (!firstGroup) out.println("</div>");
                   currentSeries = p.getSeries();
    %>
    <div class="series-header"><%= currentSeries %></div>
    <div class="product-grid">
        <% firstGroup = false; } %>
        <div class="card">
            <div>
                <img id="img-<%= p.getId() %>" src="images/<%= p.getDefaultImageUrl() %>" alt="<%= p.getName() %>">
                <div class="product-name"><%= p.getName() %></div>
                <div class="description"><%= p.getDescription() %></div>
            </div>

            <div class="options-container">
                <div class="options-label">Color</div>
                <div class="color-group">
                    <% for (int j = 0; j < p.getColors().size(); j++) {
                        String active = (j==0) ? "active" : ""; %>
                    <div class="color-dot <%= active %>" style="background-color: <%= p.getColors().get(j) %>;"
                         onclick="updateProduct(this, 'color', '<%= p.getId() %>', '<%= p.getColorImages().get(j) %>', '<%= p.getColorNames().get(j) %>')"></div>
                    <% } %>
                </div>

                <div class="options-label">Storage</div>
                <div class="storage-group">
                    <% for (int k = 0; k < p.getStorage().size(); k++) {
                        String active = (k==0) ? "active" : ""; %>
                    <div class="storage-btn <%= active %>"
                         onclick="updateProduct(this, 'storage', '<%= p.getId() %>', '<%= p.getStoragePrices().get(k) %>', '<%= p.getStorage().get(k) %>')">
                        <%= p.getStorage().get(k) %>  </div>
                    <% } %>
                </div>

                <div class="price" id="price-<%= p.getId() %>">RM <%= String.format("%.2f", p.getDefaultPrice()) %></div>
                <a href="productSpecs?id=<%= p.getId() %>" class="btn-specs" style="text-decoration:none;">View Specs</a>

                <input type="hidden" id="input-color-<%= p.getId() %>" value="<%= p.getColorNames().get(0) %>">
                <input type="hidden" id="input-storage-<%= p.getId() %>" value="<%= p.getStorage().get(0) %>">
                <input type="hidden" id="input-price-<%= p.getId() %>" value="<%= p.getStoragePrices().get(0) %>">

                <button type="button" class="btn-buy" onclick="addToCartPersistent('<%= p.getId() %>', '<%= p.getName() %>')">
                    Add To Cart
                </button>
            </div>
        </div>
        <% } out.println("</div>"); } else { %>
        <p>No products found.</p>
        <% } %>
    </div>
</body>
</html>