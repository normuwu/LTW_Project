package Model;

public class BlogPost {
    private int id;             // ID bài viết
    private String title;       // Tiêu đề
    private String image;       // Tên file ảnh (vd: blog1.jpg)
    private String category;    // Danh mục (vd: Kinh nghiệm, Sức khỏe)
    private String date;        // Ngày đăng
    private String author;      // Tác giả
    private String summary;     // Tóm tắt nội dung

    // Constructor mặc định
    public BlogPost() {}

    // Constructor đầy đủ
    public BlogPost(int id, String title, String image, String category, String date, String author, String summary) {
        this.id = id;
        this.title = title;
        this.image = image;
        this.category = category;
        this.date = date;
        this.author = author;
        this.summary = summary;
    }

    // Constructor không có id (cho backward compatibility)
    public BlogPost(String title, String image, String category, String date, String author, String summary) {
        this.title = title;
        this.image = image;
        this.category = category;
        this.date = date;
        this.author = author;
        this.summary = summary;
    }

    // --- GETTERS & SETTERS ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
    
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    
    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }
}
