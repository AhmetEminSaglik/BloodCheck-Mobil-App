package com.ahmeteminsaglik.ws.model.dto;

import com.ahmeteminsaglik.ws.model.users.Patient;

public class PatientDto extends UserDto{
    private long doctorId;
    private int diabeticTypeId;
    public PatientDto(Patient patient) {
        super(patient);
        this.doctorId = patient.getDoctorId();
        this.diabeticTypeId = patient.getDiabeticTypeId();
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
