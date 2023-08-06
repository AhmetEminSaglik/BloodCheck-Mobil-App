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
