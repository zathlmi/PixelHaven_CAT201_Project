package com.pixelhaven.dao;

import com.pixelhaven.model.CartItem;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CartRepository {


    private static final String FILE_PATH = System.getProperty("user.home") + File.separator + "pixelhaven_carts.ser";

    // Map: Username -> List of Cart Items
    private static Map<String, List<CartItem>> allUserCarts = new HashMap<>();

    static {
        loadCarts(); // Load data when server starts
    }

    // --- PUBLIC METHODS ---

    // Get a specific user's cart
    public static List<CartItem> getCart(String username) {
        return allUserCarts.getOrDefault(username, new ArrayList<>());
    }

    // Save a specific user's cart
    public static void saveCart(String username, List<CartItem> cart) {
        allUserCarts.put(username, cart);
        saveToFile();
    }

    // --- PRIVATE FILE SAVING ---

    private static void saveToFile() {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE_PATH))) {
            oos.writeObject(allUserCarts);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings("unchecked")
    private static void loadCarts() {
        File file = new File(FILE_PATH);
        if (file.exists()) {
            try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file))) {
                allUserCarts = (Map<String, List<CartItem>>) ois.readObject();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}