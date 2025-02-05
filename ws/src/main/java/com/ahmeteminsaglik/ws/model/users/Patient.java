package com.ahmeteminsaglik.ws.model.users;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

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
        return "Patient{" + super.toString() +
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