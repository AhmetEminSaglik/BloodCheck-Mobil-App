package com.harpia.HarpiaHealthAnalysisWS.model.users;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "doctor")
public class Doctor extends User {
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


//    public Doctor() {
//        setRoleId(EnumUserRole.HEALTHCARE_PERSONAL.getId());
//    }

    @Override
    public String toString() {
        return "Doctor{" + super.toString() +
                "totalPatientNumber=" + totalPatientNumber +
                '}';
    }
}
