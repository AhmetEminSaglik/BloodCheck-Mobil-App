package com.harpia.HarpiaHealthAnalysisWS.model.users;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
    @Column
    private long doctorId;
    @Column
    private int diabeticTypeId;

    @Override
    public String toString() {
        return "Patient{" + super.toString() + ", " +
                '}';
    }
}
