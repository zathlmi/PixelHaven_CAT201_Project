<%@ page import="com.pixelhaven.model.PixelPhone" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Specs | Pixel Haven</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">

    <style>
        body { font-family: 'Roboto', sans-serif; background-color: #fff; color: #3c4043; margin: 0; padding: 0; }

        /* --- NAVBAR STYLES (Added these so navbar looks correct) --- */
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
        .btn-signup {
            background-color: #000; color: #fff; padding: 8px 24px; border-radius: 50px;
            text-decoration: none; font-weight: 500; font-size: 14px; margin-left: 20px;
            transition: background 0.2s;
        }
        .btn-signup:hover { background-color: #333; }
        /* ----------------------------------------------------------- */

        .specs-container { max-width: 800px; margin: 40px auto; padding: 20px; }
        h1 { font-size: 32px; font-weight: 700; margin-bottom: 10px; text-align: center; }
        .back-link { display: block; text-align: center; margin-bottom: 40px; color: #1967d2; text-decoration: none; font-weight: 500; }

        .specs-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .specs-table tr { border-bottom: 1px solid #dadce0; }
        .specs-table td { padding: 24px 0; vertical-align: top; }
        .spec-label { width: 30%; font-weight: 700; color: #202124; font-size: 14px; text-transform: uppercase; letter-spacing: 0.5px; }
        .spec-value { width: 70%; font-size: 16px; line-height: 1.6; color: #5f6368; }
        .spec-value ul { padding-left: 20px; margin: 0; }
        .spec-value li { margin-bottom: 8px; }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="logo">Pixel Haven</div>
    <div class="nav-links">
        <a href="index.jsp" class="nav-item">HOME</a>
        <a href="productList" class="nav-item">PRODUCTS</a>
        <a href="cart" class="nav-item">CART</a>

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

<%
    PixelPhone p = (PixelPhone) request.getAttribute("phone");
    if (p != null) {
%>

<div class="specs-container">
    <h1><%= p.getName() %> Tech Specs</h1>
    <a href="productList" class="back-link">← Back to Products</a>

    <table class="specs-table">
        <tr>
            <td class="spec-label">Display</td>
            <td class="spec-value"><%= p.getDisplaySpecs() %></td>
        </tr>

        <tr>
            <td class="spec-label">Dimensions & Weight</td>
            <td class="spec-value"><%= p.getDimensionSpecs() %></td>
        </tr>

        <tr>
            <td class="spec-label">Battery & Charging</td>
            <td class="spec-value"><%= p.getBatterySpecs() %></td>
        </tr>

        <tr>
            <td class="spec-label">Rear Camera</td>
            <td class="spec-value"><%= p.getRearCameraSpecs() %></td>
        </tr>

        <tr>
            <td class="spec-label">Front Camera</td>
            <td class="spec-value"><%= p.getFrontCameraSpecs() %></td>
        </tr>
    </table>
</div>

<% } else { %>
<div style="text-align: center; margin-top: 50px;">
    <h2>Product Not Found</h2>
    <a href="productList">Return to Store</a>
</div>
<% } %>

</body>
</html>