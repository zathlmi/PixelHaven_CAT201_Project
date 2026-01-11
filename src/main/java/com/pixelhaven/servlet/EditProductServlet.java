package com.pixelhaven.servlet;

import com.pixelhaven.model.PixelPhone;
import com.pixelhaven.dao.PhoneRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;

// 2. Mapped to "/editProduct" - Catches requests from the "Edit" button
@WebServlet("/editProduct")
@MultipartConfig
public class EditProductServlet extends HttpServlet {

    // --- SHOW THE FORM ---
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        PixelPhone phone = PhoneRepository.getPhoneById(id);

        if (phone != null) {
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("editProduct.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("admin.jsp");
        }
    }

    // --- SAVE THE CHANGES ---
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String series = req.getParameter("series");
        String priceStr = req.getParameter("price");
        String description = req.getParameter("description");

        try {
            double price = Double.parseDouble(priceStr);
            PixelPhone original = PhoneRepository.getPhoneById(id);

            if (original != null) {
                original.setName(name);
                original.setSeries(series);
                original.setDefaultPrice(price);
                original.setDescription(description);

                // IMAGE UPLOAD LOGIC
                try {
                    Part filePart = req.getPart("image");
                    if (filePart != null && filePart.getSize() > 0) {
                        String fileName = filePart.getSubmittedFileName();
                        if (fileName != null && !fileName.trim().isEmpty()) {
                            String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                            File uploadDir = new File(uploadPath);
                            if (!uploadDir.exists()) uploadDir.mkdir();
                            filePart.write(uploadPath + File.separator + fileName);
                            original.setDefaultImageUrl(fileName);
                        }
                    }
                } catch (Exception ex) {
                    System.out.println("Image upload failed: " + ex.getMessage());
                }

                PhoneRepository.updatePhone(original);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // After saving, go back to the Dashboard
        resp.sendRedirect("admin");
    }
}