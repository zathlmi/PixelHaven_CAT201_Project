package com.pixelhaven.servlet;

import com.pixelhaven.model.PixelPhone;
import com.pixelhaven.dao.PhoneRepository;

// USE JAKARTA FOR TOMCAT 11
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

// I changed this to "/productList" to match the links in your Home Page
@WebServlet("/productList")
public class ProductListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get data from our Repository
        List<PixelPhone> phoneList = PhoneRepository.getAllPhones();

        // 2. Attach data to the request object so JSP can see it
        request.setAttribute("phones", phoneList);

        // 3. Send the user to the visual page (JSP)
        RequestDispatcher dispatcher = request.getRequestDispatcher("catalog.jsp");
        dispatcher.forward(request, response);
    }
}