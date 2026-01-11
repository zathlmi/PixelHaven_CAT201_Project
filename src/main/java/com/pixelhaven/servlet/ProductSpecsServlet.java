package com.pixelhaven.servlet;

import com.pixelhaven.model.PixelPhone;
import com.pixelhaven.dao.PhoneRepository;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/productSpecs")
public class ProductSpecsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Get the ID passed from the button
        String id = request.getParameter("id");

        // 2. Find the phone in the database (Repository)
        PixelPhone phone = PhoneRepository.getPhoneById(id);

        // 3. If found, send it to the JSP page
        if (phone != null) {
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("product-specs.jsp").forward(request, response);
        } else {
            // Handle error if ID is invalid
            response.sendRedirect("catalog.jsp");
        }
    }
}