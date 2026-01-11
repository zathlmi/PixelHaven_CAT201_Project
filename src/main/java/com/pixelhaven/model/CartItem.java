package com.pixelhaven.model;

import java.io.Serializable;

public class CartItem implements Serializable {
    private PixelPhone phone;
    private int quantity;

    // --- NEW FIELDS FOR COLOR, STORAGE, PRICE ---
    private String selectedColor;
    private String selectedStorage;
    private double selectedPrice;

    // --- UPDATED CONSTRUCTOR (Accepts 5 arguments) ---
    // This matches what your CartServlet is trying to send
    public CartItem(PixelPhone phone, int quantity, String selectedColor, String selectedStorage, double selectedPrice) {
        this.phone = phone;
        this.quantity = quantity;
        this.selectedColor = selectedColor;
        this.selectedStorage = selectedStorage;
        this.selectedPrice = selectedPrice;
    }

    // --- GETTERS & SETTERS ---
    public PixelPhone getPhone() { return phone; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getSelectedColor() { return selectedColor; }
    public String getSelectedStorage() { return selectedStorage; }
    public double getSelectedPrice() { return selectedPrice; }

    // Helper to get total price for this item row
    public double getTotalPrice() {
        return this.selectedPrice * this.quantity;
    }
}