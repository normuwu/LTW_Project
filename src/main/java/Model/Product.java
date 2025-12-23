package Model; // Dựa theo cấu trúc thư mục trong ảnh

import java.text.DecimalFormat;

public class Product {
    private int id;
    private String name;
    private String image;
    private double price;     // Giá hiện tại
    private double oldPrice;  // Giá cũ (nếu có)
    private int discount;     // % Giảm giá (VD: 10)

    public Product(int id, String name, String image, double price, double oldPrice, int discount) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.price = price;
        this.oldPrice = oldPrice;
        this.discount = discount;
    }

    // --- GETTERS (Bắt buộc để JSP đọc được dữ liệu) ---
    public int getId() { return id; }
    public String getName() { return name; }
    public String getImage() { return image; }
    public double getPrice() { return price; }
    public double getOldPrice() { return oldPrice; }
    public int getDiscount() { return discount; }

    // --- XỬ LÝ ĐỊNH DẠNG TIỀN TỆ CHO JSP ---
    // JSP gọi: ${p.formattedPrice}
    public String getFormattedPrice() {
        DecimalFormat formatter = new DecimalFormat("###,###");
        return formatter.format(price) + "đ";
    }

    // JSP gọi: ${p.formattedOldPrice}
    public String getFormattedOldPrice() {
        DecimalFormat formatter = new DecimalFormat("###,###");
        return formatter.format(oldPrice) + "đ";
    }
}