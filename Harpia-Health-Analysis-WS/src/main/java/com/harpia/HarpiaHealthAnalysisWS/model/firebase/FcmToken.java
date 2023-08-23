package com.harpia.HarpiaHealthAnalysisWS.model.firebase;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "firebase_token", uniqueConstraints = @UniqueConstraint(columnNames = "patient_id"))
public class FcmToken {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private long id;

    @Column(name = "patient_id")
    private int patientId;
    @Column
    private String token;

    @Override
    public String toString() {
        return "FcmToken{" +
                "id=" + id +
                ", patientId=" + patientId +
                ", token='" + token + '\'' +
                '}';
    }
}
