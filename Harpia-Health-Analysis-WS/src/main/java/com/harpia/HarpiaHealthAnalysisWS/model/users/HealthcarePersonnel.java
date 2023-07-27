package com.harpia.HarpiaHealthAnalysisWS.model.users;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ManyToAny;

import java.util.List;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "healthcare_personnels")
public class HealthcarePersonnel extends User {
    @Column
    int totalPatientNumber;

    @Column(name = "disaseList")
//    @OneToMany(mappedBy = "healthcarePersonnel")
//    @ManyToMany
//    @ManyToMany/*(mappedBy = "patient")*/
/*
    @ManyToAny
    @JsonBackReference
    List<Patient> patientLisssttt;
*/


//    public HealthcarePersonnel() {
//        setRoleId(EnumUserRole.HEALTHCARE_PERSONAL.getId());
//    }

    @Override
    public String toString() {
        return "HealthcarePersonnel{" + super.toString() +
                "totalPatientNumber=" + totalPatientNumber +
                '}';
    }
}
