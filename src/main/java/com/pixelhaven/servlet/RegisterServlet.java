package com.pixelhaven.servlet;

import com.pixelhaven.dao.UserRepository;
import com.pixelhaven.model.User;


// USE JAKARTA FOR TOMCAT 11
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Basic Validation
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Email and password are required.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        // Check if email already exists
        if (UserRepository.isEmailTaken(email)) {
            req.setAttribute("errorMessage", "This email is already registered.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        // 1. SAVE THE USER
        UserRepository.addUser(new User(email, password));

        // 2. AUTO-LOGIN (Create the Session)
        HttpSession session = req.getSession();
        session.setAttribute("username", email); // This line logs them in!

        // 3. REDIRECT TO HOME PAGE
        resp.sendRedirect("index.jsp");
    }
}