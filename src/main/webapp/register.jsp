<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sign Up | Pixel Haven</title>
    <link href="https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">

    <style>
        /* REGISTER PAGE SPECIFIC STYLES */
        body {
            background-color: #F8F9FA; /* Light grey background */
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Navbar is inherited from style.css, ensure it stays at top */

        .auth-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .auth-card {
            background: white;
            width: 100%;
            max-width: 480px;
            padding: 48px;
            border-radius: 28px; /* Smooth rounded corners */
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            text-align: center;
        }

        .auth-logo {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 24px;
            display: block;
            color: black;
            text-decoration: none;
        }

        .auth-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 10px;
            color: #202124;
        }

        .auth-subtitle {
            font-size: 14px;
            color: #5f6368;
            margin-bottom: 40px;
        }

        .form-group {
            text-align: left;
            margin-bottom: 24px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 8px;
            color: #202124;
        }

        .form-input {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid #dadce0;
            border-radius: 4px;
            font-size: 16px;
            outline: none;
            transition: border 0.2s;
            font-family: 'Google Sans', sans-serif;
        }

        .form-input:focus {
            border-color: #1967D2;
            box-shadow: 0 0 0 1px #1967D2;
        }

        .btn-auth {
            background-color: #1967D2;
            color: white;
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 24px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 20px;
        }

        .btn-auth:hover {
            background-color: #174ea6;
        }

        .auth-footer {
            margin-top: 30px;
            font-size: 14px;
            color: #5f6368;
        }

        .auth-link {
            color: #1967D2;
            text-decoration: none;
            font-weight: 500;
        }

        .auth-link:hover {
            text-decoration: underline;
        }

        .error-message {
            background-color: #fce8e6;
            color: #c5221f;
            padding: 12px;
            border-radius: 4px;
            font-size: 14px;
            margin-bottom: 20px;
            text-align: left;
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="index.jsp" class="logo">Pixel Haven</a>
    <div class="nav-links">
        <a href="index.jsp" class="nav-item">Home</a>
        <a href="productList" class="nav-item">Products</a>
    </div>
</nav>

<div class="auth-container">
    <div class="auth-card">
        <div class="auth-title">Create your account</div>
        <div class="auth-subtitle">One account for everything Pixel Haven.</div>

        <%
            String error = (String) request.getAttribute("errorMessage");
            if (error != null) {
        %>
        <div class="error-message"><%= error %></div>
        <% } %>

        <form action="register" method="post">
            <div class="form-group">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-input" placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-input" placeholder="Enter password" required>
            </div>

            <button type="submit" class="btn-auth">Create Account</button>
        </form>

        <div class="auth-footer">
            Already have an account? <a href="login.jsp" class="auth-link">Log in</a>
        </div>
    </div>
</div>

</body>
</html>