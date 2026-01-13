package Model;

import java.sql.Timestamp;
import java.text.NumberFormat;
import java.util.Locale;

public class Vaccine {
    private int id;
    private String name;
    private String description;
    private String targetSpecies;    // Chó, Mèo, Tất cả
    private String manufacturer;
    private long price;
    private int dosesRequired;       // Số mũi cần tiêm
    private int intervalDays;        // Khoảng cách giữa các mũi (ngày)
    private int minAgeWeeks;         // Tuổi tối thiểu (tuần)
    private int stockQuantity;       // Số lượng tồn kho
    private boolean isActive;
    private Timestamp createdAt;

    public Vaccine() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getTargetSpecies() { return targetSpecies; }
    public void setTargetSpecies(String targetSpecies) { this.targetSpecies = targetSpecies; }

    public String getManufacturer() { return manufacturer; }
    public void setManufacturer(String manufacturer) { this.manufacturer = manufacturer; }

    public long getPrice() { return price; }
    public void setPrice(long price) { this.price = price; }

    public int getDosesRequired() { return dosesRequired; }
    public void setDosesRequired(int dosesRequired) { this.dosesRequired = dosesRequired; }

    public int getIntervalDays() { return intervalDays; }
    public void setIntervalDays(int intervalDays) { this.intervalDays = intervalDays; }

    public int getMinAgeWeeks() { return minAgeWeeks; }
    public void setMinAgeWeeks(int minAgeWeeks) { this.minAgeWeeks = minAgeWeeks; }

    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    // Formatted price
    public String getFormattedPrice() {
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        return formatter.format(price) + "đ";
    }
    
    // Stock status
    public String getStockStatus() {
        if (stockQuantity <= 0) return "Hết hàng";
        if (stockQuantity <= 10) return "Sắp hết";
        return "Còn hàng";
    }
    
    public String getStockStatusClass() {
        if (stockQuantity <= 0) return "out-of-stock";
        if (stockQuantity <= 10) return "low-stock";
        return "in-stock";
    }
    
    // Target species icon
    public String getTargetIcon() {
        if ("Chó".equals(targetSpecies)) return "bxs-dog";
        if ("Mèo".equals(targetSpecies)) return "bxs-cat";
        return "bxs-injection";
    }
}
