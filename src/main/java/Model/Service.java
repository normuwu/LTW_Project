package Model;

public class Service {
    private int id;
    private String name;
    private String price;
    private String description;
    private String category;
    private int durationMinutes;
    private boolean isActive;
    private String image;

    public Service() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPrice() { return price; }
    public void setPrice(String price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public int getDurationMinutes() { return durationMinutes; }
    public void setDurationMinutes(int durationMinutes) { this.durationMinutes = durationMinutes; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    
    // Get formatted duration
    public String getFormattedDuration() {
        if (durationMinutes < 60) {
            return durationMinutes + " phút";
        } else if (durationMinutes == 1440) {
            return "1 ngày";
        } else {
            int hours = durationMinutes / 60;
            int mins = durationMinutes % 60;
            if (mins > 0) {
                return hours + "h " + mins + "p";
            }
            return hours + " giờ";
        }
    }
    
    // Get category icon
    public String getCategoryIcon() {
        switch (category) {
            case "Khám chữa bệnh": return "bx-plus-medical";
            case "Phẫu thuật": return "bx-cut";
            case "Tiêm chủng": return "bx-injection";
            case "Spa & Grooming": return "bx-bath";
            case "Lưu trú": return "bx-home-heart";
            case "Xét nghiệm": return "bx-test-tube";
            case "Chẩn đoán hình ảnh": return "bx-scan";
            case "Nha khoa": return "bx-smile";
            default: return "bx-first-aid";
        }
    }
}
