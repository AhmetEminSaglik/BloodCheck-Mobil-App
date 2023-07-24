package com.harpia.HarpiaHealthAnalysisWS.model;

import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@Entity
@AllArgsConstructor
@Table(name = "patients")
public class Patient extends User {
    @Column(name = "diabetic_type")
    int diabeticType;

    public Patient() {
        setUserRoleId(EnumUserRole.PATIENT.getId());
    }

    @Override
    public String toString() {
        return "Patient{" + super.toString() +
                "diabeticType=" + diabeticType +
                '}';
    }
}
