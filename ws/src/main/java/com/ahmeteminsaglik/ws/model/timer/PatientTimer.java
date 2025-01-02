package com.ahmeteminsaglik.ws.model.timer;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "patient_timers", uniqueConstraints = @UniqueConstraint(columnNames = "patient_id"))
public class PatientTimer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private long id;
    @Column
    private int hours = 0;
    @Column
    private int minutes = 1;
    @Column(name = "patient_id")
    @NonNull
    private long patientId;

    @Override
    public String toString() {
        return "PatientTimer{" +
                "id=" + id +
                ", hours=" + hours +
                ", minutes=" + minutes +
                ", patientId=" + patientId +
                '}';
    }

    public PatientTimer(int minutes, long patientId) {
        this.minutes = minutes;
        this.patientId = patientId;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getHours() {
        return hours;
    }

    public void setHours(int hours) {
        this.hours = hours;
    }

    public int getMinutes() {
        return minutes;
    }

    public void setMinutes(int minutes) {
        this.minutes = minutes;
    }

    public long getPatientId() {
        return patientId;
    }

    public void setPatientId(long patientId) {
        this.patientId = patientId;
    }
}
