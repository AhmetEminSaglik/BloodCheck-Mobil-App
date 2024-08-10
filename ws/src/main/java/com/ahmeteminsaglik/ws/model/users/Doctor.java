package com.ahmeteminsaglik.ws.model.users;

import jakarta.persistence.*;
import lombok.*;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "doctors")
@Getter
@Setter
public class Doctor extends User {
    @Column
    String graduate = "";

    @Column
    String specialization = "";

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
