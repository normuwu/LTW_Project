package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Context.DBContext;
import Model.Doctors;

public class DoctorDAO {
    public List<Doctors> getAllDoctors() {
        List<Doctors> list = new ArrayList<>();
        String query = "SELECT * FROM Doctors";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Constructor của Doctor là (name, image)
                list.add(new Doctors(
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getInt("id")
                ));
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}