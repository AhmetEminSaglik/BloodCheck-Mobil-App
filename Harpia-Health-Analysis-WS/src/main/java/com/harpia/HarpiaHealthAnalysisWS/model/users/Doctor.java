package com.harpia.HarpiaHealthAnalysisWS.model.users;

import jakarta.persistence.*;
import lombok.*;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "doctor")
@Getter
@Setter
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
