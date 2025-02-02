package com.ahmeteminsaglik.ws.model.dto;

import com.ahmeteminsaglik.ws.model.users.Doctor;

public class DoctorDto extends UserDto {
    private String graduate = "";
    private String specialization = "";

    public DoctorDto(Doctor doctor) {
        super(doctor);
        this.graduate = doctor.getGraduate();
        this.specialization = doctor.getSpecialization();
    }

    public String getGraduate() {
        return graduate;
    }

    public void setGraduate(String graduate) {
        this.graduate = graduate;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }
}
