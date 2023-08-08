package com.harpia.HarpiaHealthAnalysisWS.model.timer;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "patient_timer", uniqueConstraints = @UniqueConstraint(columnNames = "patient_id"))
public class PatientTimer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private long id;
    @Column
    private int hours;
    @Column
    private int minutes;
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

}
