package com.harpia.HarpiaHealthAnalysisWS.model.users;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.harpia.HarpiaHealthAnalysisWS.model.disease.Disease;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "patients")
public class Patient extends User {
    //    @Column(name = "diabetic_type")
//    int bloodSugar;
//    int bloodPressure;
//    int cholesterol;
//    @OneToMany(mappedBy = "disease")
   /* @Column(name = "disaseList")
    @OneToMany(mappedBy = "patient")
    @JsonBackReference
//    @NonNull
    List<Disease> diseasesList;*/

    /*@ManyToOne
    @JoinColumn(name = "healthcare_personnel_id")
    private Doctor healthcarePersonnel;*/
    private long doctorId;

    /*public Patient() {
        setRoleId(EnumUserRole.PATIENT.getId());
    }*/

    @Override
    public String toString() {
        return "Patient{" + super.toString() + ", " +
//                "diseasesList=" + diseasesList +
                '}';
    }
}
