package com.harpia.HarpiaHealthAnalysisWS.model.bloodresult;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "blood_result")
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
    private int bloodPresure;
    @Column(name = "created_at", columnDefinition = "TIMESTAMP")
    private LocalDateTime createdAt = LocalDateTime.now();

    public BloodResult(int counter) {
        createdAt = LocalDateTime.now().minusMinutes(counter);
    }

    @Override
    public String toString() {
        return "BloodMeasurement{" +
                "id=" + id +
                ", bloodSugar=" + bloodSugar +
                ", bloodPresure=" + bloodPresure +
                '}';
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

    public int getBloodPresure() {
        return bloodPresure;
    }

    public void setBloodPresure(int bloodPresure) {
        this.bloodPresure = bloodPresure;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
