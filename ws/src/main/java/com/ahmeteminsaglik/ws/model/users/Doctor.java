package com.ahmeteminsaglik.ws.model.users;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "doctors")
@Getter
@Setter
public class Doctor extends User {
    @Column
    private String graduate = "";

    @Column
    private String specialization = "";

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

    @Override
    public String toString() {
        return "Doctor{" +
                super.toString() + "," +
                "graduate='" + graduate + '\'' +
                ", specialization='" + specialization + '\'' +
                '}';
    }
}
