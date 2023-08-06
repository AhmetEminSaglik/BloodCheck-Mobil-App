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

    @Override
    public String toString() {
        return "Doctor{" + super.toString() +
                "totalPatientNumber=" + totalPatientNumber +
                '}';
    }
}
