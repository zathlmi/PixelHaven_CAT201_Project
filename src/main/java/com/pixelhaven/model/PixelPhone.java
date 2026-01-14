package com.pixelhaven.model;

import java.io.Serializable;
import java.util.List;

public class PixelPhone implements Serializable {
    private String id;
    private String name;
    private String description;
    private double defaultPrice;
    private String defaultImageUrl;
    private String series;
    private List<String> colors;
    private List<String> colorNames;
    private List<String> colorImages;
    private List<String> storage;
    private List<Double> storagePrices;
    private String displaySpecs;
    private String dimensionSpecs;
    private String batterySpecs;
    private String rearCameraSpecs;
    private String frontCameraSpecs;

    public PixelPhone(String id, String name, String description, double defaultPrice,
                      String defaultImageUrl, String series, List<String> colors,
                      List<String> colorNames, List<String> colorImages,
                      List<String> storage, List<Double> storagePrices,
                      String displaySpecs, String dimensionSpecs, String batterySpecs,
                      String rearCameraSpecs, String frontCameraSpecs) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.defaultPrice = defaultPrice;
        this.defaultImageUrl = defaultImageUrl;
        this.series = series;
        this.colors = colors;
        this.colorNames = colorNames;
        this.colorImages = colorImages;
        this.storage = storage;
        this.storagePrices = storagePrices;
        this.displaySpecs = displaySpecs;
        this.dimensionSpecs = dimensionSpecs;
        this.batterySpecs = batterySpecs;
        this.rearCameraSpecs = rearCameraSpecs;
        this.frontCameraSpecs = frontCameraSpecs;
    }

    // GETTERS (Required for catalog.jsp and product-specs.jsp)
    public String getId() { return id; }
    public String getName() { return name; }
    public String getDescription() { return description; }
    public double getDefaultPrice() { return defaultPrice; }
    public String getDefaultImageUrl() { return defaultImageUrl; }
    public String getSeries() { return series; }
    public List<String> getColors() { return colors; }
    public List<String> getColorNames() { return colorNames; }
    public List<String> getColorImages() { return colorImages; }
    public List<String> getStorage() { return storage; }
    public List<Double> getStoragePrices() { return storagePrices; }
    public String getDisplaySpecs() { return displaySpecs; }
    public String getDimensionSpecs() { return dimensionSpecs; }
    public String getBatterySpecs() { return batterySpecs; }
    public String getRearCameraSpecs() { return rearCameraSpecs; }
    public String getFrontCameraSpecs() { return frontCameraSpecs; }


    public void setName(String name) { this.name = name; }
    public void setSeries(String series) { this.series = series; }
    public void setDefaultPrice(double defaultPrice) { this.defaultPrice = defaultPrice; }
    public void setDescription(String description) { this.description = description; }
    public void setDefaultImageUrl(String defaultImageUrl) { this.defaultImageUrl = defaultImageUrl; }
}