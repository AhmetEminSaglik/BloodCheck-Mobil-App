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


    public HealthcarePersonnel() {
        setRoleId(EnumUserRole.HEALTHCARE_PERSONNEL.getId());
    }

    @Override
    public String toString() {
        return "HealthcarePersonnel{" + super.toString() +
                "totalPatientNumber=" + totalPatientNumber +
                '}';
    }
}
