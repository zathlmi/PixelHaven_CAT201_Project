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
import java.util.stream.Collectors;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get the search query from the navbar input
        String query = request.getParameter("query");

        // 2. Get all phones
        List<PixelPhone> allPhones = PhoneRepository.getAllPhones();

        // 3. Filter the list based on the user's query
        List<PixelPhone> searchResults;

        if (query != null && !query.trim().isEmpty()) {
            String lowerCaseQuery = query.toLowerCase();
            searchResults = allPhones.stream()
                    .filter(p -> p.getName().toLowerCase().contains(lowerCaseQuery) ||
                            p.getSeries().toLowerCase().contains(lowerCaseQuery))
                    .collect(Collectors.toList());
        } else {
            // If search is empty, show all phones
            searchResults = allPhones;
        }

        // 4. Send the results to catalog.jsp
        request.setAttribute("phones", searchResults);
        RequestDispatcher dispatcher = request.getRequestDispatcher("catalog.jsp");
        dispatcher.forward(request, response);
    }
}