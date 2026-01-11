package com.pixelhaven.dao;

import com.pixelhaven.model.PixelPhone;
import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class PhoneRepository {
    private static final String FILE_PATH = System.getProperty("user.home") + File.separator + "pixelhaven_data.ser";
    private static List<PixelPhone> phoneList = new ArrayList<>();

    static {
        loadData();
        if (phoneList.isEmpty()) {
            initDefaultData();
            saveData();
        }
    }

    private static void saveData() {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE_PATH))) {
            oos.writeObject(phoneList);
        } catch (IOException e) { e.printStackTrace(); }
    }

    @SuppressWarnings("unchecked")
    private static void loadData() {
        File file = new File(FILE_PATH);
        if (file.exists()) {
            try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file))) {
                phoneList = (List<PixelPhone>) ois.readObject();
            } catch (IOException | ClassNotFoundException e) { e.printStackTrace(); }
        }
    }

    public static List<PixelPhone> getAllPhones() {
        List<PixelPhone> sortedList = new ArrayList<>(phoneList);
        sortedList.sort((p1, p2) -> p1.getSeries().compareTo(p2.getSeries()));
        return sortedList;
    }

    public static void addPhone(PixelPhone phone) {
        phoneList.add(phone);
        saveData();
    }

    public static List<String> getAllSeries() {
        List<String> series = new ArrayList<>();
        for (PixelPhone p : phoneList) {
            if (!series.contains(p.getSeries())) series.add(p.getSeries());
        }
        return series;
    }

    private static void initDefaultData() {
        // 1. PIXEL 10 PRO XL
        phoneList.add(new PixelPhone("P10XL", "Pixel 10 Pro XL", "The ultimate Pixel experience.", 6299.0, "pixel10pro_moonstone.jpg", "Pixel 10 Series",
                Arrays.asList("#A8A9AD", "#00A86B", "#F0EFE9", "#121212"), Arrays.asList("Moonstone", "Jade", "Porcelain", "Obsidian"),
                Arrays.asList("pixel10pro_moonstone.jpg", "pixel10pro_jade.jpg", "pixel10proxl_porcelain.jpg", "pixel10pro_obsidian.jpg"),
                Arrays.asList("256GB", "512GB", "1TB"), Arrays.asList(6299.0, 7199.0, 8099.0), "6.3-inch", "232g", "4870mAh", "50MP", "42MP"));

        // 2. PIXEL 10 PRO
        phoneList.add(new PixelPhone("P10PRO", "Pixel 10 Pro", "Pro performance, perfect size.", 5699.0, "pixel10pro_moonstone.jpg", "Pixel 10 Series",
                Arrays.asList("#A8A9AD", "#00A86B", "#F0EFE9", "#121212"), Arrays.asList("Moonstone", "Jade", "Porcelain", "Obsidian"),
                Arrays.asList("pixel10pro_moonstone.jpg", "pixel10pro_jade.jpg", "pixel10proxl_porcelain.jpg", "pixel10pro_obsidian.jpg"),
                Arrays.asList("128GB", "256GB"), Arrays.asList(5699.0, 6199.0), "6.3-inch", "199g", "4700mAh", "50MP", "42MP"));

        // 3. PIXEL 10
        phoneList.add(new PixelPhone("P10", "Pixel 10", "Sleek new design for everyone.", 4499.0, "pixel10_indigo.jpg", "Pixel 10 Series",
                Arrays.asList("#4B5E8F", "#E2E7EB", "#D9E3A9", "#2E2F33"), Arrays.asList("Indigo", "Frost", "Lemongrass", "Obsidian"),
                Arrays.asList("pixel10_indigo.jpg", "pixel10_frost.jpg", "pixel10_lemongrass.jpg", "pixel10_obsidian.jpg"),
                Arrays.asList("128GB", "256GB"), Arrays.asList(4499.0, 4999.0), "6.3-inch", "187g", "4700mAh", "50MP", "10.5MP"));

        // 4. PIXEL 9 PRO XL
        phoneList.add(new PixelPhone("P9PROXL", "Pixel 9 Pro XL", "Large, immersive display.", 5699.0, "pixel9proxl_porcelain.jpg", "Pixel 9 Series",
                Arrays.asList("#F0EFE9", "#F3CFD5", "#8E9182", "#121212"), Arrays.asList("Porcelain", "Rose Quartz", "Hazel", "Obsidian"),
                Arrays.asList("pixel9proxl_porcelain.jpg", "pixel9proxl_rosequartz.jpg", "pixel9proxl_hazel.jpg", "pixel9proxl_obsidian.jpg"),
                Arrays.asList("128GB", "256GB", "512GB"), Arrays.asList(5699.0, 6299.0, 7299.0), "6.8-inch", "221g", "5060mAh", "50MP", "42MP"));

        // 5. PIXEL 9 PRO (FIXED IMAGE NAME)
        phoneList.add(new PixelPhone("P9PRO", "Pixel 9 Pro", "Pro camera, compact size.", 5199.0, "pixel9proxl_porcelain.jpg", "Pixel 9 Series",
                Arrays.asList("#F0EFE9", "#F3CFD5", "#8E9182", "#121212"), Arrays.asList("Porcelain", "Rose Quartz", "Hazel", "Obsidian"),
                Arrays.asList("pixel9proxl_porcelain.jpg", "pixel9proxl_rosequartz.jpg", "pixel9proxl_hazel.jpg", "pixel9proxl_obsidian.jpg"),
                Arrays.asList("128GB", "256GB"), Arrays.asList(5199.0, 5799.0), "6.3-inch", "199g", "4700mAh", "50MP", "42MP"));

        // 6. PIXEL 9
        phoneList.add(new PixelPhone("P9", "Pixel 9", "Google AI to help you do more.", 3999.0, "pixel9_peony.jpg", "Pixel 9 Series",
                Arrays.asList("#E38FAB", "#C6E5D9", "#F0EFE9", "#121212"), Arrays.asList("Peony", "Wintergreen", "Porcelain", "Obsidian"),
                Arrays.asList("pixel9_peony.jpg", "pixel9_wintergreen.jpg", "pixel9_porcelain.jpg", "pixel9_obsidian.jpg"),
                Arrays.asList("128GB", "256GB"), Arrays.asList(3999.0, 4499.0), "6.3-inch", "198g", "4700mAh", "50MP", "10.5MP"));
    }

    public static void deletePhone(String id) {
        // 1. Remove the phone from the list if the ID matches
        // removeIf returns true if an element was actually removed
        if (phoneList.removeIf(p -> p.getId().equals(id))) {
            // 2. Save the updated list to pixelhaven_data.ser
            saveData();
        }
    }

    public static PixelPhone getPhoneById(String id) {
        // 1. Loop through the list of phones
        for (PixelPhone p : phoneList) {
            // 2. Check if the current phone's ID matches the one we are looking for
            // Using equalsIgnoreCase is safer in case of accidental capital letters
            if (p.getId().equalsIgnoreCase(id)) {
                return p; // Found it! Return the phone object
            }
        }
        // 3. If we finish the loop and find nothing, return null
        return null;
    }

    public static void updatePhone(PixelPhone updatedPhone) {
        // 1. Loop through the phone list to find the matching ID
        for (int i = 0; i < phoneList.size(); i++) {
            // 2. Compare the ID of the current list item with the updated one
            if (phoneList.get(i).getId().equals(updatedPhone.getId())) {
                // 3. Replace the old object with the new one at the same position
                phoneList.set(i, updatedPhone);

                // 4. Save the changes to the .ser file immediately
                saveData();

                // 5. Exit the method once the update is done
                return;
            }
        }
    }
}