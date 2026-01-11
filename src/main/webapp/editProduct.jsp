<%@ page import="com.pixelhaven.model.PixelPhone" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Product | Pixel Haven Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        body { background-color: #f4f6f8; }

        .admin-nav { background-color: #202124; color: white; }
        .admin-nav a { color: white; }

        .form-container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        h2 { margin-bottom: 20px; color: #202124; }

        .form-group { margin-bottom: 20px; }
        .form-label { display: block; margin-bottom: 8px; font-weight: 500; }

        /* Updated input styles for textboxes and textareas */
        .form-input, textarea {
            width: 100%; padding: 10px;
            border: 1px solid #ddd; border-radius: 8px; font-size: 16px;
            font-family: 'Roboto', sans-serif;
            box-sizing: border-box; /* Fixes padding issues */
        }
        textarea { resize: vertical; height: 100px; }

        .btn-save {
            background-color: #1a73e8; color: white;
            border: none; padding: 12px 24px;
            border-radius: 24px; font-size: 16px; font-weight: 500;
            cursor: pointer; width: 100%;
        }
        .btn-cancel {
            display: block; text-align: center; margin-top: 15px;
            color: #5f6368; text-decoration: none;
        }
    </style>
</head>
<body>

<nav class="navbar admin-nav">
    <div class="logo">Pixel Haven Admin</div>
    <div class="nav-links">
        <a href="admin.jsp" class="nav-item">Dashboard</a>
        <a href="index.jsp" class="nav-item">View Site</a>
        <a href="logout" class="nav-action">Logout</a>
    </div>
</nav>

<div class="form-container">
    <h2>Edit Product</h2>

    <%
        // FIX 1: Changed variable name 'p' to 'phone' so it matches the rest of the file
        PixelPhone phone = (PixelPhone) request.getAttribute("phone");
        if (phone != null) {
    %>

    <form action="editProduct" method="post" enctype="multipart/form-data">

        <input type="hidden" name="id" value="<%= phone.getId() %>">

        <div class="form-group">
            <label class="form-label">Product Name</label>
            <input type="text" class="form-input" name="name" value="<%= phone.getName() %>" required>
        </div>

        <div class="form-group">
            <label class="form-label">Series</label>
            <input type="text" class="form-input" name="series" value="<%= phone.getSeries() %>" required>
        </div>

        <div class="form-group">
            <label class="form-label">Price (RM)</label>
            <input type="number" step="0.01" class="form-input" name="price" value="<%= phone.getDefaultPrice() %>" required>
        </div>

        <div class="form-group">
            <label class="form-label">Description</label>
            <textarea name="description" required><%= phone.getDescription() %></textarea>
        </div>

        <div class="form-group">
            <label class="form-label">Product Image</label>
            <div style="margin: 10px 0;">
                <img src="images/<%= phone.getDefaultImageUrl() %>" alt="Current Image" style="width: 80px; height: 80px; object-fit: contain; border: 1px solid #ddd; padding: 5px; border-radius: 5px;">
            </div>
            <input type="file" name="image" accept="image/*">
            <p style="font-size: 12px; color: #666; margin-top: 5px;">Leave empty to keep the current image.</p>
        </div>

        <button type="submit" class="btn-save">Save Changes</button>
        <a href="admin.jsp" class="btn-cancel">Cancel</a>
    </form>

    <% } else { %>
    <p>Product not found.</p>
    <a href="admin.jsp" class="btn-cancel">Go Back</a>
    <% } %>
</div>

</body>
</html>