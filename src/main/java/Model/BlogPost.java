package Model;

public class BlogPost {
    private String title;       // Tiêu đề
    private String image;       // Tên file ảnh (vd: blog1.jpg)
    private String category;    // Danh mục (vd: Kinh nghiệm, Sức khỏe)
    private String date;        // Ngày đăng
    private String author;      // Tác giả
    private String summary;     // Tóm tắt nội dung

    // Constructor
    public BlogPost(String title, String image, String category, String date, String author, String summary) {
        this.title = title;
        this.image = image;
        this.category = category;
        this.date = date;
        this.author = author;
        this.summary = summary;
    }

    // --- GETTERS (Bắt buộc để JSTL đọc được) ---
    public String getTitle() { return title; }
    public String getImage() { return image; }
    public String getCategory() { return category; }
    public String getDate() { return date; }
    public String getAuthor() { return author; }
    public String getSummary() { return summary; }
}