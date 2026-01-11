package com.pixelhaven.servlet;

import com.pixelhaven.dao.UserRepository;
import com.pixelhaven.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        // 1. Check for hard-coded Admin credentials
        if ("admin1@gmail.com".equals(email) && "admin123".equals(password)) {
            session.setAttribute("username", email);
            session.setAttribute("role", "admin");
            response.sendRedirect("admin.jsp");
            return; // Exit method so it doesn't run the logic below
        }

        // 2. Normal User Login Logic
        // Assuming your UserRepository has a validate method or a way to get a user
        boolean isValidUser = UserRepository.validate(email, password);

        if (isValidUser) {
            session.setAttribute("username", email);
            session.setAttribute("role", "user");
            response.sendRedirect("index.jsp");
        } else {
            // --- FAILED LOGIN ---
            request.setAttribute("errorMessage", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}