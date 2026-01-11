package com.pixelhaven.servlet;

import com.pixelhaven.model.CartItem;
import com.pixelhaven.model.PixelPhone;
import com.pixelhaven.dao.PhoneRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    // --- THIS IS THE MISSING PART THAT FIXES YOUR ERROR ---
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action"); // Line 42 is likely here
        HttpSession session = req.getSession();

        // Load existing cart or create new one
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        if ("add".equals(action)) {
            String id = req.getParameter("id");

            // GET THE SPECIFIC CHOICES SENT FROM JSP
            String color = req.getParameter("color");
            String storage = req.getParameter("storage");

            // Parse price carefully
            double price = 0.0;
            try {
                price = Double.parseDouble(req.getParameter("price"));
            } catch (Exception e) {
                System.out.println("Error parsing price");
            }

            PixelPhone phone = PhoneRepository.getPhoneById(id);

            if (phone != null) {
                boolean found = false;

                // STRICT MERGE CHECK: Only merge if ID, COLOR, AND STORAGE all match
                for (CartItem item : cart) {
                    if (item.getPhone().getId().equals(id) &&
                            item.getSelectedColor().equals(color) &&
                            item.getSelectedStorage().equals(storage)) {

                        item.setQuantity(item.getQuantity() + 1);
                        found = true;
                        break;
                    }
                }

                // If not found, add as NEW item
                if (!found) {
                    cart.add(new CartItem(phone, 1, color, storage, price));
                }
            }
        }
        else if ("remove".equals(action)) {
            String id = req.getParameter("id");
            String color = req.getParameter("color");
            String storage = req.getParameter("storage");

            // Safe removal
            if (id != null && color != null && storage != null) {
                cart.removeIf(item -> item.getPhone().getId().equals(id) &&
                        item.getSelectedColor().equals(color) &&
                        item.getSelectedStorage().equals(storage));
            }
        }

        session.setAttribute("cart", cart);
        resp.sendRedirect("cart.jsp");
    }
    // -----------------------------------------------------

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        // 1. Get the cart list from Session (create one if it doesn't exist)
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // 2. HANDLE "ADD TO CART"
        if ("add".equals(action)) {
            String id = request.getParameter("id");

            // 1. GET THE SPECIFIC CHOICES
            String color = request.getParameter("color");
            String storage = request.getParameter("storage");
            double price = Double.parseDouble(request.getParameter("price"));

            PixelPhone phone = PhoneRepository.getPhoneById(id);

            if (phone != null) {
                boolean found = false;

                // 2. STRICT MERGE CHECK (The Logic Fix)
                // Only merge if ID matches AND Color matches AND Storage matches
                for (CartItem item : cart) {
                    if (item.getPhone().getId().equals(id) &&
                            item.getSelectedColor().equals(color) &&
                            item.getSelectedStorage().equals(storage)) {

                        item.setQuantity(item.getQuantity() + 1);
                        found = true;
                        break;
                    }
                }

                // 3. IF DIFFERENT, ADD AS NEW ITEM
                if (!found) {
                    cart.add(new CartItem(phone, 1, color, storage, price));
                }
            }
        }

        // 3. HANDLE "REMOVE"
        // 3. HANDLE "REMOVE"
        if ("remove".equals(action)) {
            // Get the ID, Color, and Storage from the URL
            String id = request.getParameter("id");
            String color = request.getParameter("color");
            String storage = request.getParameter("storage");

            // Remove the item that matches ALL three criteria
            if (id != null && color != null && storage != null) {
                cart.removeIf(item -> item.getPhone().getId().equals(id) &&
                        item.getSelectedColor().equals(color) &&
                        item.getSelectedStorage().equals(storage));
            }

            // Reload the cart page
            // We redirect to "cart" (the servlet) so it recalculates totals if needed
            response.sendRedirect("cart");
            return;
        }

        String currentUser = (String) session.getAttribute("username");
        if (currentUser != null && cart != null) {
            com.pixelhaven.dao.CartRepository.saveCart(currentUser, cart);
        }

        // 4. CALCULATE TOTALS
        double subtotal = 0;
        for (CartItem item : cart) {
            subtotal += item.getTotalPrice();
        }
        request.setAttribute("cartSubtotal", subtotal);

        // 5. VIEW CART (Default)
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}