package com.pixelhaven.servlet;

import com.pixelhaven.dao.PhoneRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// 1. Mapped to "/admin" - Catches requests from your Dashboard
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        // --- HANDLE DELETE ---
        if ("delete".equals(action)) {
            String id = req.getParameter("id");
            if (id != null) {
                PhoneRepository.deletePhone(id);
            }
            // Refresh the page to show the item is gone
            resp.sendRedirect("admin.jsp");
            return;
        }

        // --- SHOW DASHBOARD (Default) ---
        // Pass the list of phones to admin.jsp so the table works
        req.setAttribute("phones", PhoneRepository.getAllPhones());
        req.getRequestDispatcher("admin.jsp").forward(req, resp);
    }
}