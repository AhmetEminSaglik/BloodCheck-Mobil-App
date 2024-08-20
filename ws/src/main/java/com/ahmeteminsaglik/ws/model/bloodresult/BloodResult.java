package com.ahmeteminsaglik.ws.model.bloodresult;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "blood_results")
public class BloodResult {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;
    @Column(name = "patient_id")
    private long patientId;
    @Column(name = "blood_sugar")
    private int bloodSugar;
    @Column(name = "blood_pressure")
    private int bloodPressure;
    @Column(name = "calcium")
    private int calcium;
    @Column(name = "magnesium")
    private int magnesium;
    @Column(name = "created_at", columnDefinition = "TIMESTAMP")
    private OffsetDateTime createdAt = OffsetDateTime.now().withOffsetSameInstant(ZoneOffset.UTC);

    public BloodResult(int counter) {
        createdAt.minusMinutes(counter);
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public long getPatientId() {
        return patientId;
    }

    public void setPatientId(long patientId) {
        this.patientId = patientId;
    }

    public int getBloodSugar() {
        return bloodSugar;
    }

    public void setBloodSugar(int bloodSugar) {
        this.bloodSugar = bloodSugar;
    }

    public int getBloodPressure() {
        return bloodPressure;
    }

    public void setBloodPressure(int bloodPressure) {
        this.bloodPressure = bloodPressure;
    }

    public int getCalcium() {
        return calcium;
    }

    public void setCalcium(int calcium) {
        this.calcium = calcium;
    }

    public int getMagnesium() {
        return magnesium;
    }

    public void setMagnesium(int magnesium) {
        this.magnesium = magnesium;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(OffsetDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "BloodResult{" +
                "id=" + id +
                ", patientId=" + patientId +
                ", bloodSugar=" + bloodSugar +
                ", bloodPressure=" + bloodPressure +
                ", calcium=" + calcium +
                ", magnesium=" + magnesium +
                ", createdAt=" + createdAt +
                '}';
    }
}
