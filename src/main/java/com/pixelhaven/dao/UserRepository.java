package com.pixelhaven.dao;

import com.pixelhaven.model.User;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserRepository {
    // 1. Define the storage file path on the hard drive
    private static final String FILE_PATH = System.getProperty("user.home") + File.separator + "pixelhaven_users.ser";
    private static List<User> registeredUsers = new ArrayList<>();

    // 2. Static block to load data when the app starts
    static {
        loadData();
        if (registeredUsers.isEmpty()) {
            // Default Admin
            registeredUsers.add(new User("admin1@gmail.com", "admin123", "admin"));
            saveData();
        }
    }

    // 3. Save the list to the disk
    private static void saveData() {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE_PATH))) {
            oos.writeObject(registeredUsers);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 4. Load the list from the disk
    @SuppressWarnings("unchecked")
    private static void loadData() {
        File file = new File(FILE_PATH);
        if (file.exists()) {
            try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file))) {
                registeredUsers = (List<User>) ois.readObject();
            } catch (IOException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
    }

    public static void addUser(User user) {
        registeredUsers.add(user);
        saveData(); // Save every time a new user signs up
    }

    public static boolean validate(String email, String password) {
        for (User user : registeredUsers) {
            if (user.getEmail().equalsIgnoreCase(email) && user.getPassword().equals(password)) {
                return true;
            }
        }
        return false;
    }

    public static boolean isEmailTaken(String email) {
        for (User user : registeredUsers) {
            if (user.getEmail().equalsIgnoreCase(email)) return true;
        }
        return false;
    }
}