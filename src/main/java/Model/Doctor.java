package Model;


public class Doctor {
    private String name;
    private String image; 

    public Doctor(String name, String image) {
        this.name = name;
        this.image = image;
    }
    // Getters
    public String getName() { return name; }
    public String getImage() { return image; }
}