<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Add New Product | Pixel Haven Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Roboto', sans-serif; background-color: #f4f6f8; padding: 20px; }
        .form-container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        h2 { margin-bottom: 25px; color: #202124; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: 500; color: #5f6368; }
        input[type="text"], input[type="number"], textarea, select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; }
        .dynamic-row { display: flex; gap: 10px; margin-bottom: 10px; align-items: center; background: #f8f9fa; padding: 10px; border-radius: 8px; }
        .dynamic-row input { flex: 1; }
        .btn-add { background: #e8f0fe; color: #1a73e8; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer; font-weight: 500; }
        .btn-remove-row { background: #fce8e6; color: #d93025; border: none; padding: 8px; border-radius: 4px; cursor: pointer; }
        .btn-save { background-color: #1a73e8; color: white; border: none; padding: 15px; width: 100%; border-radius: 8px; font-size: 16px; font-weight: 700; cursor: pointer; margin-top: 20px; }
        .btn-save:hover { background-color: #1557b0; }
        .section-title { font-size: 16px; font-weight: 700; margin-top: 30px; margin-bottom: 15px; color: #202124; border-bottom: 2px solid #eee; padding-bottom: 5px; }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Add New Product</h2>

    <form action="addProduct" method="post" enctype="multipart/form-data">

        <div class="form-group">
            <label>Unique ID (e.g., P11PRO)</label>
            <input type="text" name="id" required placeholder="No spaces, uppercase recommended">
        </div>
        <div class="form-group">
            <label>Product Name</label>
            <input type="text" name="name" required placeholder="e.g., Pixel 11 Pro">
        </div>
        <div class="form-group">
            <label>Series Category</label>
            <input type="text" name="series" required placeholder="e.g., Pixel 11 Series">
        </div>
        <div class="form-group">
            <label>Short Description</label>
            <input type="text" name="description" required placeholder="A short marketing tagline">
        </div>
        <div class="form-group">
            <label>Default Display Image</label>
            <input type="file" name="defaultImage" accept="image/*" required>
        </div>


        <div class="section-title">Storage Options & Prices</div>
        <div id="storage-container">
            <div class="dynamic-row">
                <input type="text" name="storageSize" placeholder="Size (e.g., 128GB)" required>
                <input type="number" step="0.01" name="storagePrice" placeholder="Price (RM)" required>
            </div>
        </div>
        <button type="button" class="btn-add" onclick="addStorageRow()">+ Add Another Storage Option</button>


        <div class="section-title">Colors & Variant Images</div>
        <input type="hidden" id="colorCount" name="colorCount" value="1">
        <div id="color-container">
            <div class="dynamic-row">
                <input type="text" name="colorName" placeholder="Color Name (e.g., Obsidian)" required>
                <input type="color" name="colorHex" value="#000000" style="height: 40px; padding: 2px;">
                <input type="file" name="colorImg0" accept="image/*" required>
            </div>
        </div>
        <button type="button" class="btn-add" onclick="addColorRow()">+ Add Another Color Variant</button>


        <button type="submit" class="btn-save">Create Product</button>
        <a href="admin.jsp" style="display: block; text-align: center; margin-top: 15px; text-decoration: none; color: #666;">Cancel</a>
    </form>
</div>

<script>
    function addStorageRow() {
        const container = document.getElementById('storage-container');
        const div = document.createElement('div');
        div.className = 'dynamic-row';
        div.innerHTML = `
            <input type="text" name="storageSize" placeholder="Size (e.g., 256GB)" required>
            <input type="number" step="0.01" name="storagePrice" placeholder="Price (RM)" required>
            <button type="button" class="btn-remove-row" onclick="this.parentElement.remove()">X</button>
        `;
        container.appendChild(div);
    }

    let colorCounter = 1;
    function addColorRow() {
        const container = document.getElementById('color-container');
        const div = document.createElement('div');
        div.className = 'dynamic-row';
        // Important: give the file input a unique name based on the counter
        div.innerHTML = `
            <input type="text" name="colorName" placeholder="Color Name" required>
            <input type="color" name="colorHex" value="#ffffff" style="height: 40px; padding: 2px;">
            <input type="file" name="colorImg${colorCounter}" accept="image/*" required>
            <button type="button" class="btn-remove-row" onclick="this.parentElement.remove()">X</button>
        `;
        container.appendChild(div);
        colorCounter++;
        // Update hidden input so Servlet knows how many images to look for
        document.getElementById('colorCount').value = colorCounter;
    }
</script>

</body>
</html>