package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Context.DBContext;
import Model.Pet;

public class PetDAO {

    // Lấy tất cả thú cưng của user
    public List<Pet> getPetsByUserId(int userId) {
        List<Pet> list = new ArrayList<>();
        String query = "SELECT p.*, " +
                       "(SELECT COUNT(*) FROM vaccination_records vr WHERE vr.pet_id = p.id) as vaccination_count " +
                       "FROM pets p WHERE p.user_id = ? ORDER BY p.created_at DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Pet pet = mapResultSetToPet(rs);
                    pet.setVaccinationCount(rs.getInt("vaccination_count"));
                    pet.setAge(pet.calculateAge());
                    list.add(pet);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy thú cưng theo ID
    public Pet getPetById(int id) {
        String query = "SELECT p.*, " +
                       "(SELECT COUNT(*) FROM vaccination_records vr WHERE vr.pet_id = p.id) as vaccination_count " +
                       "FROM pets p WHERE p.id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Pet pet = mapResultSetToPet(rs);
                    pet.setVaccinationCount(rs.getInt("vaccination_count"));
                    pet.setAge(pet.calculateAge());
                    return pet;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Thêm thú cưng mới
    public boolean insertPet(Pet pet) {
        String query = "INSERT INTO pets (user_id, name, species, breed, gender, birth_date, weight, color, image, notes) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, pet.getUserId());
            ps.setString(2, pet.getName());
            ps.setString(3, pet.getSpecies());
            ps.setString(4, pet.getBreed());
            ps.setString(5, pet.getGender());
            ps.setDate(6, pet.getBirthDate());
            ps.setDouble(7, pet.getWeight());
            ps.setString(8, pet.getColor());
            ps.setString(9, pet.getImage());
            ps.setString(10, pet.getNotes());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Cập nhật thú cưng
    public boolean updatePet(Pet pet) {
        String query = "UPDATE pets SET name = ?, species = ?, breed = ?, gender = ?, " +
                       "birth_date = ?, weight = ?, color = ?, image = ?, notes = ? WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, pet.getName());
            ps.setString(2, pet.getSpecies());
            ps.setString(3, pet.getBreed());
            ps.setString(4, pet.getGender());
            ps.setDate(5, pet.getBirthDate());
            ps.setDouble(6, pet.getWeight());
            ps.setString(7, pet.getColor());
            ps.setString(8, pet.getImage());
            ps.setString(9, pet.getNotes());
            ps.setInt(10, pet.getId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Xóa thú cưng
    public boolean deletePet(int id) {
        String query = "DELETE FROM pets WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Đếm số thú cưng của user
    public int countByUserId(int userId) {
        String query = "SELECT COUNT(*) FROM pets WHERE user_id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Kiểm tra thú cưng có thuộc về user không
    public boolean isPetOwnedByUser(int petId, int userId) {
        String query = "SELECT COUNT(*) FROM pets WHERE id = ? AND user_id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, petId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Helper method
    private Pet mapResultSetToPet(ResultSet rs) throws Exception {
        Pet pet = new Pet();
        pet.setId(rs.getInt("id"));
        pet.setUserId(rs.getInt("user_id"));
        pet.setName(rs.getString("name"));
        pet.setSpecies(rs.getString("species"));
        pet.setBreed(rs.getString("breed"));
        pet.setGender(rs.getString("gender"));
        pet.setBirthDate(rs.getDate("birth_date"));
        pet.setWeight(rs.getDouble("weight"));
        pet.setColor(rs.getString("color"));
        pet.setImage(rs.getString("image"));
        pet.setNotes(rs.getString("notes"));
        pet.setCreatedAt(rs.getTimestamp("created_at"));
        pet.setUpdatedAt(rs.getTimestamp("updated_at"));
        return pet;
    }
}
