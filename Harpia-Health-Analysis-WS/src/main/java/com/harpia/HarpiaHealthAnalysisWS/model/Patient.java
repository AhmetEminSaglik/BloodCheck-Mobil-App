package com.harpia.HarpiaHealthAnalysisWS.model;

import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "patients")
public class Patient extends User {
    @Column(name = "diabetic_type")
    int diabeticType;
    @Transient
    private final EnumUserRole enumRole = EnumUserRole.PATIENT;

    public Patient() {
        setUserRole(EnumUserRole.PATIENT);
    }

    public Patient(int diabeticType) {
        this();
        this.diabeticType = diabeticType;
    }

    @Override
    public String toString() {
        return "Patient{" + super.toString() +
                "diabeticType=" + diabeticType +
                '}';
    }
}
