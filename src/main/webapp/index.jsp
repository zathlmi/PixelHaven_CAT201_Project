<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Pixel Haven | The Official Store</title>
    <link href="https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">

    <style>
        /* --- GLOBAL RESET --- */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Google Sans', sans-serif; background-color: #fff; color: #3c4043; }

        /* --- NAVBAR --- */
        .navbar {
            display: flex; justify-content: space-between; align-items: center;
            padding: 15px 40px; background-color: #fff; position: sticky; top: 0; z-index: 100;
        }
        .logo { font-size: 24px; font-weight: 700; color: #000; letter-spacing: -0.5px; }
        .nav-links { display: flex; gap: 30px; }
        .nav-item { text-decoration: none; color: #5f6368; font-size: 14px; font-weight: 500; text-transform: uppercase; }
        .nav-item:hover { color: #000; }
        .user-actions { display: flex; align-items: center; gap: 15px; }
        .btn-signup { background-color: #000; color: #fff; padding: 8px 24px; border-radius: 50px; text-decoration: none; font-size: 14px; font-weight: 500; }

        /* --- 1. HERO IMAGE BANNER (Top Section) --- */
        .full-width-banner {
            width: 100%;
            display: block;
            line-height: 0; /* Removes small gap under image */
            background-color: #f1f3f4; /* Grey placeholder color while loading */
            min-height: 400px; /* Ensures space is reserved */
        }

        .full-width-banner img {
            width: 100%;
            height: auto;
            object-fit: cover;
            display: block;
        }

        /* --- 2. PRODUCT CARDS (Bottom Section) --- */
        .product-section {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            display: flex;
            flex-direction: column;
            gap: 20px; /* Space between cards */
        }

        .product-card {
            background-color: #f8f9fa; /* The Light Grey Background */
            border-radius: 24px;
            padding: 60px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            overflow: hidden;
            min-height: 500px;
        }

        /* Text Area inside Card */
        .card-content {
            flex: 1;
            padding-right: 20px;
            max-width: 500px;
        }

        .new-tag {
            font-size: 12px; font-weight: 700; text-transform: uppercase; color: #5f6368;
            margin-bottom: 15px; display: block;
        }

        .card-title {
            font-size: 40px; font-weight: 500; color: #202124; margin-bottom: 15px;
            line-height: 1.1;
        }

        .card-subtitle {
            font-size: 18px; color: #5f6368; margin-bottom: 30px;
        }

        /* Buttons */
        .btn-blue {
            display: inline-block; background-color: #1967d2; color: #fff; padding: 10px 24px;
            border-radius: 24px; text-decoration: none; font-weight: 500; font-size: 14px;
            margin-right: 15px;
        }

        .link-blue { color: #1967d2; text-decoration: none; font-weight: 500; font-size: 14px; }

        /* Image Area inside Card */
        .card-image-wrapper {
            flex: 1.2;
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }

        .card-image-wrapper img {
            width: 100%;
            max-width: 600px;
            height: auto;
            object-fit: contain;
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .product-card { flex-direction: column; text-align: center; padding: 40px 20px; }
            .card-content { padding-right: 0; margin-bottom: 40px; max-width: 100%; }
            .card-image-wrapper { justify-content: center; }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="logo">Pixel Haven</div>
    <div class="nav-links">
        <a href="index.jsp" class="nav-item">HOME</a>
        <a href="productList" class="nav-item">PRODUCTS</a>
        <a href="cart.jsp" class="nav-item">CART</a>

        <%
            String currentUser = (String) session.getAttribute("username");
            if ("admin1@gmail.com".equals(currentUser)) {
        %>
        <a href="admin.jsp" class="nav-item" style="color: #d93025;">ADMIN</a>
        <% } %>
    </div>

    <div class="user-actions">
        <% if (currentUser != null) { %>
        <span style="font-size:14px;">Hi, <%= currentUser %></span>
        <a href="logout" style="font-size:14px; color:#d93025; margin-left:10px; text-decoration:none;">Logout</a>
        <% } else { %>
        <a href="login.jsp" class="nav-item" style="text-transform:capitalize;">Log In</a>
        <a href="register.jsp" class="btn-signup">Sign Up</a>
        <% } %>
    </div>
</nav>

<div class="full-width-banner">
    <img src="images/banner.jpg" alt="The All-Pro Google Phone"
         onerror="this.style.display='none'; alert('Error: The browser cannot find images/banner.jpg. Make sure the file is inside the images folder!');">
</div>

<div class="product-section">

    <div class="product-card">
        <div class="card-content">
            <span class="new-tag">New</span>
            <h2 class="card-title">Pixel 10 Pro and Pro XL</h2>
            <p class="card-subtitle">Meet the new status pro.</p>

            <div>
                <a href="productList" class="btn-blue">Buy Now</a>
                <a href="productSpecs?id=P10PRO" class="link-blue">Learn more ></a>
            </div>
        </div>
        <div class="card-image-wrapper">
            <img src="images/pixel10pro10proxl.png" alt="Pixel 10 Pro Pair">
        </div>
    </div>

    <div class="product-card">
        <div class="card-content">
            <span class="new-tag">New</span>
            <h2 class="card-title">Pixel 10 Pro</h2>
            <p class="card-subtitle">Pro performance in a perfect size.</p>
            <div>
                <a href="productList" class="btn-blue">Buy Now</a>
                <a href="productSpecs?id=P10PRO" class="link-blue">Learn more ></a>
            </div>
        </div>
        <div class="card-image-wrapper">
            <img src="images/pixel10pro_ad.jpg" alt="Pixel 10 Pro">
        </div>
    </div>

</div>

<footer style="text-align:center; padding:50px; border-top:1px solid #eee; margin-top:50px;">
    <p style="color:#9aa0a6; font-size:12px;">© 2026 Pixel Haven. All rights reserved.</p>
</footer>

</body>
</html>