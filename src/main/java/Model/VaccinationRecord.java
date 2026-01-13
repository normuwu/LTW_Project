package Model;

import java.sql.Date;
import java.sql.Timestamp;

public class VaccinationRecord {
    private int id;
    private int petId;
    private int vaccineId;
    private Integer appointmentId;
    private Integer doctorId;
    private Date vaccinationDate;
    private int doseNumber;
    private String batchNumber;
    private Date nextDueDate;
    private String notes;
    private Timestamp createdAt;
    
    // Joined fields
    private String petName;
    private String vaccineName;
    private String doctorName;
    private String petSpecies;
    private String ownerName;

    public VaccinationRecord() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPetId() { return petId; }
    public void setPetId(int petId) { this.petId = petId; }

    public int getVaccineId() { return vaccineId; }
    public void setVaccineId(int vaccineId) { this.vaccineId = vaccineId; }

    public Integer getAppointmentId() { return appointmentId; }
    public void setAppointmentId(Integer appointmentId) { this.appointmentId = appointmentId; }

    public Integer getDoctorId() { return doctorId; }
    public void setDoctorId(Integer doctorId) { this.doctorId = doctorId; }

    public Date getVaccinationDate() { return vaccinationDate; }
    public void setVaccinationDate(Date vaccinationDate) { this.vaccinationDate = vaccinationDate; }

    public int getDoseNumber() { return doseNumber; }
    public void setDoseNumber(int doseNumber) { this.doseNumber = doseNumber; }

    public String getBatchNumber() { return batchNumber; }
    public void setBatchNumber(String batchNumber) { this.batchNumber = batchNumber; }

    public Date getNextDueDate() { return nextDueDate; }
    public void setNextDueDate(Date nextDueDate) { this.nextDueDate = nextDueDate; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }

    public String getVaccineName() { return vaccineName; }
    public void setVaccineName(String vaccineName) { this.vaccineName = vaccineName; }

    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }

    public String getPetSpecies() { return petSpecies; }
    public void setPetSpecies(String petSpecies) { this.petSpecies = petSpecies; }
    
    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }
    
    // Check if next dose is due
    public boolean isDue() {
        if (nextDueDate == null) return false;
        return nextDueDate.before(new Date(System.currentTimeMillis()));
    }
    
    // Check if next dose is coming soon (within 7 days)
    public boolean isComingSoon() {
        if (nextDueDate == null) return false;
        long diff = nextDueDate.getTime() - System.currentTimeMillis();
        long days = diff / (1000 * 60 * 60 * 24);
        return days >= 0 && days <= 7;
    }
}
