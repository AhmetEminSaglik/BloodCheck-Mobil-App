package com.harpia.HarpiaHealthAnalysisWS.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "healthcare_personnels")
public class HealthcarePersonnel extends User {
    @Column
    int totalPatientNumber;
}
