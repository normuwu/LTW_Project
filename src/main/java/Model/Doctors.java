package Model;


public class Doctors {
    private String name;
    private String image; 
    private int id;

    public Doctors(String name, String image, int id) {
    	
        this.name = name;
        this.image = image;
        this.id = id;
    }
    // Getters
    public String getName() { return name; }
    public String getImage() { return image; }
    public int getId() { return id; }
}