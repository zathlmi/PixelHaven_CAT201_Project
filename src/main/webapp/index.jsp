<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Pixel Haven | The Official Store</title>
    <link href="https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">

    <style>
        /* LANDING PAGE SPECIFIC STYLES */

        /* 1. HERO SECTION */
        .hero-section {
            position: relative;
            width: 100%;
            height: 650px;
            background-color: #f4f4f4;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            text-align: center;
            overflow: hidden;
            padding-top: 60px;
        }

        .hero-content {
            z-index: 2;
            max-width: 800px;
            animation: fadeInUp 1s ease-out;
        }

        .hero-title {
            font-family: 'Google Sans', sans-serif;
            font-size: 56px;
            font-weight: 700;
            color: black;
            margin-bottom: 15px;
            letter-spacing: -1px;
        }

        .hero-subtitle {
            font-size: 18px;
            color: #444;
            margin-bottom: 30px;
            font-weight: 400;
        }

        .hero-btn {
            background-color: black;
            color: white;
            padding: 12px 35px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            transition: transform 0.2s, background 0.2s;
            display: inline-block;
        }

        .hero-btn:hover {
            background-color: #333;
            transform: scale(1.05);
        }

        .hero-image {
            margin-top: 40px;
            width: 80%;
            max-width: 900px;
            height: auto;
            object-fit: contain;
            transition: transform 0.5s ease;
        }

        .hero-section:hover .hero-image {
            transform: translateY(-10px);
        }

        /* 2. HIGHLIGHTS GRID */
        .highlights-container {
            max-width: 1400px;
            margin: 60px auto;
            padding: 0 40px;
            text-align: center;
        }

        .section-heading {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 40px;
        }

        .grid-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .feature-card {
            background-color: #f4f4f4;
            border-radius: 24px;
            padding: 50px 30px;
            text-align: center;
            height: 600px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            text-decoration: none;
            color: inherit;
            transition: box-shadow 0.3s;
        }

        .feature-card:hover {
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .feature-title {
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .feature-desc {
            font-size: 16px;
            color: #666;
            margin-bottom: 30px;
        }

        .feature-card img {
            width: 80%;
            max-height: 350px;
            object-fit: contain;
            margin-top: auto;
            margin-bottom: 40px;
        }

        /* 3. ANIMATIONS */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* NEW: SIGN UP BUTTON STYLE */
        .btn-signup {
            background-color: #000;      /* Black background */
            color: #fff;                 /* White text */
            padding: 8px 24px;           /* Padding for pill shape */
            border-radius: 50px;         /* Fully rounded corners */
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            margin-left: 20px;           /* Space between Login and Sign Up */
            transition: background 0.2s;
        }

        .btn-signup:hover {
            background-color: #333;      /* Dark grey on hover */
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
        <a href="admin.jsp" class="nav-item" style="color: #d93025; font-weight: bold;">ADMIN PANEL</a>
        <% } %>
    </div>

    <div class="user-actions">
        <% if (currentUser != null) { %>
        <span class="user-greeting"><%= currentUser %></span>
        <a href="logout" class="nav-action" style="margin-left: 15px;">Logout</a>
        <% } else { %>
        <a href="login.jsp" class="nav-action">Log In</a>
        <a href="register.jsp" class="btn-signup">Sign Up</a>
        <% } %>
    </div>
</nav>

<section class="hero-section">
</section>

<div class="google-section">

    <div class="google-card large-card">
        <div class="card-text">
            <span class="new-tag">New</span>
            <h2 class="card-title">Pixel 10 Pro and Pro XL</h2>
            <p class="card-desc">Meet the new status pro.</p>
            <div class="card-links">
                <a href="productList" class="btn-blue">Buy Now</a>
                <a href="productList" class="link-blue">Learn more ></a>
            </div>
        </div>
        <img src="images/pixel10pro10proxl.png" alt="Pixel 10 Pro Family" class="img-large">
    </div>

    <div class="google-card large-card">
        <div class="card-text">
            <span class="new-tag">New</span>
            <h2 class="card-title">Pixel 10 Pro</h2>
            <p class="card-desc">Pro performance in a perfect size.</p>
            <div class="card-links">
                <a href="productList" class="btn-blue">Buy Now</a>
                <a href="productSpecs?id=P10PRO" class="link-blue">Learn more ></a>
            </div>
        </div>
        <img src="images/pixel10pro_ad.jpg" alt="Pixel 10 Pro" class="img-large">
    </div>

    <div class="google-card large-card">
        <div class="card-text">
            <span class="new-tag">New</span>
            <h2 class="card-title">Pixel 10</h2>
            <p class="card-desc">Do spectacular, on the regular.</p>
            <div class="card-links">
                <a href="productList" class="btn-blue">Buy Now</a>
                <a href="productSpecs?id=P10" class="link-blue">Learn more ></a>
            </div>
        </div>
        <img src="images/pixel10_ad.jpg" alt="Pixel 10" class="img-large">
    </div>

</div>

<footer style="background:white; padding:40px; text-align:center; border-top:1px solid #eee; margin-top:50px;">
    <p style="color:#666; font-size:12px;">© 2026 Pixel Haven. All rights reserved.</p>
</footer>

</body>
</html>