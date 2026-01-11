<%@ page import="java.util.List" %>
<%@ page import="com.pixelhaven.model.PixelPhone" %>
<%@ page import="com.pixelhaven.dao.PhoneRepository" %>
<%@ page import="com.pixelhaven.model.PixelPhone" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard | Pixel Haven</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        body { background-color: #f4f6f8; }

        /* Admin Navbar specific styles */
        .admin-nav { background-color: #202124; color: white; }
        .admin-nav a { color: white; }

        .dashboard-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .btn-add {
            background-color: #1a73e8;
            color: white;
            padding: 10px 24px;
            border-radius: 24px;
            text-decoration: none;
            font-weight: 500;
        }

        /* Product Table Styles */
        .admin-table {
            width: 100%;
            background: white;
            border-radius: 12px;
            border-collapse: collapse;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .admin-table th {
            background-color: #f8f9fa;
            text-align: left;
            padding: 16px;
            font-weight: 700;
            color: #5f6368;
            font-size: 14px;
            text-transform: uppercase;
        }

        .admin-table td {
            padding: 16px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }

        .table-img {
            width: 50px;
            height: 50px;
            object-fit: contain;
        }

        .action-links a {
            margin-right: 15px;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
        }

        .edit-link { color: #1a73e8; }
        .delete-link { color: #d93025; }

    </style>
</head>
<body>

<nav class="navbar admin-nav">
    <div class="logo">Pixel Haven Admin</div>
    <div class="nav-links">
        <a href="index.jsp" class="nav-item">View Site</a>
        <a href="logout" class="nav-action">Logout</a>
    </div>
</nav>

<div class="dashboard-container">

    <div class="dashboard-header">
        <h1>Product Management</h1>
        <a href="addProduct" class="btn-add"> + Add New Product </a>
    </div>

    <table class="admin-table">
        <thead>
        <tr>
            <th>Image</th>
            <th>Product Name</th>
            <th>Series</th>
            <th>Price</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<PixelPhone> phones = PhoneRepository.getAllPhones();
            for (PixelPhone p : phones) {
        %>
        <tr>
            <td>
                <img src="images/<%= p.getDefaultImageUrl() %>" class="table-img" alt="img">
            </td>
            <td>
                <strong><%= p.getName() %></strong>
            </td>
            <td><%= p.getSeries() %></td>
            <td>RM <%= String.format("%,.2f", p.getDefaultPrice()) %></td>
            <td class="action-links">
                <a href="editProduct?id=<%= p.getId() %>" class="edit-link">Edit</a>
                <a href="admin?action=delete&id=<%= p.getId() %>"
                   onclick="return confirm('Are you sure you want to delete this product?');"
                   style="color: red;">Delete</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

</div>

</body>
</html>