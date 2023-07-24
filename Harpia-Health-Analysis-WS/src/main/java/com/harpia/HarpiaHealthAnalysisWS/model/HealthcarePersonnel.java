package com.harpia.HarpiaHealthAnalysisWS.model;

import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "healthcare_personnels")
public class HealthcarePersonnel extends User {
    @Column
    int totalPatientNumber;

    @Transient
    private final EnumUserRole enumRole = EnumUserRole.HEALTHCARE_PERSONNEL;

    public HealthcarePersonnel() {
        setUserRole(enumRole);
    }

    public HealthcarePersonnel(int totalPatientNumber) {
        this();
        this.totalPatientNumber = totalPatientNumber;
    }

    @Override
    public String toString() {
        return "HealthcarePersonnel{" + super.toString() +
                "totalPatientNumber=" + totalPatientNumber +
                '}';
    }
}
