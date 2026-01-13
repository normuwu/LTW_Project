package Model;

import java.sql.Date;
import java.sql.Timestamp;

public class Pet {
    private int id;
    private int userId;
    private String name;
    private String species;      // Chó, Mèo, Khác
    private String breed;        // Giống
    private String gender;       // Đực, Cái
    private Date birthDate;
    private double weight;
    private String color;
    private String image;
    private String notes;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Calculated fields
    private String age;          // Tuổi tính toán
    private int vaccinationCount; // Số mũi đã tiêm

    public Pet() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSpecies() { return species; }
    public void setSpecies(String species) { this.species = species; }

    public String getBreed() { return breed; }
    public void setBreed(String breed) { this.breed = breed; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public Date getBirthDate() { return birthDate; }
    public void setBirthDate(Date birthDate) { this.birthDate = birthDate; }

    public double getWeight() { return weight; }
    public void setWeight(double weight) { this.weight = weight; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getAge() { return age; }
    public void setAge(String age) { this.age = age; }

    public int getVaccinationCount() { return vaccinationCount; }
    public void setVaccinationCount(int vaccinationCount) { this.vaccinationCount = vaccinationCount; }
    
    // Helper method to calculate age from birthDate
    public String calculateAge() {
        if (birthDate == null) return "Chưa rõ";
        
        long diffInMillis = System.currentTimeMillis() - birthDate.getTime();
        long days = diffInMillis / (1000 * 60 * 60 * 24);
        
        if (days < 30) {
            return days + " ngày";
        } else if (days < 365) {
            int months = (int) (days / 30);
            return months + " tháng";
        } else {
            int years = (int) (days / 365);
            int remainingMonths = (int) ((days % 365) / 30);
            if (remainingMonths > 0) {
                return years + " tuổi " + remainingMonths + " tháng";
            }
            return years + " tuổi";
        }
    }
    
    // Get species icon
    public String getSpeciesIcon() {
        if ("Mèo".equals(species)) return "bxs-cat";
        if ("Chó".equals(species)) return "bxs-dog";
        return "bxs-paw";
    }
}
