package com.pixelhaven.model;

import java.io.Serializable;

// Must implement Serializable to be saved to a file
public class User implements Serializable {
    private static final long serialVersionUID = 1L; // Recommended for versioning
    private String email;
    private String password;
    private String role;

    // Constructor for normal registration (default role is "user")
    public User(String email, String password) {
        this.email = email;
        this.password = password;
        this.role = "user";
    }

    // NEW Constructor for Admin or custom roles
    public User(String email, String password, String role) {
        this.email = email;
        this.password = password;
        this.role = role;
    }

    // Getters and Setters
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}