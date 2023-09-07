package com.harpia.HarpiaHealthAnalysisWS.model.users;

import jakarta.persistence.*;
import lombok.*;

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
        return "Patient{" +
                "doctorId=" + doctorId +
                ", diabeticTypeId=" + diabeticTypeId +
                '}';
    }

    public long getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(long doctorId) {
        this.doctorId = doctorId;
    }

    public int getDiabeticTypeId() {
        return diabeticTypeId;
    }

    public void setDiabeticTypeId(int diabeticTypeId) {
        this.diabeticTypeId = diabeticTypeId;
    }
}
